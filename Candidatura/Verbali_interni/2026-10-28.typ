#import "../../Templates/Verbali.typ": verbale, gloss

#show: verbale.with(
  titolo: "Verbale interno del 28/10/2026",
  tipo-documento: "Verbale Interno",
  data: datetime(year: 2026, month: 10, day: 28),
  ora: "15:00 – 17:00",
  luogo: "Google Meet",
  versione: "0.1.0",
  stato: "Verificato",
  autore: "Jacopo De Donà",
  verificatore: "Chiara Protopapa",
  file-nome: "2026-10-28.pdf",
  gruppo: "Memory Leakers",
  ordine-del-giorno: (
    [Comunicazioni con VarGroup S.p.A.],
    [Revisione della Lettera di presentazione e dell'Analisi dei capitolati],
    [Completamento del glossario],
    [Pianificazione della prossima riunione],
    [Varie ed eventuali],
  ),
  partecipanti: (
    "Matteo Arcandi", "Jacopo De Donà", "Jacopo Franco",
    "Matteo Marcon", "Riccardo Peresson", "Paolo Prevedello Ramirez", "Chiara Protopapa",
  ),
  distribuzione: ("Memory Leakers", "Prof. Riccardo Cardin", "Prof. Tullio Vardanega"),
  // Ogni riga: (Ver., Data, Descrizione, Autore, Verificatore)
  registro-modifiche: (
    ([0.1.0], [29/10/2026], [Prima revisione del verbale], [Jacopo De Donà], [Chiara Protopapa]),
    ([0.0.1], [29/10/2026], [Bozza del settimo incontro], [Jacopo De Donà], []),
  ),
  // Ogni riga: (ID, Decisione presa)
  decisioni: (
    ([D1], [Deciso di inviare nuovamente a *VarGroup S.p.A.* il verbale esterno da firmare, a causa di un refuso sulla data]),
    ([D2], [Decisa la revisione del documento *Way of Working* per chiarire alcuni punti che avevano generato malintesi]),
    ([D3], [Decisa la modifica del logo presente nella *Lettera di presentazione*]),
    ([D4], [Deciso di completare il glossario prima della consegna dei documenti di candidatura]),
  ),
  // Ogni riga: (ID, Nome attività, Descrizione, Responsabile, Scadenza)
  attivita-todo: (
    ([A1], [Email aziende], [Nuovo invio a VarGroup S.p.A. del verbale esterno da firmare], [Paolo Prevedello Ramirez], [28/10/2026]),
    ([A2], [Way of Working], [Revisione del documento Way of Working], [Riccardo Peresson], [30/10/2026]),
    ([A3], [Lettera di presentazione], [Modifica del logo presente nella Lettera di presentazione], [Paolo Prevedello Ramirez], [28/10/2026]),
    ([A4], [Analisi dei capitolati], [Stesura in Typst dell'Analisi dei capitolati], [Matteo Arcandi, Jacopo Franco, Riccardo Peresson], [29/10/2026]),
    ([A5], [Glossario], [Completamento del glossario], [Jacopo Franco], [Da definire]),
    ([A6], [Verbale], [Redazione del verbale interno], [Jacopo De Donà], [29/10/2026]),
  ),
  ora-fine-riunione: "17:00",
  data-prossima-riunione: "da definire, a seguito dell'aggiudicazione dei capitolati",
)

= Introduzione
Il presente documento attesta che, in data *28 ottobre 2026* dalle ore 15:00 alle ore 17:00,
si è tenuta, in modalità virtuale, la settima riunione del gruppo *Memory Leakers*.

L'incontro ha dato seguito alla riunione del 27/10/2026 ed è stato dedicato principalmente alla revisione dei documenti di candidatura prodotti finora, in particolare della *Lettera di presentazione*, della *Dichiarazione degli impegni* e dell'*Analisi dei capitolati*.

= Resoconto

== Comunicazioni con VarGroup
Poiché il verbale esterno inviato a *VarGroup S.p.A.* per la firma conteneva un refuso sulla data, il gruppo ha deciso di correggerlo ed inviarlo nuovamente all'azienda.

== Revisione del Way of Working
Per chiarire alcuni punti che avevano generato malintesi, si è ritenuto necessario apportare piccole modifiche al documento *Way of Working*.

== Revisione dei documenti di candidatura
Il gruppo ha esaminato i documenti di candidatura redatti finora, apportando alcuni cambiamenti e stabilendo di:
- modificare il logo presente nella *Lettera di presentazione*;
- completare la stesura in Typst dell'*Analisi dei capitolati*.

== Completamento del glossario
È emersa la necessità di completare il glossario prima della consegna dei documenti di candidatura.

== Pianificazione della prossima riunione
Si è deciso di rimandare la definizione della data della prossima riunione interna a dopo l'aggiudicazione dei capitolati.

= Decisioni e attività
Si è infine proceduto alla ripartizione delle attività individuate nel corso della riunione, riportata nella tabella seguente.
