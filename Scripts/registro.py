#!/usr/bin/env python3
"""Registro delle modifiche automatico dei documenti (da RTB/ in poi).

Due comandi:
  controlla  controllo obbligatorio sulle pull request verso main
             (workflow registro-pr.yml): label minor/patch, sezione
             «Registro delle modifiche» compilata, file dei dati non toccati,
             approvazione del Verificatore dello sprint;
  aggiorna   dopo il merge (workflow registro-modifiche.yml): per ogni
             documento modificato aggiorna versione, stato e verificatore e
             aggiunge la riga in cima al registro, nel file <nome>.yml.

I dati della pull request li scarica il workflow dall'API di GitHub:
  --pr       la pull request              (GET /repos/{repo}/pulls/{n})
  --review   le review, una JSON per riga (GET /repos/{repo}/pulls/{n}/reviews)
  --file     i file, uno JSON per riga    (GET /repos/{repo}/pulls/{n}/files)
  --ruoli    .github/ruoli.yml, nella versione su main

Usa solo la libreria standard di Python. I file YAML li legge Typst
(typst eval), cioè lo stesso parser con cui li leggono i documenti.
"""

import argparse
import copy
import functools
import json
import os
import re
import subprocess
import sys
from datetime import datetime
from pathlib import Path, PurePosixPath
from zoneinfo import ZoneInfo

# Cartelle di primo livello i cui file non sono documenti gestiti dal registro.
# Candidatura/ è consegnata e resta com'è; le cartelle nascoste (.github) sono escluse
ESCLUSE = {"Templates", "Candidatura", "Scripts"}
MODELLO = "Templates/DatiDocumento.yml"
LABEL = ("minor", "patch")
SEZIONE = "Registro delle modifiche"
RUOLO_VERIFICATORE = "Verificatore"
STATO_VERIFICATO = "Verificato"
FUSO = ZoneInfo("Europe/Rome")
# Stati di review che cambiano l'approvazione (un semplice commento non la cambia)
STATI_REVIEW = {"APPROVED", "CHANGES_REQUESTED", "DISMISSED"}

INTESTAZIONE = """\
# Dati del documento gestiti dall'automazione del registro delle modifiche
# (Scripts/registro.py): dopo ogni merge aggiorna versione, stato,
# verificatore e registro. Non modificare questo file a mano.
"""


class Errore(Exception):
    """Problema che impedisce di proseguire."""


# ---------------------------------------------------------------------------
# Messaggi: annotazioni di GitHub Actions, testo semplice in locale

IN_ACTIONS = os.environ.get("GITHUB_ACTIONS") == "true"


def segnala(livello, messaggio):
    if IN_ACTIONS:
        testo = messaggio.replace("%", "%25").replace("\r", "%0D").replace("\n", "%0A")
        print(f"::{livello} title=Registro delle modifiche::{testo}")
    else:
        print(f"{livello}: {messaggio}", file=sys.stderr)


def riepilogo(righe):
    """Scrive il riepilogo nella pagina del workflow (o sullo standard output)."""
    testo = "\n".join(righe) + "\n"
    percorso = os.environ.get("GITHUB_STEP_SUMMARY")
    if percorso:
        with open(percorso, "a", encoding="utf-8") as f:
            f.write(testo)
    print(testo)


# ---------------------------------------------------------------------------
# File YAML e JSON

@functools.cache
def _leggi_yaml(percorso):
    p = Path(percorso)
    comando = ["typst", "eval", "--root", str(p.parent), f"yaml({json.dumps(p.name, ensure_ascii=False)})"]
    r = subprocess.run(comando, capture_output=True, text=True)
    if r.returncode != 0:
        raise Errore(f"{percorso}: file YAML non leggibile\n{r.stderr.strip()}")
    return json.loads(r.stdout)


def leggi_yaml(percorso):
    """Dati del file YAML. Ogni file si legge una volta sola (ogni lettura avvia
    typst); si restituisce una copia, così chi la modifica non tocca la cache."""
    return copy.deepcopy(_leggi_yaml(str(Path(percorso).resolve())))


def metadati_documento(radice, typ):
    """Dati con cui il documento compilato si presenta (<documento> dei template)."""
    comando = ["typst", "eval", "--root", str(radice)]
    if (radice / "Templates/Fonts").is_dir():
        comando += ["--font-path", str(radice / "Templates/Fonts")]
    comando += ["--in", str(typ), "query(<documento>).map(m => m.value)"]
    r = subprocess.run(comando, capture_output=True, text=True)
    if r.returncode != 0:
        raise Errore(f"`{typ.relative_to(radice)}` non compila:\n{r.stderr.strip()}")
    valori = json.loads(r.stdout)
    return valori[0] if valori else {}


CHIAVE_SEMPLICE = re.compile(r"^[A-Za-z_][A-Za-z0-9_-]*$")


def _chiave(k):
    return k if CHIAVE_SEMPLICE.match(k) else json.dumps(k, ensure_ascii=False)


def _scalare(v):
    # Una stringa JSON è anche una stringa YAML tra virgolette doppie
    return json.dumps(v, ensure_ascii=False)


def _righe_yaml(valore, rientro):
    spazi = " " * rientro
    righe = []
    if isinstance(valore, dict):
        for k, v in valore.items():
            if isinstance(v, (dict, list)) and v:
                righe.append(f"{spazi}{_chiave(k)}:")
                righe += _righe_yaml(v, rientro + 2)
            else:
                righe.append(f"{spazi}{_chiave(k)}: {_scalare(v)}")
    else:
        for v in valore:
            if isinstance(v, (dict, list)) and v:
                interne = _righe_yaml(v, rientro + 2)
                interne[0] = f"{spazi}- {interne[0].lstrip()}"
                righe += interne
            else:
                righe.append(f"{spazi}- {_scalare(v)}")
    return righe


def scrivi_yaml(percorso, dati):
    """Scrive i dati in forma canonica: il file lo gestisce solo l'automazione."""
    Path(percorso).write_text(INTESTAZIONE + "\n".join(_righe_yaml(dati, 0)) + "\n", encoding="utf-8")


def leggi_json(percorso):
    with open(percorso, encoding="utf-8") as f:
        return json.load(f)


def leggi_jsonl(percorso):
    with open(percorso, encoding="utf-8") as f:
        return [json.loads(riga) for riga in f if riga.strip()]


# ---------------------------------------------------------------------------
# Regole

def leggi_ruoli(percorso):
    """Restituisce i dati dello sprint e i membri indicizzati per login (minuscolo)."""
    dati = leggi_yaml(percorso)
    membri = {m["login"].lower(): m for m in dati.get("membri") or []}
    return dati.get("sprint") or {}, membri


def nome(membri, login):
    membro = membri.get(login.lower())
    if membro:
        return membro["nome"]
    segnala("warning", f"@{login} non è in .github/ruoli.yml: nel registro compare il suo login")
    return login


def documento(percorso):
    """Radice (percorso senza estensione) del documento a cui appartiene il file,
    se è il sorgente .typ o i dati .yml di un documento gestito dal registro."""
    p = PurePosixPath(percorso)
    if p.suffix not in (".typ", ".yml") or len(p.parts) < 2:
        return None
    if p.parts[0] in ESCLUSE or p.parts[0].startswith("."):
        return None
    return str(p.with_suffix(""))


def documenti_toccati(file_pr):
    """Documenti toccati dalla PR, ognuno con le voci dei suoi file.
    Un file rinominato conta anche come eliminato dal percorso precedente."""
    documenti = {}
    for f in file_pr:
        d = documento(f["filename"])
        if d:
            documenti.setdefault(d, []).append(f)
        precedente = f.get("previous_filename")
        if precedente and (dp := documento(precedente)):
            documenti.setdefault(dp, []).append({"filename": precedente, "status": "removed"})
    return dict(sorted(documenti.items()))


def label_versione(pr):
    return sorted({l["name"] for l in pr.get("labels") or []} & set(LABEL))


def descrizione_registro(corpo):
    """Testo della sezione «Registro delle modifiche» della descrizione della PR,
    su una riga. I commenti HTML si ignorano; la sezione finisce al primo titolo
    dello stesso livello o superiore (un sottotitolo non la chiude). Le voci di un
    elenco e i paragrafi si separano con «;», le righe a capo di una stessa frase
    si uniscono con uno spazio."""
    testo = re.sub(r"<!--.*?-->", "", (corpo or "").replace("\r\n", "\n"), flags=re.S)
    livello, voci, nuova = None, [], True
    for riga in testo.split("\n"):
        titolo = re.match(r"^ {0,3}(#{1,6})\s+(.*?)[\s#]*$", riga)
        if titolo:
            n = len(titolo.group(1))
            if livello is None:
                if titolo.group(2).strip().lower() == SEZIONE.lower():
                    livello = n
            elif n <= livello:
                break
            nuova = True
            continue
        if livello is None:
            continue
        if not riga.strip():
            nuova = True
            continue
        elenco = re.match(r"^\s*(?:[-*+]|\d+[.)])\s+(.*)$", riga)
        parte = (elenco.group(1) if elenco else riga).strip()
        if elenco or nuova:
            voci.append(parte)
        else:
            voci[-1] += " " + parte
        nuova = False
    voci = [v.strip().rstrip(";").strip() for v in voci]
    voci = [v for v in voci if v]
    # Il punto finale resta solo all'ultima voce: «Primo; Secondo.», non «Primo.; Secondo.»
    return "; ".join([v.rstrip(".") for v in voci[:-1]] + voci[-1:])


def prossima_versione(dati, label):
    """Documento nuovo (registro vuoto): 0.1.0. Altrimenti minor: X.(Y+1).0, patch: X.Y.(Z+1)."""
    if not dati.get("registro"):
        return "0.1.0"
    m = re.fullmatch(r"(\d+)\.(\d+)\.(\d+)", str(dati.get("versione", "")))
    if not m:
        raise Errore(f"versione «{dati.get('versione')}» non nel formato X.Y.Z")
    x, y, z = map(int, m.groups())
    return f"{x}.{y + 1}.0" if label == "minor" else f"{x}.{y}.{z + 1}"


def ultime_review(review):
    """Ultima review che conta per ogni login (minuscolo), in ordine cronologico."""
    ultime = {}
    for r in sorted(review, key=lambda r: (r.get("submitted_at") or "", r.get("id", 0))):
        if r.get("state") in STATI_REVIEW and r.get("user"):
            login = r["user"]["login"].lower()
            ultime.pop(login, None)  # così l'ordine del dizionario resta cronologico
            ultime[login] = r
    return ultime


def verificatori(membri):
    return [l for l, m in membri.items() if m.get("ruolo") == RUOLO_VERIFICATORE]


# ---------------------------------------------------------------------------
# controlla

def controlla(a):
    pr = leggi_json(a.pr)
    review = leggi_jsonl(a.review)
    file_pr = leggi_jsonl(a.file)
    sprint, membri = leggi_ruoli(a.ruoli)
    radice = Path(a.radice)

    autore = pr["user"]["login"]
    label = label_versione(pr)
    descrizione = descrizione_registro(pr.get("body"))
    errori = []

    # Documenti toccati: dati presenti, letti dal sorgente e non modificati a mano
    modificati = []
    for d, voci in documenti_toccati(file_pr).items():
        typ, yml = radice / f"{d}.typ", radice / f"{d}.yml"
        nome_yml = f"{PurePosixPath(d).name}.yml"
        if not typ.exists():
            if yml.exists():
                errori.append(f"`{d}.yml` resta senza il sorgente `{d}.typ`: elimina anche il file dei dati, oppure ripristina il sorgente.")
            continue
        modificati.append(d)
        if not yml.exists():
            errori.append(f"`{d}.typ` non ha il file dei dati `{d}.yml`: copialo da `{MODELLO}` senza modificarlo.")
            continue
        # Il documento compilato deve mostrare i dati del suo .yml, comunque li legga
        try:
            dati, meta = leggi_yaml(yml), metadati_documento(radice, typ)
            if (meta.get("versione"), meta.get("stato")) != (dati.get("versione"), dati.get("stato")):
                errori.append(
                    f"`{d}.typ` non mostra i dati di `{d}.yml` (versione e stato): "
                    f'passa al template `dati: yaml("{nome_yml}")` e non scrivere versione, stato e registro nel sorgente.'
                )
        except Errore as e:
            errori.append(str(e))
        for v in voci:
            if v["filename"] != f"{d}.yml":
                continue
            if v["status"] in ("added", "copied"):
                if leggi_yaml(yml) != leggi_yaml(radice / MODELLO):
                    errori.append(f"`{d}.yml` è nuovo ma è diverso da `{MODELLO}`: copialo senza modificarlo, i dati li scrive l'automazione dopo il merge.")
            elif v["status"] == "renamed" and v.get("changes", 0) == 0:
                pass  # spostato insieme al documento, senza modifiche
            else:
                errori.append(
                    f"La PR modifica o elimina `{d}.yml`: versione, stato, verificatore, firma e registro "
                    f"li aggiorna l'automazione dopo il merge. Annulla la modifica con "
                    f"`git checkout origin/main -- \"{d}.yml\"`."
                )

    # Label e descrizione della riga del registro
    if modificati:
        if len(label) != 1:
            trovate = f" (ora: {', '.join(label)})" if label else ""
            errori.append(
                "La PR modifica dei documenti ma non ha esattamente una label tra "
                f"`minor` (modifica sostanziale) e `patch` (correzione minore){trovate}."
            )
        if not descrizione:
            errori.append(
                f"La sezione «{SEZIONE}» della descrizione della PR è vuota: "
                "scrivi cosa cambia, diventerà la descrizione della riga del registro."
            )

    # Approvazione del Verificatore dello sprint, diverso dall'autore
    tutti = verificatori(membri)
    validi = [v for v in tutti if v != autore.lower()]
    ultime = ultime_review(review)
    approvato_da = None
    if not tutti:
        errori.append(f"In `.github/ruoli.yml` su main nessuno ha il ruolo «{RUOLO_VERIFICATORE}».")
    elif not validi:
        errori.append(
            f"L'autore della PR (@{autore}) è il Verificatore dello sprint: "
            "la PR deve approvarla un Verificatore diverso dall'autore."
        )
    else:
        chi = ", ".join(f"@{membri[v]['login']}" for v in validi)
        approvazioni = [v for v in validi if ultime.get(v, {}).get("state") == "APPROVED"]
        attuali = [v for v in approvazioni if ultime[v].get("commit_id") == pr["head"]["sha"]]
        if attuali:
            approvato_da = membri[attuali[-1]]["nome"]
        elif approvazioni:
            errori.append(f"L'approvazione del Verificatore dello sprint ({chi}) è su un commit precedente: serve una nuova approvazione dell'ultimo commit.")
        else:
            errori.append(f"Manca l'approvazione del Verificatore dello sprint ({chi}).")

    fine = sprint.get("fine")
    if fine and fine < datetime.now(FUSO).date().isoformat():
        segnala("warning", f"Lo sprint di .github/ruoli.yml è finito il {fine}: l'Amministratore deve aggiornare i ruoli.")

    # Riepilogo, con l'anteprima delle versioni dopo il merge
    righe = ["### Registro delle modifiche", ""]
    if modificati:
        righe.append(f"- Label: {', '.join(f'`{l}`' for l in label) or 'nessuna'}")
        righe.append(f"- Descrizione: {descrizione or '_vuota_'}")
        righe.append(f"- Autore: {nome(membri, autore)}")
        righe.append(f"- Verificatore: {approvato_da or '_manca l’approvazione_'}")
        righe += ["", "| Documento | Versione su main | Dopo il merge |", "|---|---|---|"]
        for d in modificati:
            yml = radice / f"{d}.yml"
            prima, dopo = "—", "—"
            if yml.exists():
                try:
                    dati = leggi_yaml(yml)
                    prima = "nuovo" if not dati.get("registro") else dati.get("versione", "—")
                    if len(label) == 1:
                        dopo = prossima_versione(dati, label[0])
                except Errore as e:
                    errori.append(str(e))
            righe.append(f"| `{d}` | {prima} | {dopo} |")
    else:
        righe.append("La PR non modifica documenti gestiti dal registro.")
        righe.append(f"Verificatore: {approvato_da or '_manca l’approvazione_'}")

    if errori:
        righe += ["", "#### Da correggere", ""] + [f"- {e}" for e in errori]
        for e in errori:
            segnala("error", e)
    else:
        righe += ["", "✅ Controllo superato."]
    riepilogo(righe)
    return 1 if errori else 0


# ---------------------------------------------------------------------------
# aggiorna

def scegli_verificatore(review, membri, autore):
    """Il Verificatore dello sprint che ha approvato; se nel frattempo i ruoli sono
    cambiati, l'ultima persona che ha approvato."""
    approvazioni = [
        r for l, r in ultime_review(review).items()
        if r["state"] == "APPROVED" and l != autore.lower()
    ]
    if not approvazioni:
        raise Errore("La PR è stata integrata senza approvazioni: aggiorna a mano il file dei dati e il registro.")
    dello_sprint = [r for r in approvazioni if membri.get(r["user"]["login"].lower(), {}).get("ruolo") == RUOLO_VERIFICATORE]
    if dello_sprint:
        return nome(membri, dello_sprint[-1]["user"]["login"])
    login = approvazioni[-1]["user"]["login"]
    segnala("warning", f"Nessuna approvazione del Verificatore dello sprint attuale: nel registro va chi ha approvato per ultimo (@{login}).")
    return nome(membri, login)


def aggiorna(a):
    pr = leggi_json(a.pr)
    review = leggi_jsonl(a.review)
    file_pr = leggi_jsonl(a.file)
    _, membri = leggi_ruoli(a.ruoli)
    radice = Path(a.radice)
    numero = pr["number"]

    documenti = [d for d in documenti_toccati(file_pr) if (radice / f"{d}.typ").exists()]
    if not documenti:
        riepilogo(["### Registro delle modifiche", "", f"La PR #{numero} non modifica documenti gestiti dal registro."])
        return 0

    label = label_versione(pr)
    if len(label) != 1:
        raise Errore(f"La PR #{numero} modifica dei documenti ma non ha esattamente una label tra minor e patch.")
    descrizione = descrizione_registro(pr.get("body"))
    if not descrizione:
        raise Errore(f"La sezione «{SEZIONE}» della PR #{numero} è vuota.")
    autore = nome(membri, pr["user"]["login"])
    verificatore = scegli_verificatore(review, membri, pr["user"]["login"])
    data = datetime.fromisoformat(pr["merged_at"].replace("Z", "+00:00")).astimezone(FUSO).date().isoformat()

    # Prima si calcola tutto, poi si scrive: o si aggiornano tutti i documenti o nessuno
    aggiornati = []
    for d in documenti:
        yml = radice / f"{d}.yml"
        if not yml.exists():
            raise Errore(f"`{d}.typ` non ha il file dei dati `{d}.yml`.")
        dati = leggi_yaml(yml)
        prima = "nuovo" if not dati.get("registro") else dati.get("versione")
        try:
            dati["versione"] = prossima_versione(dati, label[0])
        except Errore as e:
            raise Errore(f"{d}.yml: {e}") from None
        dati["stato"] = STATO_VERIFICATO
        dati["verificatore"] = verificatore
        # Il contenuto è cambiato dopo l'ultimo rilascio: la firma la rimette il
        # Responsabile al prossimo rilascio (#66)
        dati["firma-responsabile"] = ""
        riga = {
            "versione": dati["versione"],
            "data": data,
            "descrizione": descrizione,
            "autore": autore,
            "verificatore": verificatore,
        }
        dati["registro"] = [riga] + list(dati.get("registro") or [])
        aggiornati.append((d, yml, dati, prima))

    for _, yml, dati, _ in aggiornati:
        scrivi_yaml(yml, dati)

    elenco = [f"- {d}: {prima} -> {dati['versione']}" for d, _, dati, prima in aggiornati]
    if a.messaggio:
        Path(a.messaggio).write_text(
            f"docs(changelog): record changes merged in #{numero}\n\n"
            + "\n".join(elenco)
            + f"\n\nRefs: #{numero}\n",
            encoding="utf-8",
        )
    riepilogo(
        ["### Registro delle modifiche", "", f"PR #{numero}, {label[0]}: «{descrizione}»",
         f"Autore: {autore}; verificatore: {verificatore}; data: {data}", ""] + elenco
    )
    return 0


# ---------------------------------------------------------------------------

def main():
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    comandi = parser.add_subparsers(dest="comando", required=True)
    for nome_comando, funzione in (("controlla", controlla), ("aggiorna", aggiorna)):
        p = comandi.add_parser(nome_comando)
        p.set_defaults(funzione=funzione)
        p.add_argument("--pr", required=True, help="JSON della pull request")
        p.add_argument("--review", required=True, help="review della PR, una JSON per riga")
        p.add_argument("--file", required=True, help="file della PR, uno JSON per riga")
        p.add_argument("--ruoli", required=True, help=".github/ruoli.yml nella versione su main")
        p.add_argument("--radice", default=".", help="cartella del repository (predefinita: .)")
        if nome_comando == "aggiorna":
            p.add_argument("--messaggio", help="file in cui scrivere il messaggio del commit")
    a = parser.parse_args()
    try:
        return a.funzione(a)
    except Errore as e:
        segnala("error", str(e))
        return 1


if __name__ == "__main__":
    sys.exit(main())
