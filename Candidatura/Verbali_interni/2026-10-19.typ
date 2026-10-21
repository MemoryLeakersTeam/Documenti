#import "../../Templates/Verbali.typ": verbale, gloss

#show: verbale.with(
  titolo: "Verbale interno del 19/10/2026",
  tipo-documento: "Verbale Interno",
  data: datetime(year: 2026, month: 10, day: 19),
  ora: "16:00 – 17:10",
  luogo: "Google Meet",
  versione: "1.0.0",
  stato: "Verificato",
  autore: "Jacopo De Donà",
  verificatore: "Chiara Protopapa",
  file-nome: "2026-10-19.pdf",
  gruppo: "Memory Leakers",
  ordine-del-giorno: (
    [Verifica del completamento delle attività della settimana precedente],
    [Scelta degli strumenti per la condivisione dei documenti e la gestione delle attività],
    [Adozione di un nuovo canale di comunicazione],
    [Convenzioni per git e GitHub],
    [Revisione delle priorità dei capitolati],
    [Gestione del sito e del glossario],
    [Definizione dei ruoli per le prossime due settimane],
    [Pianificazione delle riunioni future],
    [Varie ed eventuali],
  ),
  partecipanti: (
    "Matteo Arcandi", "Jacopo De Donà", "Jacopo Franco",
    "Matteo Marcon", "Riccardo Peresson", "Paolo Prevedello Ramirez", "Chiara Protopapa",
  ),
  distribuzione: ("Memory Leakers", "Prof. Riccardo Cardin", "Prof. Tullio Vardanega"),
  // Ogni riga: (Ver., Data, Descrizione, Autore, Verificatore)
  registro-modifiche: (
    ([1.0.0], [20/10/2026], [Prima versione completa del verbale], [Jacopo De Donà], [Chiara Protopapa]),
    ([0.0.1], [19/10/2026], [Bozza del secondo incontro], [Jacopo De Donà], []),
  ),
  // Ogni riga: (ID, Decisione presa)
  decisioni: (
    ([D1], [Adottato *Telegram* come canale di comunicazione interna, con canali tematici]),
    ([D2], [Adottato *Google Drive* per la condivisione dei documenti]),
    ([D3], [Avviata la valutazione di *YouTrack* come strumento per la gestione delle attività del gruppo, affidata a Chiara Protopapa]),
    ([D4], [Decisa la creazione di un file Google Docs per raccogliere le domande da porre alle aziende]),
    ([D5], [Deciso il collegamento dei PDF dei verbali al sito del gruppo su *GitHub Pages*]),
    ([D6], [Nuove priorità dei capitolati: C6, C1, *Capitolato C7* - *Smart Dashboard*, C5]),
    ([D7], [Definite le convenzioni per git e GitHub: un branch per issue, integrazione tramite pull request revisionate dal *Verificatore*, *Conventional Commits*, riferimento alla issue nel messaggio di commit (`#numero` o `close #numero`)]),
    ([D8], [Definite le modalità del Glossario: PDF temporaneamente linkato dal sito e collegamento dei termini contrassegnati dal pedice G]),
    ([D9], [Definiti i ruoli per le prossime due settimane: *Responsabile* temporaneo: *Paolo Prevedello Ramirez*, *Verificatore*: *Chiara Protopapa*, *Analisti*: tutti gli altri membri del gruppo]),
    ([D10], [Pianificate le riunioni del 20/10, 23/10, 25/10 e 27/10/2026]),
  ),
  // Ogni riga: (ID, Nome attività, Descrizione, Responsabile, Scadenza)
  attivita-todo: (
    ([A1], [Email docenti], [Invio email ai docenti], [Paolo Prevedello Ramirez], [20/10/2026 (mattina)]),
    ([A2], [Email aziende], [Stesura della bozza dell'email alle aziende per richiedere un colloquio, da inoltrare al Responsabile], [Matteo Arcandi], [19/10/2026 (entro mezzanotte)]),
    ([A3], [Email aziende], [Invio dell'email alle aziende], [Paolo Prevedello Ramirez], [21/10/2026]),
    ([A4], [Telegram], [Creazione del gruppo Telegram], [Matteo Marcon], [20/10/2026]),
    ([A5], [Google Docs], [Creazione del file Google Docs per raccogliere le domande da porre alle aziende], [Matteo Marcon], [20/10/2026]),
    ([A6], [Google Docs], [Raccolta di domande e argomenti per le aziende], [Tutti], [21/10/2026]),
    ([A7], [YouTrack], [Valutazione di YouTrack e presentazione dei risultati], [Chiara Protopapa], [20/10/2026]),
    ([A8], [Sito], [Collegamento dei PDF dei verbali al sito], [Jacopo De Donà], [Da definire]),
    ([A9], [Verbale], [Redazione del verbale], [Jacopo De Donà], [21/10/2026]),
    ([A10], [Logo], [Cambio colore del logo], [Jacopo Franco, Riccardo Peresson], [Da definire]),
    ([A11], [Glossario], [Creazione bozza glossario], [Jacopo Franco, Riccardo Peresson], [Da definire]),
  ),
  ora-fine-riunione: "17:10",
  data-prossima-riunione: "20/10/2026 alle ore 16:00",
)

= Introduzione
Il presente documento attesta che, in data *19 ottobre 2026* dalle ore 16:00 alle ore 17:10,
si è tenuta, in modalità virtuale, la seconda riunione del gruppo *Memory Leakers*.

L'incontro aveva lo scopo di verificare il completamento delle attività precedenti, caratterizzare meglio il #gloss[*way of working*] per migliorare la gestione delle attività e dei ruoli, e pianificare le attività future.

= Resoconto

== Scelta dello strumento per la condivisione dei documenti
Dopo una breve discussione, è stato deciso di adottare #gloss[*Google Drive*] come strumento per la condivisione dei documenti, in quanto già utilizzato da tutti i membri del gruppo e ritenuto molto intuitivo e semplice da usare.

== Valutazione di uno strumento per la gestione delle attività
A seguito della necessità di organizzare le attività del gruppo in modo più efficiente, si sono discussi diversi strumenti, tra cui #gloss[*YouTrack*], #gloss[*Asana*] e #gloss[*Microsoft To Do*]. Si è infine deciso di valutare l'adozione di *YouTrack* come strumento per la gestione delle attività del gruppo, in quanto ritenuto il più adatto alle esigenze del gruppo. A Chiara Protopapa è stato affidato il compito di valutarne l'adozione e di presentare i risultati della valutazione nella prossima riunione.

== Aggiornamento dei canali di comunicazione
È stato adottato #gloss[*Telegram*] per la comunicazione interna del gruppo, in quanto ritenuto più adatto rispetto a #gloss[*WhatsApp*] per la gestione dei messaggi e delle informazioni, grazie anche alla possibilità di creare canali tematici.

== Discussione delle convenzioni per git e GitHub
Dopo una breve discussione è stato definito il #gloss[way of working] per git e GitHub, per garantire una gestione coerente ed efficiente del #gloss[repository]. Ogni membro del gruppo lavorerà su un #gloss[branch] dedicato alla #gloss[issue] di cui si occupa. Le modifiche saranno integrate nel branch principale tramite #gloss[pull request], previa revisione del #gloss[Verificatore]. Per quanto riguarda i messaggi di #gloss[commit], si è deciso di adottare i #gloss[*Conventional Commits*], per renderli più chiari e comprensibili. Ogni messaggio di commit deve indicare la issue a cui si riferisce, scrivendo `#numero` per un semplice riferimento oppure `close #numero` per chiudere la issue.

== Discussione dei capitolati
Dopo un'attenta analisi dei capitolati, è stato deciso di cambiare le priorità dei capitolati su cui il gruppo si concentrerà, aggiungendo un nuovo capitolato di interesse, il *Capitolato C7* - *Smart Dashboard*, proposto da Ergon. Il nuovo ordine di priorità è C6, C1, C7, C5. Prima degli incontri con le aziende, il file condiviso sarà popolato con le domande da porre.

== Gestione del sito e del glossario
Si è deciso di collegare al sito del gruppo, già pubblicato su #gloss[GitHub Pages], i PDF dei verbali; il compito è stato affidato a Jacopo De Donà. Il Glossario sarà temporaneamente reso disponibile come PDF linkato dal sito. Nei documenti, i termini contrassegnati dal pedice G rimanderanno alla rispettiva voce del glossario.

== Organizzazione dei ruoli e delle attività future
Data la necessità di una migliore organizzazione dei ruoli, si è deciso di nominare, per le prossime due settimane, un *Responsabile* temporaneo che avrà il compito di interfacciarsi con le aziende e con i docenti, e di coordinare le attività del gruppo. Il ruolo di *Responsabile* è stato affidato a Paolo Prevedello Ramirez. A Chiara Protopapa è stato affidato il ruolo di *Verificatore*, con il compito di verificare la correttezza dei documenti prodotti dal gruppo. Gli altri membri del gruppo assumeranno il ruolo di *Analista*.

== Pianificazione delle riunioni future
Sono state fissate le seguenti riunioni:
- martedì 20/10/2026 alle ore 16:00, dedicata al way of working;
- venerdì 23/10/2026 dalle ore 13:00 alle 14:00, per la preparazione del diario di bordo del 26/10/2026;
- lunedì 26/10/2026 dalle ore 14:00, per la stesura dell'analisi dei capitolati;
- martedì 27/10/2026 alle ore 13:00, per la continuazione della stesura.

= Decisioni e attività
Si è infine proceduto alla ripartizione delle attività individuate nel corso della riunione, riportata nella tabella seguente.