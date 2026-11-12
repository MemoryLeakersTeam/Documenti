#import "../../Templates/DocumentiGenerici.typ": *

#show: documento.with(
  titolo: "Norme di Progetto",
  sottotitolo: "",
  tipo-documento: "Documento Interno",
  versione: "0.1.0",
  autore: "Jacopo De Donà",
  verificatore: "",
  stato: "Bozza",
  data: datetime(year: 2026, month: 11, day: 11),
  file-nome: "norme-di-progetto.pdf",
  // Ogni riga: (Ver., Data, Descrizione, Autore, Verificatore), dalla più recente
  registro-modifiche: (
    ([0.1.0], [2026-11-11], [Prima stesura: struttura per processi, regole del _Way of Working_ 1.0.0 riscritte come procedure, nuove regole su issue, verbali e verifica], [Jacopo De Donà], []),
  ),
  firma-responsabile: "",
)

#set heading(numbering: "1.1.1")

// Collegamento a una voce del glossario sul sito
#let g(id, termine) = gloss(url: "https://memoryleakersteam.github.io/glossario#" + id)[#termine]

// Scheda di una procedura: chi la esegue, cosa serve, cosa produce, con quali strumenti
#let procedura(chi: [], input: [], output: [], strumenti: [], passi) = {
  table(
    columns: (auto, 1fr),
    inset: 7pt,
    stroke: 0.5pt + rgb("#49736a"),
    fill: (x, y) => if x == 0 { rgb("#eaf7f2") } else { none },
    [*Chi*], chi,
    [*Input*], input,
    [*Output*], output,
    [*Strumenti*], strumenti,
  )
  passi
}

// Tabella con intestazione colorata, come nel resto della documentazione
#let tabella(colonne, intestazione, ..celle) = table(
  columns: colonne,
  inset: 7pt,
  stroke: 0.5pt + rgb("#49736a"),
  fill: (x, y) => if y == 0 { rgb("#305b57") } else if calc.even(y) { rgb("#eaf7f2") } else { none },
  table.header(..intestazione.map(t => [*#text(fill: white)[#t]*])),
  ..celle,
)

= Introduzione

== Scopo del documento

Le Norme di Progetto stabiliscono come lavora il gruppo _Memory Leakers_ nel #g("progetto", "progetto") didattico: quali #g("processo", "processi") sono attivi, con quali #g("procedura", "procedure") si svolgono e con quali strumenti. Una volta approvate, valgono dalla fase di #g("rtb", "RTB") e sostituiscono il #g("way-of-working", "Way of Working") 1.0.0 della candidatura, che resta invariato come documento consegnato.

Ogni membro del gruppo applica queste norme. Chi trova una regola poco chiara, superata o mancante chiede all'#g("amministratore", "Amministratore") di aprire un'#g("issues", "issue") del modulo *Documento* sulle Norme di Progetto, con origine «Proposta di \@nome» (@apertura).

== Organizzazione del documento

Il documento segue la classificazione dei processi dello standard #g("iso-iec-12207", "ISO/IEC 12207"):
- *processi primari* (@primari): le attività verso il #g("proponente", "proponente") e la realizzazione del prodotto;
- *processi di supporto* (@supporto): documentazione, gestione della configurazione e verifica;
- *processi organizzativi* (@organizzativi): gestione del gruppo e degli strumenti di lavoro.

Ogni procedura indica chi la esegue, cosa serve per cominciare (input), cosa produce (output), gli strumenti e i passi da seguire.

Il documento è incrementale: contiene solo i processi già attivi. Un processo nuovo, per esempio l'analisi dei requisiti, si aggiunge con una sua issue *prima* che il gruppo cominci a svolgerlo.

== Glossario

I termini con pedice #sub[G] rimandano alla voce corrispondente del #g("glossario", "glossario") sul sito del gruppo. Il pedice è indicato alla prima occorrenza del termine nel documento.

== Riferimenti

=== Riferimenti normativi
- Regolamento del progetto didattico (PD1), Ingegneria del Software, A.A. 2026/2027;
  // TODO(dato): link al PD1 e data di consultazione
- Capitolato C6 «SCSDF», Var Group S.p.A.
  // TODO(dato): link al capitolato e data di consultazione

=== Riferimenti informativi
- _Way of Working_ v1.0.0, Memory Leakers, autore Riccardo Peresson, 2026-10-29: `Candidatura/Generali/WoW.typ` nel #g("repository", "repository") `Documenti`;
- ISO/IEC 12207:1995, _Information technology — Software life cycle processes_. La divisione in processi primari, di supporto e organizzativi è di questa edizione;
  // TODO(dato): link allo standard e data di consultazione
- _Conventional Commits_ 1.0.0: #link("https://www.conventionalcommits.org/it/v1.0.0/")[conventionalcommits.org/it/v1.0.0], consultato il 2026-11-11.

= Processi primari <primari>

== Fornitura

La fornitura comprende i rapporti con il proponente, Var Group S.p.A., e con le altre aziende incontrate dal gruppo.

=== Comunicazione con il proponente

#procedura(
  chi: [#g("responsabile", "Responsabile")],
  input: [Una richiesta o un'informazione da comunicare al proponente],
  output: [Email inviata dall'indirizzo del gruppo],
  strumenti: [Gmail, indirizzo #link("mailto:memoryleakersteam@gmail.com")[memoryleakersteam\@gmail.com]],
)[
  + Il Responsabile scrive l'email dall'indirizzo del gruppo.
  + Per Var Group, l'oggetto ha la forma `SWE 2026 | <oggetto>` e tutti i referenti del capitolato sono in copia.
  + Il Responsabile riporta la risposta al gruppo nel canale #g("telegram", "Telegram") «Riunioni esterne», entro il giorno lavorativo successivo.
]

=== Riunione esterna

#procedura(
  chi: [Responsabile; Amministratore; redattore del verbale],
  input: [Data della riunione concordata con l'azienda],
  output: [Verbale esterno firmato dall'azienda],
  strumenti: [#g("github", "GitHub") (issue), Gmail],
)[
  + L'Amministratore apre un'issue del modulo *Analisi* (@issue) per preparare le domande, assegnata a una persona. Le domande sono pronte entro il giorno lavorativo precedente la riunione.
  + Alla fine della riunione, il Responsabile sceglie il redattore del verbale.
  + L'Amministratore apre l'issue del verbale con il modulo *Verbale esterno*, assegnata al redattore.
  + Il redattore scrive il verbale seguendo la procedura dei verbali (@verbali).
]

= Processi di supporto <supporto>

== Documentazione

=== Lingua e stile

- Tutti i prodotti del progetto sono in italiano, tranne i messaggi di #g("commit", "commit"), che sono in inglese.
- Le date sono nel formato `AAAA-MM-GG`, anche nei titoli e nei nomi dei file e dei #g("branch", "branch"). I documenti già consegnati non si correggono.
  // TODO: i template stampano alcune date nel formato GG/MM/AAAA; si correggono con un'issue a parte
- Le parole accentate si scrivono con l'accento, non con l'apostrofo: «libertà», non «liberta'».
- Come linea guida, non verificata con una checklist: le frasi sono brevi, con verbi in forma attiva e un solo argomento; gli elenchi sono liste puntate, non frasi lunghe.

=== Strumenti e template

#tabella(
  (auto, 1fr),
  ("Prodotto", "Strumento"),
  [Documenti], [#g("typst", "Typst") con il template `Templates/DocumentiGenerici.typ`],
  [Verbali], [Typst con il template `Templates/Verbali.typ`],
  [#g("diario-di-bordo", "Diari di bordo")], [#g("google-presentazioni", "Google Presentazioni") con il template del gruppo; il PDF si carica nel repository],
)

=== Struttura del repository dei documenti

I documenti stanno in `<Tappa>/<Cartella>/`, per esempio `RTB/Verbali_interni/2026-11-10.typ`. Il sito riconosce queste cartelle:

#tabella(
  (auto, 1fr, 1fr),
  ("Cartella", "Contenuto", "Nome del file"),
  [`Generali`], [Documenti del gruppo], [Nome del documento, in minuscolo e con i trattini: `norme-di-progetto.typ`],
  [`Verbali_interni`], [Verbali delle riunioni del gruppo], [`AAAA-MM-GG.typ`],
  [`Verbali_esterni`], [Verbali delle riunioni con le aziende e loro versione firmata], [`AAAA-MM-GG-<azienda>.typ` \ `AAAA-MM-GG-<azienda>-signed.pdf`],
  [`Diario_di_bordo`], [PDF delle presentazioni], [`AAAA-MM-GG.pdf`],
)

=== Glossario

- Il glossario sta sul sito del gruppo. Ogni voce ha un identificativo univoco, che permette il collegamento diretto (`glossario#<id>`).
- Il sito ricava l'identificativo dal nome della voce: lettere minuscole, senza accenti, con un trattino al posto di spazi e simboli. Per esempio, «Sprint Retrospective» diventa `sprint-retrospective`.
- Nei documenti, un termine del glossario si marca alla sua prima occorrenza nel documento con la funzione `gloss` del template, che aggiunge il pedice #sub[G] e il collegamento alla voce.
// TODO(decisione): chi aggiunge una voce nuova al glossario, e con quale procedura?

=== Stesura di un documento

#procedura(
  chi: [Assegnatario dell'issue],
  input: [Issue aperta con il modulo *Documento*],
  output: [#g("pull-request", "Pull request") pronta per la verifica],
  strumenti: [Typst, Git, GitHub],
)[
  + Crea il branch da `main` seguendo la procedura dei branch (@branch).
  + Crea o modifica il file `.typ` con il template del suo tipo e compila i campi titolo, autore, versione e stato secondo le regole di versionamento (@versionamento). Il registro delle modifiche non si modifica a mano.
  + Compila il documento in locale, dalla cartella principale del repository, per controllare che non ci siano errori: `typst compile --root . --font-path Templates/Fonts <file>.typ`. In alternativa, `Scripts/compila.sh` compila tutti i documenti in `pdf/`.
  + Fa i commit seguendo le regole dei commit (@commit).
  + Spunta le voci della #g("definition-of-done", "Definition of Done") man mano che le completa.
  + Apre la pull request seguendo la procedura delle pull request (@pr).
]

=== Verbali <verbali>

Ogni riunione ha un verbale, scritto da una sola persona, il redattore, con la sua issue (modulo *Verbale interno* o *Verbale esterno*). Il Responsabile sceglie il redattore alla fine della riunione; il redattore scrive il verbale entro 3 giorni dalla riunione.

#procedura(
  chi: [Redattore del verbale],
  input: [Riunione svolta; issue del verbale],
  output: [Verbale verificato e integrato in `main`],
  strumenti: [Typst con `Templates/Verbali.typ`, GitHub],
)[
  + Scrive il verbale con il template dei verbali. Il primo punto è l'ordine del giorno; seguono data, ora, luogo e partecipanti.
  + Riporta ogni decisione con la sua motivazione, nel testo della decisione: «Deciso X perché Y».
  + Riporta ogni attività decisa con:
    - una sola persona assegnata;
    - una scadenza in formato `AAAA-MM-GG`;
    - la decisione da cui nasce;
    - il numero della sua issue.
  + Non usa «Tutti», «da definire» o `N/D`: se un'attività non ha ancora un'issue, chiede all'Amministratore di aprirla prima di chiedere la verifica.
  + Apre la pull request. La descrizione cita le issue delle attività con `Refs #n`, perché il merge non le chiuda. Per un verbale interno chiude anche l'issue del verbale (`Closes #n`); per un verbale esterno la cita solo con `Refs #n`, perché quell'issue si chiude con il PDF firmato.
  + Per un verbale esterno:
    - compila il campo `azienda`;
    - quando il Responsabile approva la pull request con una review, la pull request si integra in `main` senza attendere la firma: il sito pubblica i verbali esterni solo quando c'è la versione firmata;
    - il Responsabile invia all'azienda, per la firma, il PDF della versione integrata in `main`;
    - quando arriva il PDF firmato, il redattore lo carica accanto al sorgente come `*-signed.pdf` con una seconda pull request, che chiude l'issue del verbale (`Closes #n`).
    - se l'azienda tarda a firmare, si attende la firma: l'issue del verbale resta aperta.
]

=== Pubblicazione sul sito

La pubblicazione è automatica: a ogni push su `main`, la #g("ci-cd", "CI") compila i documenti e li pubblica sul sito del gruppo (#g("github-pages", "GitHub Pages")).
- Sul sito vanno solo i documenti con stato «Approvato».
- Dei verbali esterni si pubblica solo la versione firmata (`*-signed.pdf`).
- Un PDF già pubblicato viene sostituito solo quando cambia la sua versione.

Dopo ogni merge su `main`, l'Amministratore controlla che il workflow di pubblicazione termini senza errori. Se fallisce, apre un'issue del modulo *Strumento, CI o automazione*.

=== Versionamento e stati <versionamento>

La versione di un documento ha la forma `X.Y.Z`. La bozza di un documento parte dalla versione 0.1.0 (decisione D2 del verbale interno del 2026-11-03); poi:
- una correzione minore incrementa `Z`;
- un aggiornamento sostanziale incrementa `Y` e azzera `Z`;
- l'approvazione del Responsabile per il rilascio incrementa `X` e azzera `Y` e `Z`, senza ulteriore verifica.

La regola vale anche dopo il primo rilascio. Per esempio: 0.1.0 → 0.1.1 → 0.2.0 → 1.0.0 → 1.0.1 → 1.1.0 → 2.0.0.

Un documento passa per tre stati: *Bozza*, *Verificato*, *Approvato*. Solo i documenti approvati vengono pubblicati sul sito.
// TODO: il template `DocumentiGenerici.typ` ha come stato predefinito «In Approvazione»; si corregge con un'issue a parte

Il registro delle modifiche elenca le versioni dalla più recente:
- ogni riga corrisponde a una modifica e ha un solo autore;
- la verifica non aggiunge righe: il #g("verificatore", "Verificatore") completa la colonna Verificatore della riga che ha verificato;
- il registro lo compila l'automazione del repository, non l'autore.
// TODO: le issue #65 e #66 oggi prevedono solo la colonna Verificatore e la riga di approvazione; vanno estese alle righe delle modifiche

== Gestione della configurazione

=== Repository e rami

- I documenti stanno nel repository `Documenti` dell'organizzazione _MemoryLeakersTeam_ su GitHub; il sito nel repository `MemoryLeakersTeam.github.io`.
- Il gruppo applica il modello #g("git-flow", "Git Flow"):
  - `main` contiene la versione stabile;
  - `develop` è il ramo di integrazione del codice del prodotto.
- Per la documentazione non c'è un ramo `develop`: i branch partono da `main` e tornano in `main`.


=== Branch <branch>

#procedura(
  chi: [Assegnatario dell'issue],
  input: [Issue aperta e assegnata],
  output: [Branch di lavoro],
  strumenti: [Git],
)[
  + Crea un branch per l'issue, da `main` per i documenti e da `develop` per il codice.
  + Lo chiama `<tipo>/<descrizione>`, con il tipo preso dalla tabella dei commit (@commit), in minuscolo e con i trattini come separatore. Il numero dell'issue è facoltativo: per esempio `ci/51-metadati-elenco`.
  + Integra o elimina il branch entro 3 giorni dalla creazione, per evitare branch dimenticati e divergenze dal ramo principale. Un documento lungo si divide in più issue, ognuna con il suo branch.
]

Le issue del modulo *Analisi* non hanno un branch: si chiudono con un output collegato nell'issue.

=== Commit <commit>

I messaggi di commit seguono i #g("conventional-commits", "Conventional Commits"), in inglese: `<tipo>(<ambito>): <descrizione>`. In fondo al messaggio si cita l'issue di riferimento con la riga `Refs: #n`, nel formato dei _trailer_ di Git. Nella descrizione di una pull request, invece, le issue si citano come testo semplice: `Closes #n` oppure `Refs #n`.

#tabella(
  (auto, 1fr),
  ("Tipo", "Significato"),
  [`docs`], [Modifiche alla documentazione, non al codice],
  [`feat`], [Nuova funzionalità del prodotto],
  [`fix`], [Correzione di un errore],
  [`ci`], [Modifiche alla pipeline di CI/CD],
  [`build`], [Modifiche a ciò che serve per compilare o costruire il progetto],
  [`refactor`], [Ristrutturazione del codice senza cambiarne il comportamento esterno],
  [`test`], [Aggiunta o modifica di test],
  [`chore`], [Manutenzione che non rientra nelle altre categorie],
  [`style`], [Modifiche di formattazione che non cambiano il significato],
  [`perf`], [Miglioramento delle prestazioni],
  [`revert`], [Annullamento di un commit precedente],
)

=== Pull request <pr>

#procedura(
  chi: [Assegnatario dell'issue],
  input: [Branch con il lavoro completato e Definition of Done spuntata],
  output: [Pull request in attesa di verifica],
  strumenti: [GitHub],
)[
  + Apre la pull request verso `main`. Il titolo segue il formato dei Conventional Commits: la CI lo controlla.
  + Nella descrizione chiude la sua issue con `Closes #n`; le altre issue si citano con `Refs #n`.
  + Chiede la review al Verificatore, che riceve così la notifica.
  + Attende che la CI compili i documenti senza errori.
  + Se il Verificatore chiede modifiche, le applica con nuovi commit e chiede di nuovo la review.
]

Il Verificatore approva l'integrazione di una pull request in `main` o `develop`, dopo aver controllato che la Definition of Done sia soddisfatta (@verifica). Il Responsabile approva il rilascio di un documento, senza ulteriore verifica (@versionamento).
// TODO: oggi il ruleset di `main` accetta l'approvazione di chiunque; il controllo dei ruoli si automatizza con #65 e #66

== Verifica <verifica>

=== Principi

- *Indipendenza*: il Verificatore indicato nell'issue è chi ha il ruolo di Verificatore nello sprint. L'autore di un'attività non ne è mai il Verificatore, né il Responsabile che ne approva il rilascio.
  // TODO(decisione): se l'autore di un documento è il Responsabile dello sprint (per esempio di un diario di bordo), chi ne approva il rilascio?
- *Sola lettura*: il Verificatore non modifica il prodotto che verifica. Segnala i problemi con un commento e li corregge l'autore.
- *Checklist scritte prima*: ogni classe di attività ha la sua checklist di verifica, scritta nel modulo dell'issue (`.github/ISSUE_TEMPLATE/`). L'Amministratore abbozza la Definition of Done della singola issue quando la apre; l'assegnatario la completa prima di cominciare.

=== Chi spunta cosa

#tabella(
  (auto, auto, 1fr),
  ("Sezione dell'issue", "Chi la spunta", "Quando"),
  [Definition of Done], [Assegnatario], [Man mano che completa le voci; quando sono tutte spuntate avvisa il Verificatore],
  [Verifica], [Verificatore], [Dopo che l'assegnatario ha finito],
  [Esito], [Verificatore], [Alla fine della verifica: «Accettato», «Da correggere» o «Rifiutato»],
)

=== Verifica di un'attività

#procedura(
  chi: [Verificatore],
  input: [Issue con la Definition of Done spuntata; pull request, se l'attività ne prevede una],
  output: [Esito della verifica nell'issue; pull request approvata o con richiesta di modifiche],
  strumenti: [GitHub],
)[
  + Controlla ogni voce della sezione Verifica dell'issue e la spunta se è soddisfatta.
  + Se una voce della Definition of Done non è vera, non la toglie: lo scrive in un commento.
  + Segna l'esito nell'issue.
  + Se l'esito è «Accettato», approva la pull request; se è «Da correggere», chiede le modifiche nella review e rimanda all'issue per i dettagli.
  + Se l'esito è «Rifiutato», chiude la pull request senza merge. L'issue resta aperta e si ridiscute nella riunione successiva.
  + Quando l'assegnatario chiede di nuovo la review, ripete la verifica sulle voci non ancora soddisfatte.
]

= Processi organizzativi <organizzativi>

== Gestione dei processi

=== Ruoli

Ogni membro del gruppo ricopre un ruolo alla volta. I ruoli ruotano a ogni #g("sprint", "sprint").
I membri del gruppo si organizzano da soli la rotazione e registrano nel cruscotto le ore svolte in ogni ruolo, così da controllare che ognuno li ricopra tutti.
// TODO: il cruscotto delle ore non esiste ancora (issue #4 del sito)

#tabella(
  (auto, 1fr),
  ("Ruolo", "Responsabilità"),
  // TODO(decisione): manca la procedura di rilascio (chi, input, output, strumenti, passi); dipende da #66
  [Responsabile], [Coordina il gruppo, pianifica le attività e le scadenze, rappresenta il gruppo verso l'esterno, approva il rilascio dei prodotti],
  [Amministratore], [Mantiene l'ambiente di lavoro: strumenti, procedure, automazioni e queste norme; apre le issue delle attività],
  [#g("analista", "Analista")], [Analizza il problema e definisce i requisiti],
  [#g("progettista", "Progettista")], [Definisce l'architettura e le scelte realizzative del prodotto],
  [#g("programmatore", "Programmatore")], [Scrive il codice del prodotto e i suoi test],
  [Verificatore], [Verifica i prodotti secondo le checklist di queste norme],
)

=== Sprint e riunioni

- Il gruppo adotta una metodologia #g("agile", "agile") e lavora a sprint di due settimane: ogni sprint va da un martedì al martedì di due settimane dopo.
- La #g("sprint-retrospective", "Sprint Retrospective") si tiene il martedì dalle 14:00 alle 15:00, su #g("discord", "Discord"). All'inizio la cadenza è bisettimanale; diventerà settimanale da una data che il gruppo fisserà.
  - 14:00–14:30: discussione dello sprint concluso;
  - 14:30–15:00: rotazione dei ruoli, discussione dello sprint successivo e assegnazione delle attività.
- Entro il sabato precedente ogni membro segna sul calendario condiviso le ore in cui è disponibile nella settimana successiva.
- Durante lo sprint, chi incontra una difficoltà non prevista la riferisce al Responsabile entro il giorno successivo, nel canale Telegram «Riunioni interne». Il Responsabile comunica al gruppo le contromisure il prima possibile.

=== Comunicazione interna <comunicazione>

#tabella(
  (auto, 1fr),
  ("Canale", "Uso"),
  [Telegram], [Comunicazioni ufficiali del gruppo, divise nei canali Generale, ToDo, Sondaggi, Candidatura, Riunioni interne, Riunioni esterne, Link utili],
  [#g("whatsapp", "WhatsApp")], [Comunicazioni rapide e informali; non è il canale delle decisioni],
  [Discord], [Riunioni interne del gruppo],
)

Le decisioni valgono solo se sono scritte in un verbale. Un sondaggio su Telegram va confermato nella riunione successiva.

=== Issue e pianificazione delle attività <issue>

Le attività del gruppo si tracciano con le issue del repository e si pianificano sulla bacheca di #g("github-projects", "GitHub Projects"), divisa per sprint.

Si apre un'issue per ogni attività che:
- compare come azione in un verbale;
- richiede #g("ore-produttive", "ore produttive"), da rendicontare;
  // TODO(decisione): manca la procedura di consuntivo: dove e come si registrano le ore effettive (issue #4 del sito)
- modifica il contenuto di un repository.

Lo studio individuale su strumenti e metodi non ha un'issue: non conta tra le ore produttive.

#tabella(
  (auto, 1fr),
  ("Modulo", "Quando usarlo"),
  [Documento], [Stesura o modifica di un documento],
  [Verbale interno], [Verbale di una riunione del gruppo],
  [Verbale esterno], [Verbale di una riunione con un'azienda],
  [Strumento, CI o automazione], [Workflow, script e altri strumenti del repository],
  [Analisi (senza PR)], [Studio di un tema o preparazione di una riunione, che si chiude con un output collegato nell'issue],
)

=== Apertura di un'issue <apertura>

#procedura(
  chi: [Amministratore],
  input: [Attività decisa in riunione, oppure proposta da un membro del gruppo],
  output: [Issue assegnata e pianificata nello sprint],
  strumenti: [GitHub, GitHub Projects],
)[
  + Apre l'issue con il modulo della classe di attività: le issue senza modulo sono disattivate.
  + Nel campo *Origine* scrive la riunione in cui è stata decisa l'attività («Riunione interna del AAAA-MM-GG»), oppure «Proposta di \@nome». Gli identificativi delle decisioni e delle attività li assegna il verbale.
  + Compila scadenza (`AAAA-MM-GG`), ruolo, stima delle ore, Verificatore e una prima versione della Definition of Done, che l'assegnatario completa prima di cominciare.
  + Assegna l'issue a una sola persona e imposta la #g("milestone", "milestone").
  // TODO: le milestone non sono ancora definite; si decidono con l'issue #62
  + Inserisce l'issue nello sprint corrente della bacheca.
  + Se l'issue nasce da una proposta, la porta alla riunione successiva perché il gruppo la confermi a verbale. Il lavoro può cominciare anche prima della conferma.
]

== Gestione delle infrastrutture

L'Amministratore mantiene gli strumenti del gruppo e le automazioni del repository, e ne aggiorna la descrizione in questo documento.

=== Strumenti

#tabella(
  (auto, 1fr),
  ("Strumento", "Uso"),
  [GitHub], [Repository dei documenti e del sito, issue, pull request, automazioni (#g("github-actions", "GitHub Actions"))],
  [GitHub Projects], [Bacheca #g("kanban", "Kanban") delle attività, divisa per sprint],
  [GitHub Pages], [Sito del gruppo, con documenti pubblicati e glossario],
  [Typst], [Stesura dei documenti],
  [Google Presentazioni], [Presentazioni dei diari di bordo],
  [#g("google-calendar", "Google Calendar")], [Calendario condiviso delle disponibilità],
  [#g("google-drive", "Google Drive")], [Condivisione di file di lavoro],
  [Telegram, WhatsApp, Discord], [Comunicazione interna (@comunicazione)],
  [Gmail], [Comunicazione con le aziende],
)

=== Automazioni del repository

#tabella(
  (auto, 1fr, 2fr),
  ("Workflow", "Quando parte", "Cosa fa"),
  [`compila-pr.yml`], [Pull request verso `main`], [Compila i documenti e segnala gli errori],
  [`titolo-pr.yml`], [Pull request verso `main`], [Controlla che il titolo segua i Conventional Commits],
  [`compila-pdf.yml`], [Push su `main`], [Compila i documenti e pubblica sul sito quelli approvati],
  [`compila-comune.yml`], [Da `compila-pr.yml` e `compila-pdf.yml`], [Contiene i passi comuni: installa Typst e i font, compila i documenti con `Scripts/compila.sh` e carica i PDF come artifact],
)
