#import "../../Templates/Verbali.typ": verbale, gloss

#show: verbale.with(
  titolo: "Verbale interno del 20/10/2026",
  tipo-documento: "Verbale Interno",
  data: datetime(year: 2026, month: 10, day: 20),
  ora: "16:00 – 16:50",
  luogo: "Google Meet",
  versione: "1.0.0",
  stato: "Approvato",
  autore: "Jacopo De Donà",
  verificatore: "Chiara Protopapa",
  file-nome: "2026-10-20.pdf",
  gruppo: "Memory Leakers",
  ordine-del-giorno: (
    [Verifica del completamento delle attività assegnate nella riunione precedente],
    [Presentazione dei risultati della valutazione di YouTrack e scelta dello strumento per la gestione delle attività],
    [Definizione della struttura della bozza del Way of Working],
    [Presentazione del logo aggiornato],
    [Ripartizione delle attività],
    [Varie ed eventuali],
  ),
  partecipanti: (
    "Matteo Arcandi", "Jacopo De Donà", "Jacopo Franco",
    "Matteo Marcon", "Riccardo Peresson", "Paolo Prevedello Ramirez", "Chiara Protopapa",
  ),
  distribuzione: ("Memory Leakers", "Prof. Riccardo Cardin", "Prof. Tullio Vardanega"),
  // Ogni riga: (Ver., Data, Descrizione, Autore, Verificatore)
  registro-modifiche: (
    ([1.0.0], [25/10/2026], [Firma ed approvazione del verbale], [Jacopo De Donà], [Paolo Prevedello Ramirez]),
    ([0.1.0], [23/10/2026], [Prima revisione del verbale], [Jacopo De Donà], [Chiara Protopapa]),
    ([0.0.1], [20/10/2026], [Bozza del terzo incontro], [Jacopo De Donà], []),
  ),
  // Ogni riga: (ID, Decisione presa)
  decisioni: (
    ([D1], [Adottato GitHub Projects per la pianificazione e l'avanzamento delle attività.]),
    ([D2], [Riunione fissa ogni martedì dalle 14:00 alle 15:00 a partire dall'aggiudicazione.]),
    ([D3], [Adottato un modello di branching per i repository.]),
    ([D4], [Commit in inglese secondo la convenzione Conventional Commits.]),
    ([D5], [Sprint di due settimane con rotazione dei ruoli a ogni sprint a partire dall'aggiudicazione.]),
    ([D6], [Creazione della bozza del glossario affidata esclusivamente a Jacopo Franco]),
  ),
  // Ogni riga: (ID, Nome attività, Descrizione, Responsabile, Scadenza)
  attivita-todo: (
    ([A1], [Creazione Project GitHub], [Creazione del Project su GitHub per la gestione delle attività tramite board Kanban], [Matteo Marcon], [21/10/2026]),
    ([A2], [Stesura Way of Working], [Stesura del documento Way of Working a partire dalla bozza concordata], [Riccardo Peresson], [da definire]),
    ([A3], [Stesura template], [Stesura del template Typst per i documenti generici], [Chiara Protopapa], [da definire]),
    ([A4], [Glossario], [Creazione bozza glossario], [Jacopo Franco], [da definire]),
  ),
  ora-fine-riunione: "16:50",
  data-prossima-riunione: "23/10/2026 alle ore 13:00",
  firma-responsabile: "Paolo Prevedello Ramirez"
)

= Introduzione
Il presente documento attesta che, in data *20 ottobre 2026* dalle ore 16:00 alle ore 16:50,
si è tenuta, in modalità virtuale, la terza riunione del gruppo *Memory Leakers*.

L'incontro è stato dedicato all'avvio della stesura del documento che descrive il #gloss[*way of working*] del gruppo. In particolare, sono stati definiti lo #gloss[*stack di lavoro*], la struttura dei repository, le regole per la gestione dei #gloss[*branch*] e per l'avanzamento delle #gloss[*issue*], nonché l'organizzazione del team e delle riunioni periodiche.

Per informazioni più dettagliate, fare riferimento al documento aggiornato.

= Resoconto
Il gruppo ha concordato la struttura della bozza del Way of Working, che comprenderà un'introduzione, la descrizione del metodo di lavoro, gli strumenti e le norme per la documentazione e l'organizzazione in #gloss[*sprint*]. I dettagli di quanto definito saranno riportati nel documento stesso.

Per la gestione delle attività sono stati valutati GitHub Projects e YouTrack; quest'ultimo è stato scartato per mantenere tutto il lavoro all'interno di GitHub.

È stata inoltre presentata la versione aggiornata del logo del gruppo che verrà integrata in tutti i documenti.


= Decisioni e attività
Si è infine proceduto alla ripartizione delle attività individuate nel corso della riunione, riportata nella tabella seguente.