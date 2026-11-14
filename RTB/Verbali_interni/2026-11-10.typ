#import "../../Templates/Verbali.typ": gloss, verbale

#show: verbale.with(
  titolo: "Verbale interno del 10/11/2026",
  tipo-documento: "Verbale Interno",
  data: datetime(year: 2026, month: 11, day: 10),
  ora: "14:00 – 15:00",
  luogo: "Discord",
  versione: "0.1.0",
  stato: "Bozza",
  autore: "Riccardo Peresson",
  verificatore: "",
  file-nome: "2026-11-10.pdf",
  gruppo: "Memory Leakers",
  ordine-del-giorno: (
    [Introduzione template issue],
    [Cruscotto rendicontazione ore produttive],
    [Cambio formato data su sito],
    [Automazione modifiche alla documentazione],
    [Milestone RTB],
    [Varie ed eventuali],
  ),
  partecipanti: (
    "Matteo Arcandi",
    "Jacopo De Donà",
    "Jacopo Franco",
    "Matteo Marcon",
    "Riccardo Peresson",
    "Paolo Prevedello Ramirez",
    "Chiara Protopapa",
  ),
  distribuzione: ("Memory Leakers", "Prof. Riccardo Cardin", "Prof. Tullio Vardanega"),
  // Ogni riga: (Ver., Data, Descrizione, Autore, Verificatore)
  registro-modifiche: (
    ([0.1.1], [14/11/2026], [Integrazioni varie], [Riccardo Peresson], []),
    ([0.1.0], [13/11/2026], [Stesura del verbale del nono incontro], [Riccardo Peresson], [])
  ),
  // Ogni riga: (ID, Decisione presa)
  decisioni: (
    (
      [D1],
      [Adozione di un template per le issue]
    ),
    (  
      [D2],
      [Adozione di un cruscotto per la rendicontazione delle ore produttive da esporre sul sito web]
    ),
    (
      [D3],
      [Adozione del formato AAAA-MM-GG per le date nel sito web]
    ),
    (  
      [D4],
      [Adozione di 2 workflow per aggiornamento automatico registro modifiche dei documenti e dati sullo stato, uno inerente alla verifica e uno al rilascio da parte del resposnabile]
    ),
    (
      [D5],
      [Definizione di data per Milestone RTB e relative date delle milestone necessarie al conseguimento della stessa]
    )
  ),
  // Ogni riga: (ID, Nome attività, Descrizione, Responsabile, Scadenza, ID Decisione, Issue GitHub)
  attivita-todo: (
    (
      [A1],
      [Template issue],
      [Creare template per le issue migliorando tracciabilità, chiarezza e contesto],
      [Jacopo De Donà],
      [17/11/2026],
      [D1],
      [#link("https://github.com/MemoryLeakersTeam/Documenti/issues/60")[\#60]],
    ),
    (
      [A2],
      [Cruscotto ore produttive],
      [Inserire nel sito web cruscotto per la rendicontazione delle ore produttive],
      [Matteo Arcandi],
      [17/11/2026],
      [D2],
      [#link("https://github.com/MemoryLeakersTeam/MemoryLeakersTeam.github.io/issues/4")[\#4]],
    ),
    (
      [A3],
      [Formato AAAA-MM-GG],
      [Adottare il formato AAAA-MM-GG per la date nel sito web],
      [Matteo Arcandi],
      [17/11/2026],
      [D3],
      [#link("https://github.com/MemoryLeakersTeam/MemoryLeakersTeam.github.io/issues/5")[\#5]],
    ),
    (
      [A4],
      [Workflow modifica registro versioni dei documenti],
      [Implementare workflow che permettano aggiornamento dati verificatore alla PR e del respondabile all'approvazione],
      [Jacopo De Donà],
      [17/11/2026],
      [D4],
      [#link("https://github.com/MemoryLeakersTeam/Documenti/issues/65")[\#65], #link("https://github.com/MemoryLeakersTeam/Documenti/issues/66")[\#66]],
    ),
    (
      [A5],
      [Milestone RTB],
      [Definizione di data per Milestone RTB e relative date delle milestone necessarie al conseguimento della stessa],
      [Chiara Protopapa],
      [17/11/2026],
      [D5],
      [#link("https://github.com/MemoryLeakersTeam/Documenti/issues/62")[\#62]],
    ),
    (
      [A6],
      [Verbale interno],
      [Stesura verbale di questa riunione],
      [Riccardo Peresson],
      [13/11/2026],
      [],
      [#link("https://github.com/MemoryLeakersTeam/Documenti/issues/63")[\#63]],
    ),
    (
      [A7],
      [Diario di bordo],
      [Preparazione slide per il prossimo diario di bordo],
      [Chiara Protopapa],
      [16/11/2026],
      [],
      [#link("https://github.com/MemoryLeakersTeam/Documenti/issues/64")[\#64]],
    ),
  ),
  ora-fine-riunione: "15:00",
  data-prossima-riunione: "17/11/2026",
  ruoli-prossima-settimana: (
    ([*Responsabile*], [Chiara Protopapa]),
    ([*Amministratore*], [Jacopo De Donà]),
    ([*Verificatore*], [Jacopo Franco]),
    ([*Analisti*], [Matteo Arcandi, Matteo Marcon, Riccardo Peresson, Paolo Prevedello Ramirez]),
  ),
)

= Introduzione
Il presente documento attesta che, in data *10 novembre 2026* dalle ore 14:00 alle ore 15:00,
si è tenuta, in modalità virtuale, la nona riunione del gruppo *Memory Leakers*.

L'incontro è stato condotto, principalmente, al fine di individuare aree di miglioramento nella gestione del repo e della documentazione, in seguito ai suggerimenti ricevuti in aula.

= Resoconto

== Modifiche al sito web
A fini retrospettivi, inerenti alla disponibilità delle risorse del team in relazione all'avanzamento temporale del progetto, si è deciso di dotare il sito web di un cruscotto per la tracciabilità delle ore produttive di ciascun ruolo.

Inoltre si è deciso di procedere all'adozione del formato AAAA-MM-GG per le date esposte nel sito web.

== Template issue
Oggi le issue si aprono vuote: mancano quasi sempre verificatore, scadenza e collegamento con la decisione presa a verbale.
Nella valutazione della candidatura (2,25 punti sui verbali) il committente ha chiesto una tabella di tracciamento decisione → azione → assegnatario → issue → scadenza, senza azioni assegnate a «tutti» e senza scadenze «da definire».
Senza issue ben strutturate quella tabella non si può compilare: si opta quindi per l'impiego degli Issue forms di GitHub.

== Aggiornamento automatico documentazione
Oggi l'autore di un documento scrive a mano, nella sua pull request, la versione, lo stato e la riga del registro delle modifiche. Dopo la verifica, qualcuno deve aggiungere a mano anche il nome del verificatore. Ne derivano 3 problemi, ossia errori umani, conflitti tra 2 pull aperte sullo stesso documento e verifica non "read-only" (requisito del committente).
Come soluzione versione, stato, verificatore e registro li scrive un'automazione dopo il merge, direttamente su main; di conseguenza, si rimuovono dalla tabella "Controllo documentale" le voci "Autore", "Verificato da" e "In data", data la loro ridondanza.

Il rilascio di un documento lo approva solo il Responsabile, senza ulteriore verifica. Oggi la riga della versione definitiva, lo stato «Approvato» e la firma si scrivono a mano. Da quando c'è la pubblicazione automatica, questo passaggio decide anche cosa compare sul sito, che pubblica solo i documenti «Approvato».
Quando il Responsabile approva, il documento è già verificato e, di norma, non c'è più nulla da modificare: una pull request apposta sarebbe vuota.
Come soluzione un workflow attivato manualmente dal responsabile si occupa di configurare i dati per indicare il documento come approvato, inoltre aggiunge la firma del responsabile ed effettua commit su main.

== Datazione milestone RTB
Per un corretto monitoraggio dell'avanzamento di progetto, è necessario definire una data obbiettivo per la milestone RTB, con le relative date per le milestone intermedie necessarie. 

= Decisioni e attività
Si è infine proceduto alla ripartizione delle attività individuate nel corso della riunione, riportata nella tabella seguente.