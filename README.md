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

Il controllo **Registro delle modifiche** (`registro-pr.yml`) blocca il merge, e ne scrive il motivo, se la PR modifica un documento senza esattamente una delle due label o con la sezione vuota, se modifica un file `<nome>.yml` già esistente, oppure se non l'ha approvata il Verificatore dello sprint (diverso dall'autore). Dopo una review il controllo si riesegue da solo (`registro-review.yml`).

Se un autore diventa Verificatore mentre la sua PR è aperta, il lavoro passa al membro che entra al suo posto: chiude la PR e ne apre una nuova dallo stesso branch, così ne è l'autore e il Verificatore può approvarla.

Un documento si sposta (per esempio da `RTB/` a `PB/`) con `git mv`, insieme al suo `<nome>.yml` e senza modificarlo: così versione e registro restano. Lo spostamento conta come modifica: serve la label, e dopo il merge il documento ha una versione nuova ed è «Verificato». Un documento copiato invece è nuovo e riparte dal modello.

Al merge, `registro-modifiche.yml` aggiorna ogni documento modificato con un commit su `main`: versione `0.1.0` se il documento è nuovo, altrimenti X.(Y+1).0 con `minor` e X.Y.(Z+1) con `patch`; riga in cima al registro con data del merge, descrizione, autore e Verificatore; stato «Verificato» e firma del Responsabile tolta, perché il contenuto non è più quello approvato.

Se l'automazione fallisce (per esempio per un push rifiutato), basta rieseguire il job dalla pagina del workflow: una PR già registrata non viene registrata due volte. Un errore nei dati di un documento, per esempio una descrizione sbagliata nel registro, si corregge con una PR a parte con la label `correzione-registro`:
- la PR modifica solo file `<nome>.yml` già esistenti, nella forma giusta, e non cambia stato e firma;
- non servono la label `minor` o `patch` né la sezione *Registro delle modifiche*, ma serve l'approvazione del Verificatore, che controlla i valori nel diff;
- dopo il merge non c'è una versione nuova. Il PDF si ricompila, ma il sito sostituisce un PDF già pubblicato solo quando cambia la versione.

I ruoli dello sprint sono in `.github/ruoli.yml` (login GitHub, nome e ruolo): lo aggiorna l'Amministratore, con una PR, a ogni rotazione dei ruoli.

### Rilascio
Il rilascio di un documento lo approva il Responsabile, senza pull request. Dalla scheda *Actions* sceglie **Rilascio** → *Run workflow*, lascia il ramo `main` e indica i documenti da rilasciare, separati da spazi o virgole (per esempio `RTB/Generali/norme-di-progetto RTB/Verbali_interni/2026-11-10`, con o senza `.typ`).

Il workflow (`rilascio.yml`) controlla che chi lo avvia sia il Responsabile in `.github/ruoli.yml` e che ogni documento abbia il suo `<nome>.yml` e sia «Verificato». Se un controllo fallisce non modifica nessun documento e scrive il motivo nel riepilogo dell'esecuzione. Altrimenti, per ogni documento:
- porta la versione da X.Y.Z a (X+1).0.0: il primo rilascio è `1.0.0`, il successivo `2.0.0`;
- aggiunge in cima al registro la riga «Approvazione per il rilascio», con la data del rilascio, il Responsabile come autore e nessun verificatore;
- imposta lo stato «Approvato» e la firma del Responsabile.

Infine fa un solo commit su `main` per tutti i documenti: il commit fa ripartire la compilazione, che pubblica i documenti sul sito. Se il Responsabile è autore di una modifica inclusa nel rilascio, il riepilogo lo segnala, ma il rilascio si fa lo stesso. Un verbale esterno, dopo il rilascio a `1.0.0`, si invia all'azienda per la firma: il PDF firmato entra con una PR a parte.

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
