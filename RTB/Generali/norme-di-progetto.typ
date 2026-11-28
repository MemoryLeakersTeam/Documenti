#import "../../Templates/DocumentiGenerici.typ": *

#show: documento.with(
  titolo: "Norme di Progetto",
  sottotitolo: "",
  tipo-documento: "Documento Interno",
  autore: "Riccardo Peresson",
  data: datetime(year: 2026, month: 11, day: 11),
  file-nome: "norme-di-progetto.pdf",
  // Versione, stato, verificatore, firma e registro: li scrive l'automazione dopo il merge
  dati: yaml("norme-di-progetto.yml"),
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

Al passaggio a una nuova tappa (per esempio da `RTB/` a `PB/`), un documento si sposta con `git mv`, insieme al suo `<nome>.yml` e senza modificarlo: così versione e registro delle modifiche continuano. Lo spostamento conta come una modifica (@versionamento): serve la label, e dopo il merge il documento ha una nuova versione ed è «Verificato». Un documento copiato, invece, è un documento nuovo e riparte dalla versione 0.1.0.
// TODO: oggi il sito rimuove la voce della tappa precedente di un documento spostato; si corregge con l'issue #9 del sito

=== Glossario

- Il glossario sta sul sito del gruppo. Ogni voce ha un identificativo univoco, che permette il collegamento diretto (`glossario#<id>`).
- Il sito ricava l'identificativo dal nome della voce: lettere minuscole, senza accenti, con un trattino al posto di spazi e simboli. Per esempio, «Sprint Retrospective» diventa `sprint-retrospective`.
- Nei documenti, un termine del glossario si marca alla sua prima occorrenza nel documento con la funzione `gloss` del template, che aggiunge il pedice #sub[G] e il collegamento alla voce.
- La voce di un termine nuovo la aggiunge chi introduce il termine in un documento, nella stessa attività, prima di chiedere la verifica (decisione della riunione interna del 2026-11-17). La aggiunge dal pannello di amministrazione del sito (`/admin`), con un token personale di GitHub con permesso _Contents: Read and write_ sul solo repository del sito, come indicato nella pagina stessa.

=== Stesura di un documento

#procedura(
  chi: [Assegnatario dell'issue],
  input: [Issue aperta con il modulo *Documento*],
  output: [#g("pull-request", "Pull request") pronta per la verifica],
  strumenti: [Typst, Git, GitHub],
)[
  + Crea il branch da `main` seguendo la procedura dei branch (@branch).
  + Crea o modifica il file `.typ` con il template del suo tipo e compila i campi titolo e autore. Versione, stato, Verificatore, firma e registro delle modifiche non si scrivono nel sorgente: stanno nel file dei dati `<nome>.yml`, accanto a `<nome>.typ`, e li aggiorna l'automazione dopo il merge (@versionamento). Per un documento nuovo:
    - copia `Templates/DatiDocumento.yml` accanto al sorgente come `<nome>.yml`, senza modificarlo;
    - passa i dati al template: `#show: documento.with(..., dati: yaml("<nome>.yml"))`; per un verbale, `verbale.with`.

    Un documento esistente ha già il suo `<nome>.yml`: l'autore non lo modifica.

    Un documento già in `main` che ha ancora questi dati scritti nel sorgente si *migra*: riceve il suo `<nome>.yml` con i dati così come sono, cioè versione, stato, Verificatore, firma e registro, con le date in `AAAA-MM-GG` e la riga più recente in cima; il sorgente passa i dati al template e non li scrive più. La migrazione è una modifica come le altre: serve la label, e il Verificatore controlla che i dati del `<nome>.yml` coincidano con quelli del sorgente in `main`.
  + Compila il documento in locale, dalla cartella principale del repository, per controllare che non ci siano errori: `typst compile --root . --font-path Templates/Fonts <file>.typ`. In alternativa, `Scripts/compila.sh` compila tutti i documenti in `pdf/`.
  + Fa i commit seguendo le regole dei commit (@commit).
  + Spunta le voci della #g("definition-of-done", "Definition of Done") man mano che le completa.
  + Apre la pull request seguendo la procedura delle pull request (@pr).
  + Effettua il merge della pull request in seguito all'approvazione del verificatore (@pr).
]

=== Verbali <verbali>

Ogni riunione ha un verbale, scritto da una sola persona, il redattore, con la sua issue (modulo *Verbale interno* o *Verbale esterno*). Il Responsabile sceglie il redattore alla fine della riunione; il redattore scrive il verbale entro 3 giorni dalla riunione.

#procedura(
  chi: [Redattore del verbale],
  input: [Riunione svolta; issue del verbale],
  output: [Verbale verificato e integrato in `main`],
  strumenti: [Typst con `Templates/Verbali.typ`, GitHub],
)[
  + Scrive il verbale con il template dei verbali. Dopo il registro delle modifiche e l'indice, il template riporta l'ordine del giorno e poi data, ora, luogo e partecipanti: il redattore compila i campi corrispondenti.
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
    - la pull request si integra in `main` con l'approvazione del Verificatore, come ogni altra (@pr), senza attendere la firma. Il verbale entra in `main` con la versione 0.1.0 e lo stato «Verificato»;
    - il Responsabile rilascia il verbale con la procedura di rilascio (@rilascio): il verbale passa alla versione 1.0.0, con lo stato «Approvato» e la sua firma;
    - il Responsabile invia all'azienda, per la firma, il PDF della versione 1.0.0;
    - quando arriva il PDF firmato, il redattore lo carica accanto al sorgente come `*-signed.pdf` con una seconda pull request, che chiude l'issue del verbale (`Closes #n`). Il sito pubblica i verbali esterni solo quando c'è la versione firmata;
    - se l'azienda tarda a firmare, si attende la firma: l'issue del verbale resta aperta.
]

=== Pubblicazione sul sito

La pubblicazione è automatica: a ogni push su `main`, la #g("ci-cd", "CI") compila i documenti e li pubblica sul sito del gruppo (#g("github-pages", "GitHub Pages")).
- Sul sito vanno solo i documenti con stato «Approvato».
- Dei verbali esterni si pubblica solo la versione firmata (`*-signed.pdf`).
- Un PDF già pubblicato viene sostituito solo quando cambia la sua versione.

Dopo ogni merge su `main`, l'Amministratore controlla che il workflow di pubblicazione termini senza errori. Se fallisce, apre un'issue del modulo *Strumento, CI o automazione*.

=== Versionamento e stati <versionamento>

Da `RTB/` in poi, versione, stato, #g("verificatore", "Verificatore"), firma del Responsabile e registro delle modifiche di un documento stanno nel file dei dati `<nome>.yml`, accanto a `<nome>.typ`. Li scrive solo l'automazione del repository (@automazioni): l'autore non li modifica e la verifica non modifica nulla. I documenti di `Candidatura/` restano come sono stati consegnati.

La versione di un documento ha la forma `X.Y.Z`. La prima cifra conta i rilasci approvati dal Responsabile. La regola completa è questa (decisione D2 del verbale interno del 2026-11-03 per la versione di partenza):

#tabella(
  (1fr, 1fr, auto),
  ("Evento", "Chi lo avvia", "Versione"),
  [Documento nuovo integrato in `main`], [Verificatore, approvando la pull request], [0.1.0],
  [Correzione minore integrata (label `patch`)], [Verificatore, approvando la pull request], [X.Y.Z → X.Y.(Z+1)],
  [Modifica sostanziale integrata (label `minor`)], [Verificatore, approvando la pull request], [X.Y.Z → X.(Y+1).0],
  [Rilascio (@rilascio)], [Responsabile, avviando `rilascio.yml`], [X.Y.Z → (X+1).0.0],
)

La regola vale anche dopo il primo rilascio. Per esempio: 0.1.0 → 0.1.1 → 0.2.0 → 1.0.0 → 1.0.1 → 1.1.0 → 2.0.0.

Un documento passa per tre stati:
- *Bozza*: un documento nuovo, finché la sua prima pull request non è integrata. Il suo `<nome>.yml` è la copia di `Templates/DatiDocumento.yml`, con la versione 0.0.0;
- *Verificato*: dopo ogni merge che modifica il documento. L'automazione toglie anche la firma del Responsabile, perché il contenuto non è più quello approvato;
- *Approvato*: dopo il rilascio del Responsabile. Solo i documenti approvati vengono pubblicati sul sito.
// TODO: il template `DocumentiGenerici.typ` ha come stato predefinito «In Approvazione»; si corregge con un'issue a parte

Il registro delle modifiche elenca le versioni dalla più recente:
- ogni merge aggiunge una riga, con la data del merge, la descrizione presa dalla sezione _Registro delle modifiche_ della pull request (@pr), l'autore della pull request e il Verificatore che l'ha approvata;
- ogni rilascio aggiunge la riga «Approvazione per il rilascio», con il Responsabile come autore e senza Verificatore;
- la verifica non aggiunge righe e non modifica né il documento né il suo `<nome>.yml`: il Verificatore approva la pull request, e il suo nome entra nel registro con il merge.

=== Correzione dei dati di un documento <correzione>

Se dopo un merge l'automazione fallisce (per esempio per un push rifiutato), non serve una correzione: l'Amministratore riesegue il job di `registro-modifiche.yml` dalla scheda _Actions_. Una pull request già registrata non viene registrata due volte.

Un errore nei dati di un documento, per esempio una descrizione o un nome sbagliati nel registro, si corregge con una pull request a parte.

#procedura(
  chi: [Assegnatario dell'issue],
  input: [Errore nel `<nome>.yml` di un documento in `main`; issue del modulo *Documento*],
  output: [Pull request integrata, senza una nuova versione del documento],
  strumenti: [Git, GitHub],
)[
  + Crea il branch e modifica solo i file `<nome>.yml` da correggere, senza toccare altri file.
  + Non cambia lo stato e la firma del Responsabile: li scrivono l'automazione dopo il merge e il Responsabile al rilascio (@rilascio).
  + Apre la pull request con la label `correzione-registro`, senza `minor` o `patch`. La sezione _Registro delle modifiche_ non serve: nella descrizione spiega l'errore e la correzione.
  + Chiede la review al Verificatore dello sprint, che controlla nel diff che i valori corretti siano giusti.
]

Dopo il merge l'automazione non crea una versione nuova. Il PDF si ricompila, ma sul sito un PDF già pubblicato resta quello di prima, perché il sito lo sostituisce solo quando cambia la versione.

=== Rilascio di un documento <rilascio>

Il Responsabile approva il rilascio di un documento senza ulteriore verifica. Il rilascio non ha una pull request: il documento è già verificato e non c'è nulla da modificare.

#procedura(
  chi: [Responsabile],
  input: [Uno o più documenti in `main` con stato «Verificato»],
  output: [Documenti alla versione (X+1).0.0, con stato «Approvato» e la firma del Responsabile, pubblicati sul sito],
  strumenti: [GitHub Actions (`rilascio.yml`)],
)[
  + Dalla scheda _Actions_ del repository sceglie *Rilascio* e poi _Run workflow_, lascia il ramo `main` e indica i percorsi dei documenti da rilasciare, separati da spazi o virgole, con o senza `.typ` (per esempio `RTB/Generali/norme-di-progetto`).
  + Il workflow controlla che chi lo avvia sia il Responsabile secondo `.github/ruoli.yml` e che ogni documento indicato sia da `RTB/` in poi, esista, abbia il suo `<nome>.yml`, sia nello stato «Verificato» e ne mostri i dati. Se un controllo fallisce, non modifica nessun documento e scrive tutti i motivi nel riepilogo dell'esecuzione.
  + Per ogni documento, il workflow porta la versione a (X+1).0.0, aggiunge in cima al registro la riga «Approvazione per il rilascio» con la data del rilascio, il Responsabile come autore e nessun Verificatore, imposta lo stato «Approvato» e la firma del Responsabile.
  + Il workflow fa un solo commit su `main` per tutti i documenti indicati. Il commit avvia la pubblicazione sul sito.
  + Il Responsabile controlla nel riepilogo dell'esecuzione che il rilascio sia riuscito e che i documenti compaiano sul sito con la nuova versione. Il riepilogo segnala anche se il Responsabile risulta autore di modifiche incluse nel rilascio, per esempio scritte in uno sprint precedente con un altro ruolo: il workflow non blocca il rilascio.
]

Se il workflow fallisce dopo i controlli (per esempio per un push rifiutato), il Responsabile lo riesegue dalla pagina dell'esecuzione: una riesecuzione di un rilascio già riuscito non rilascia di nuovo. In una riesecuzione il controllo del ruolo vale per chi la avvia.

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
  + Un documento lungo si divide in più issue, ognuna con il suo branch.
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
  + Compila la descrizione con il template `.github/pull_request_template.md`:
    - chiude la sua issue con `Closes #n`; le altre issue si citano con `Refs #n`;
    - se la pull request modifica un documento da `RTB/` in poi, scrive nella sezione _Registro delle modifiche_ cosa cambia, in una frase: diventa la descrizione della riga del registro. Più voci di un elenco diventano una riga sola, separate da «;».
  + Se la pull request modifica un documento da `RTB/` in poi, mette esattamente una label: `minor` per una modifica sostanziale, `patch` per una correzione minore (@versionamento). Una pull request che corregge solo i dati di un documento ha invece la label `correzione-registro` (@correzione).
  + Chiede la review al Verificatore dello sprint, che riceve così la notifica.
  + Attende che la CI compili i documenti senza errori e che il controllo *Registro delle modifiche* passi.
  + Se il Verificatore chiede modifiche, le applica con nuovi commit e chiede di nuovo la review.
  + All'approvazione del verificatore, effettua il merge su `main`.
]

Il controllo *Registro delle modifiche* è obbligatorio nel ruleset di `main`: finché non passa, la pull request non si integra. Il motivo del blocco è nel riepilogo del controllo. Il controllo blocca la pull request se:
- modifica un documento da `RTB/` in poi e non ha esattamente una label tra `minor` e `patch`;
- modifica un documento da `RTB/` in poi e la sezione _Registro delle modifiche_ della descrizione è vuota;
- modifica un file dei dati `<nome>.yml` già esistente senza la label `correzione-registro`;
- aggiunge un `<nome>.yml` diverso da `Templates/DatiDocumento.yml`. Per una migrazione ne controlla solo la forma, e la segnala al Verificatore;
- modifica un documento che non ha il suo `<nome>.yml` o non lo passa al template;
- ha la label `correzione-registro` e modifica altri file oltre ai `<nome>.yml` già esistenti, ne cambia lo stato o la firma, oppure ha anche la label `minor` o `patch`;
- non ha l'approvazione dell'ultimo commit da parte del Verificatore dello sprint, che deve essere diverso dall'autore della pull request.

Dopo ogni review il controllo si riesegue da solo (`registro-review.yml`, @automazioni). Nel ruleset è obbligatorio solo il controllo *Registro delle modifiche*.

Il Verificatore approva l'integrazione di una pull request in `main` o `develop`, dopo aver controllato che la Definition of Done sia soddisfatta (@verifica). Il Responsabile approva il rilascio di un documento, senza ulteriore verifica (@rilascio).

== Verifica <verifica>

=== Principi

- *Indipendenza*: il Verificatore indicato nell'issue è chi ha il ruolo di Verificatore nello sprint in `.github/ruoli.yml` (@ruoli). Il controllo *Registro delle modifiche* accetta solo la sua approvazione (@pr). L'autore di un'attività non ne è mai il Verificatore, né il Responsabile che ne approva il rilascio: il Responsabile non redige documenti, quindi non è mai autore delle modifiche che rilascia (decisione della riunione interna del 2026-11-17).
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
  + Quando l'assegnatario chiede di nuovo la review, ripete la verifica sulle voci non ancora soddisfatte. Il controllo *Registro delle modifiche* vale solo per l'approvazione dell'ultimo commit: dopo un nuovo commit serve una nuova approvazione.
  + Non modifica il documento né il suo `<nome>.yml`: il suo nome entra nel registro delle modifiche con il merge (@versionamento).
]

= Processi organizzativi <organizzativi>

== Gestione dei processi

=== Ruoli <ruoli>

Ogni membro del gruppo ricopre un ruolo alla volta. I ruoli ruotano a ogni #g("sprint", "sprint").
I membri del gruppo si organizzano da soli la rotazione e registrano sul sito le ore svolte in ogni ruolo (@ore), così da controllare che ognuno li ricopra tutti.

I ruoli dello sprint in corso sono nel file `.github/ruoli.yml`: per ogni membro, il login GitHub, il nome e il ruolo. A ogni rotazione l'Amministratore aggiorna il file con una pull request. Le automazioni leggono il file nella versione su `main`:
- il controllo delle pull request accetta solo l'approvazione del Verificatore (@pr);
- il workflow di rilascio si avvia solo dal Responsabile (@rilascio);
- nel registro delle modifiche, autore e Verificatore compaiono con il nome corrispondente al login.

Se alla rotazione l'autore di una pull request ancora aperta diventa Verificatore, il lavoro passa al membro che entra nel ruolo che l'autore lasciava: chiude la pull request e ne apre una nuova dallo stesso branch. Il controllo considera autore chi ha aperto la pull request, e il registro riporta lui come autore.

#tabella(
  (auto, 1fr),
  ("Ruolo", "Responsabilità"),
  [Responsabile], [Coordina il gruppo, pianifica le attività e le scadenze, rappresenta il gruppo verso l'esterno, approva il rilascio dei prodotti (@rilascio)],
  [Amministratore], [Mantiene l'ambiente di lavoro: strumenti, procedure, automazioni e queste norme; apre le issue delle attività; aggiorna `.github/ruoli.yml` a ogni rotazione],
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
- richiede #g("ore-produttive", "ore produttive"), da rendicontare (@ore);
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

=== Consuntivo delle ore <ore>

Le ore produttive si consuntivano sul sito del gruppo, nella pagina `/ore` (decisione della riunione interna del 2026-11-17). La pagina mostra le ore svolte da ciascun membro, per ruolo e per sprint, contro il preventivo della Dichiarazione degli impegni, e permette di scaricare un CSV per sprint da usare nel Piano di Progetto.

#procedura(
  chi: [Ogni membro del gruppo, per le proprie ore],
  input: [Ore produttive svolte nello sprint],
  output: [Ore registrate in `data/ore.json` del repository del sito],
  strumenti: [Pannello di amministrazione del sito (`/admin`), scheda _Ore_],
)[
  + Registra solo le ore produttive svolte dal 2026-11-03, data dell'aggiudicazione. Le riunioni e la stesura dei verbali non sono ore produttive.
  + Registra le proprie ore entro la fine dello sprint, a passi di 0,5 ore, con il ruolo ricoperto in quel momento e, se c'è, l'issue su cui ha lavorato (`Repository#numero`).
  + Ogni registrazione o eliminazione è un commit sul repository del sito e si pubblica subito.
]

Il pannello non impedisce di registrare le ore di un altro membro: ognuno registra solo le proprie, e la cronologia dei commit mostra chi ha scritto cosa. Se il preventivo per persona e per ruolo cambia, si aggiorna `preventivo` in `data/ore.json`.

== Gestione delle infrastrutture

L'Amministratore mantiene gli strumenti del gruppo e le automazioni del repository, e ne aggiorna la descrizione in questo documento.

=== Strumenti

#tabella(
  (auto, 1fr),
  ("Strumento", "Uso"),
  [GitHub], [Repository dei documenti e del sito, issue, pull request, automazioni (#g("github-actions", "GitHub Actions"))],
  [GitHub Projects], [Bacheca #g("kanban", "Kanban") delle attività, divisa per sprint],
  [GitHub Pages], [Sito del gruppo, con documenti pubblicati, glossario e consuntivo delle ore (@ore)],
  [Typst], [Stesura dei documenti],
  [Google Presentazioni], [Presentazioni dei diari di bordo],
  [#g("google-calendar", "Google Calendar")], [Calendario condiviso delle disponibilità],
  [#g("google-drive", "Google Drive")], [Condivisione di file di lavoro],
  [Telegram, WhatsApp, Discord], [Comunicazione interna (@comunicazione)],
  [Gmail], [Comunicazione con le aziende],
)

=== Automazioni del repository <automazioni>

#tabella(
  (auto, 1fr, 2fr),
  ("Workflow", "Quando parte", "Cosa fa"),
  [`compila-pr.yml`], [Pull request verso `main`], [Compila i documenti e segnala gli errori],
  [`titolo-pr.yml`], [Pull request verso `main`], [Controlla che il titolo segua i Conventional Commits],
  [`registro-pr.yml`], [Pull request verso `main`: apertura, modifica della descrizione, nuovi commit e label], [Controllo obbligatorio *Registro delle modifiche*: blocca il merge se mancano la label, la sezione _Registro delle modifiche_ o l'approvazione del Verificatore dello sprint, oppure se la pull request modifica un `<nome>.yml` senza la label `correzione-registro` (@pr)],
  [`registro-review.yml`], [Review di una pull request verso `main`, inviata o annullata], [Riesegue il controllo *Registro delle modifiche* dell'ultimo commit, che così vede la review. Non aggiunge un secondo controllo con lo stesso nome: resterebbe quello rosso di prima dell'approvazione, e bloccherebbe il merge],
  [`registro-modifiche.yml`], [Merge di una pull request in `main`, solo se la variabile del repository `REGISTRO_ATTIVO` vale `true`], [Per ogni documento modificato aggiorna `<nome>.yml`: versione secondo la label, riga in cima al registro, Verificatore, stato «Verificato» e firma tolta. Fa il commit direttamente su `main` con la GitHub App dell'organizzazione. Con la label `correzione-registro` non modifica nulla (@correzione)],
  [`rilascio.yml`], [Avvio a mano del Responsabile, dalla scheda _Actions_ sul ramo `main`], [Controlla ruolo e documenti; porta i documenti indicati a (X+1).0.0, con stato «Approvato», la firma del Responsabile e la riga «Approvazione per il rilascio» nel registro. Fa un solo commit su `main` con la GitHub App dell'organizzazione (@rilascio)],
  [`compila-pdf.yml`], [Push su `main`, anche dei commit di `registro-modifiche.yml` e `rilascio.yml`], [Compila i documenti e pubblica sul sito quelli approvati],
  [`compila-comune.yml`], [Da `compila-pr.yml` e `compila-pdf.yml`], [Contiene i passi comuni: installa Typst e i font, compila i documenti con `Scripts/compila.sh` e carica i PDF come artifact],
)

Le regole del registro e del controllo sono in `Scripts/registro.py`. Il controllo usa sempre la versione di `main` dello script e di `.github/ruoli.yml`: una pull request non può allentare il controllo che la blocca, né nominare il proprio Verificatore.
