#!/usr/bin/env bash
# ---------------------------------------------------------------------
#  Compila tutti i documenti .typ del repository in PDF.
#  - Esclude la cartella Templates/
#  - I PDF finiscono in pdf/ mantenendo la stessa struttura di cartelle:
#      Candidatura/Verbali_interni/2026-10-13.typ
#        → pdf/Candidatura/Verbali_interni/2026-10-13.pdf
#  - Copia in pdf/ anche i PDF committati: i verbali firmati (*-signed.pdf)
#    e i Diari di bordo (*/Diario_di_bordo/*.pdf)
#  - Genera pdf/elenco.json con l'elenco dei PDF e i dati del documento
#    (titolo, data, stato, versione...), letti dal metadato <documento>
#    dei template: li usa il sito per pubblicare i documenti
#  Richiede typst e jq.
# ---------------------------------------------------------------------
set -euo pipefail

OUT="pdf"
rm -rf "$OUT"
mkdir -p "$OUT"

# Configurazione fissa del percorso dei font
FONT_ARGS=()
if [ -d "Templates/Fonts" ]; then
  FONT_ARGS=("--font-path" "Templates/Fonts")
fi

# Una riga JSON per ogni PDF; alla fine diventano pdf/elenco.json
voci="$OUT/.voci.jsonl"
: > "$voci"

# Aggiunge una voce all'elenco: percorso del PDF, sorgente, dati del documento
# (oggetto JSON) e verbale firmato ("" se non c'è)
aggiungi_voce() {
  jq -n -c --arg percorso "$1" --arg sorgente "$2" --argjson meta "$3" --arg firmato "$4" '
    ($percorso | split("/")) as $p
    | {
        percorso: $percorso,
        sorgente: (if $sorgente == "" then null else $sorgente end),
        tappa: $p[0],
        cartella: $p[-2],
        nome: ($p[-1] | rtrimstr(".pdf"))
      }
    + $meta
    + {firmato: (if $firmato == "" then null else $firmato end)}' >> "$voci"
}

errori=0
while IFS= read -r -d '' file; do
  rel="${file#./}"
  pdf="${rel%.typ}.pdf"
  dest="$OUT/$pdf"
  mkdir -p "$(dirname "$dest")"
  echo "▶ $rel"
  # Data del PDF = data dell'ultimo commit del sorgente o dei suoi dati (<nome>.yml):
  # così un PDF cambia (e viene ripubblicato) solo se uno dei due è cambiato
  ts="$(git log -1 --format=%ct -- "$rel" "${rel%.typ}.yml" 2>/dev/null || true)"
  export SOURCE_DATE_EPOCH="${ts:-$(date +%s)}"
  if ! typst compile --root . "${FONT_ARGS[@]}" "$rel" "$dest"; then
    echo "✖ Errore nella compilazione di $rel"
    errori=$((errori + 1))
    continue
  fi

  # Dati del documento, emessi dai template con #metadata(...) <documento>.
  # Se la lettura fallisce si interrompe tutto: un elenco incompleto farebbe
  # sembrare il documento non più approvato
  if ! meta="$(typst eval --root . "${FONT_ARGS[@]}" --in "$rel" 'query(<documento>).map(m => m.value)')"; then
    echo "✖ Errore nella lettura dei metadati di $rel"
    errori=$((errori + 1))
    continue
  fi
  if [ "$(jq length <<<"$meta")" -eq 0 ]; then
    echo "::warning file=$rel::Nessun metadato <documento>: il documento non verrà pubblicato sul sito"
  fi

  # Verbale firmato dall'azienda, committato accanto al sorgente
  firmato="${rel%.typ}-signed.pdf"
  if [ -f "$firmato" ]; then
    cp "$firmato" "$OUT/$firmato"
  else
    firmato=""
  fi

  aggiungi_voce "$pdf" "$rel" "$(jq -c '.[0] // {}' <<<"$meta")" "$firmato"
done < <(find . -name '*.typ' -not -path './Templates/*' -not -path "./$OUT/*" -not -path './.git/*' -print0 | sort -z)

# Diari di bordo: PDF committati senza sorgente, pubblicati così come sono.
# La data viene dal nome del file (AAAA-MM-GG.pdf), la versione dal contenuto,
# così un PDF sostituito nel repository viene ripubblicato
while IFS= read -r -d '' file; do
  rel="${file#./}"
  echo "▶ $rel"
  mkdir -p "$(dirname "$OUT/$rel")"
  cp "$rel" "$OUT/$rel"
  data="$(basename "$rel" .pdf | grep -oE '^[0-9]{4}-[0-9]{2}-[0-9]{2}' || true)"
  meta="$(jq -n -c --arg data "$data" --arg versione "$(git hash-object "$rel" | cut -c1-8)" \
    '{data: $data, stato: "Approvato", versione: $versione, "tipo-documento": "Diario di bordo"}')"
  aggiungi_voce "$rel" "" "$meta" ""
done < <(find . -path '*/Diario_di_bordo/*.pdf' -not -path './Templates/*' -not -path "./$OUT/*" -not -path './.git/*' -print0 | sort -z)

jq -s '.' "$voci" > "$OUT/elenco.json"
rm -f "$voci"

if [ "$errori" -gt 0 ]; then
  echo "✖ $errori documento/i non compilato/i"
  exit 1
fi
echo "✔ Tutti i documenti compilati in $OUT/"
