[![Compila PDF](https://github.com/MemoryLeakersTeam/Documenti/actions/workflows/compila-pdf.yml/badge.svg)](https://github.com/MemoryLeakersTeam/Documenti/actions/workflows/compila-pdf.yml)
# Memory Leakers
Siamo il gruppo 3 del progetto di Ingegneria del Software del corso di laurea in Informatica dell'Università degli Studi di Padova per l'anno accademico 2026/27.

## Documenti
Questa repository raccoglie e organizza i documenti prodotti dal gruppo durante le fasi dello sviluppo del progetto didattico.

### Formato
Il gruppo ha deciso di utilizzare ***Typst*** come formato per il codice sorgente dei documenti (`.typ`).

### PDF più recenti
I documenti approvati vengono pubblicati da soli sul [sito del gruppo](https://memoryleakersteam.github.io) a ogni push su `main`:
- solo i documenti con `stato: "Approvato"`;
- i verbali esterni solo quando c'è la versione firmata (`*-signed.pdf`, committata accanto al sorgente);
- un PDF già pubblicato viene sostituito solo quando cambia la sua `versione`.

Tutti i PDF, anche quelli non ancora approvati, sono nell'artifact `pdf` dell'[ultima compilazione riuscita](https://github.com/MemoryLeakersTeam/Documenti/actions/workflows/compila-pdf.yml?query=branch%3Amain+is%3Asuccess).

### Struttura
I documenti stanno in `<Tappa>/<Cartella>/` (per esempio `Candidatura/Verbali_interni/2026-10-13.typ`). Le cartelle riconosciute dal sito sono `Verbali_interni`, `Verbali_esterni`, `Generali` e `Diario_di_bordo` (PDF committati delle presentazioni). Nei verbali esterni va indicata l'`azienda`, usata per il nome sul sito.

### Versione e registro delle modifiche
Da `RTB/` in poi, versione, stato, verificatore, firma e registro delle modifiche di un documento stanno nel file dei dati `<nome>.yml`, accanto a `<nome>.typ`. Li scrive un'automazione **dopo il merge**: chi scrive il documento non li tocca, e chi verifica non modifica nulla. I documenti di `Candidatura/` restano come sono.

Per un documento nuovo:
- copia `Templates/DatiDocumento.yml` accanto al sorgente come `<nome>.yml`, senza modificarlo;
- passa i dati al template: `#show: documento.with(..., dati: yaml("<nome>.yml"))` (per i verbali `verbale.with`).

Per un documento già su `main` che ha ancora i dati scritti nel sorgente (**migrazione**), `<nome>.yml` riporta i dati così come sono: versione, stato, verificatore, firma e registro, con le date in `AAAA-MM-GG` e la riga più recente in cima. Il controllo ne verifica la forma e segnala la migrazione al Verificatore, che controlla che i valori coincidano con quelli del sorgente su `main`.

Nella pull request:
- metti la label `minor` (modifica sostanziale) oppure `patch` (correzione minore);
- compila la sezione *Registro delle modifiche* della descrizione: diventa la descrizione della riga del registro.

Il controllo **Registro delle modifiche** (`registro-pr.yml`) blocca il merge, e ne scrive il motivo, se la PR modifica un documento senza esattamente una delle due label o con la sezione vuota, se modifica un file `<nome>.yml` già esistente, oppure se non l'ha approvata il Verificatore dello sprint (diverso dall'autore).

Al merge, `registro-modifiche.yml` aggiorna ogni documento modificato con un commit su `main`: versione `0.1.0` se il documento è nuovo, altrimenti X.(Y+1).0 con `minor` e X.Y.(Z+1) con `patch`; riga in cima al registro con data del merge, descrizione, autore e Verificatore; stato «Verificato» e firma del Responsabile tolta, perché il contenuto non è più quello approvato.

I ruoli dello sprint sono in `.github/ruoli.yml` (login GitHub, nome e ruolo): lo aggiorna l'Amministratore, con una PR, a ogni rotazione dei ruoli.

## Issue
Ogni issue si apre con uno dei moduli di *New issue*: le issue vuote sono disattivate.

| Modulo | Quando usarlo |
|---|---|
| Documento | stesura o modifica di un documento (WoW, Piano di Progetto, Analisi dei Requisiti, diario di bordo, template) |
| Verbale interno | verbale di una riunione del gruppo |
| Verbale esterno | verbale di una riunione con un'azienda; la PR si integra con l'approvazione del Verificatore (versione 0.1.0); il Responsabile rilascia la 1.0.0 e la invia all'azienda per la firma; il PDF firmato arriva con una seconda PR che chiude l'issue |
| Strumento, CI o automazione | workflow, script e altri strumenti del repository |
| Analisi (senza PR) | studio di un tema o preparazione di una riunione, che si chiude con un output linkato nell'issue |

Regole:
- le issue le apre l'**Amministratore**;
- ogni issue ha **una sola persona** assegnata e una **scadenza** in formato `AAAA-MM-GG`;
- l'**origine** è la riunione in cui è stata decisa l'attività, oppure «Proposta di @nome»; gli ID delle decisioni e delle attività (D, A) li assegna il verbale;
- la **Definition of Done** la spunta l'assegnatario; la sezione **Verifica** la spunta solo il verificatore, che non modifica il prodotto ma lascia commenti;
- una PR chiude solo la sua issue (`Closes #n`); le altre issue si citano con `Refs #n`. Per un verbale esterno, l'issue la chiude la PR del PDF firmato;
- lo studio individuale («palestra») non ha una sua issue.
