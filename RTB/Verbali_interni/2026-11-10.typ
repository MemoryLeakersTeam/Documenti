#import "../../Templates/Verbali.typ": gloss, verbale

#show: verbale.with(
  dati: yaml("2026-11-10.yml"),
  titolo: "Verbale interno del 10/11/2026",
  tipo-documento: "Verbale Interno",
  data: datetime(year: 2026, month: 11, day: 10),
  ora: "14:00 – 15:00",
  luogo: "Discord",
  autore: "Riccardo Peresson",
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

  // Ogni riga: (ID, Decisione presa)
  decisioni: (
    (
      [D10],
      [Adozione di un template per le issue]
    ),
    (  
      [D11],
      [Adozione di un cruscotto per la rendicontazione delle ore produttive da esporre sul sito web]
    ),
    (
      [D12],
      [Adozione del formato AAAA-MM-GG per le date nel sito web e documenti]
    ),
    (  
      [D13],
      [Adozione di 2 workflow per aggiornamento automatico registro modifiche dei documenti e dati sullo stato, uno inerente alla verifica e uno al rilascio da parte del responsabile]
    ),
    (
      [D14],
      [Definizione di data per Milestone RTB e relative date delle milestone necessarie al conseguimento della stessa]
    ),
     (
      [D15],
      [Deciso di procedere alla stesura del verbale per questo incontro]
    ),
    (
      [D16],
      [Deciso di procedere con la stesura del prossimo diario di bordo]
    )
  ),
  // Ogni riga: (ID, Nome attività, Descrizione, Responsabile, Scadenza, ID Decisione, Issue GitHub)
  attivita-todo: (
    (
      [A9],
      [Template issue],
      [Creare template per le issue migliorando tracciabilità, chiarezza e contesto],
      [Jacopo De Donà],
      [2026-11-17],
      [D10],
      [#link("https://github.com/MemoryLeakersTeam/Documenti/issues/60")[\#60]],
    ),
    (
      [A10],
      [Cruscotto ore produttive],
      [Inserire nel sito web cruscotto per la rendicontazione delle ore produttive],
      [Matteo Arcandi],
      [2026-11-17],
      [D11],
      [#link("https://github.com/MemoryLeakersTeam/MemoryLeakersTeam.github.io/issues/4")[\#4]],
    ),
    (
      [A11],
      [Formato AAAA-MM-GG],
      [Adottare il formato AAAA-MM-GG per le date nel sito web],
      [Matteo Arcandi],
      [2026-11-17],
      [D12],
      [#link("https://github.com/MemoryLeakersTeam/MemoryLeakersTeam.github.io/issues/5")[\#5]],
    ),
    (
      [A12],
      [Workflow modifica registro versioni dei documenti],
      [Implementare workflow che permettano aggiornamento dati verificatore alla PR e all'approvazione del respondabile],
      [Jacopo De Donà],
      [2026-11-17],
      [D13],
      [#link("https://github.com/MemoryLeakersTeam/Documenti/issues/65")[\#65], #link("https://github.com/MemoryLeakersTeam/Documenti/issues/66")[\#66]],
    ),
    (
      [A13],
      [Milestone RTB],
      [Definizione di data per Milestone RTB e relative date delle milestone necessarie al conseguimento della stessa],
      [Chiara Protopapa],
      [2026-11-17],
      [D14],
      [#link("https://github.com/MemoryLeakersTeam/Documenti/issues/62")[\#62]],
    ),
    (
      [A14],
      [Verbale interno],
      [Stesura verbale di questa riunione],
      [Riccardo Peresson],
      [2026-11-13],
      [D15],
      [#link("https://github.com/MemoryLeakersTeam/Documenti/issues/63")[\#63]],
    ),
    (
      [A15],
      [Diario di bordo],
      [Preparazione slide per il prossimo diario di bordo],
      [Chiara Protopapa],
      [2026-11-16],
      [D16],
      [#link("https://github.com/MemoryLeakersTeam/Documenti/issues/64")[\#64]],
    ),
  ),
  ora-fine-riunione: "15:00",
  data-prossima-riunione: "2026-11-17",
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

Inoltre, su richiesta del committente, si è deciso di adottare il formato AAAA-MM-GG per le date del sito web e dei documenti: mettendo l’anno per primo, le date si ordinano e si cercano più facilmente, e il formato non è ambiguo.

== Template issue
Oggi le issue si aprono vuote: mancano quasi sempre verificatore, scadenza e collegamento con la decisione presa a verbale.
Nella valutazione della candidatura (2,25 punti sui verbali) il committente ha chiesto una tabella di tracciamento decisione → azione → assegnatario → issue → scadenza, senza azioni assegnate a «tutti» e senza scadenze «da definire».
Senza issue ben strutturate quella tabella non si può compilare: si opta quindi per l'impiego degli Issue forms di GitHub.

== Aggiornamento automatico documentazione
Oggi l'autore di un documento scrive a mano, nella sua pull request, la versione, lo stato e la riga del registro delle modifiche. Dopo la verifica, qualcuno deve aggiungere a mano anche il nome del verificatore. Ne derivano 3 problemi, ossia errori umani, conflitti tra 2 pull request aperte sullo stesso documento e verifica non "read-only" (requisito del committente).
Come soluzione versione, stato, verificatore e registro li scrive un'automazione dopo il merge, direttamente su main; di conseguenza, si rimuovono dalla tabella "Controllo documentale" le voci "Autore", "Verificato da" e "In data", data la loro ridondanza.

Il rilascio di un documento lo approva solo il Responsabile, senza ulteriore verifica. Oggi la riga della versione definitiva, lo stato «Approvato» e la firma si scrivono a mano. Da quando c'è la pubblicazione automatica, questo passaggio decide anche cosa compare sul sito, che pubblica solo i documenti «Approvato».
Quando il Responsabile approva, il documento è già verificato e, di norma, non c'è più nulla da modificare: una pull request apposta sarebbe vuota.
Come soluzione un workflow attivato manualmente dal responsabile si occupa di configurare i dati per indicare il documento come approvato, inoltre aggiunge la firma del responsabile ed effettua commit su main.

== Datazione milestone RTB
Per un corretto monitoraggio dell'avanzamento di progetto, è necessario definire una data obiettivo per la milestone RTB, con le relative date per le milestone intermedie necessarie. 

= Decisioni e attività
Si è infine proceduto alla ripartizione delle attività individuate nel corso della riunione, riportata nella tabella seguente.