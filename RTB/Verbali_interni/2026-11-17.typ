#import "../../Templates/Verbali.typ": gloss, verbale

#show: verbale.with(
  dati: yaml("2026-11-17.yml"),
  titolo: "Verbale interno del 2026-11-17",
  tipo-documento: "Verbale Interno",
  data: datetime(year: 2026, month: 11, day: 17),
  ora: "14:10 – 15:18",
  luogo: "Discord",
  autore: "Matteo Arcandi",
  file-nome: "2026-11-17.pdf",
  gruppo: "Memory Leakers",
  ordine-del-giorno: (
    [Retrospettiva dello sprint 1],
    [Conferma delle decisioni prese in settimana tramite messaggistica],
    [Rendicontazione delle ore produttive],
    [Valutazione delle proposte di milestone],
    [Ruoli dello sprint 2],
    [Pipeline per l'automazione dei verbali],
    [Modifica delle Norme di Progetto],
    [Issue per il formato delle date e per i template dei documenti],
    [Organizzazione della riunione con Var Group],
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
      [D18],
      [Rendicontazione di preventivo, consuntivo e budget residuo delle ore in una sezione per sprint del Piano di Progetto; il cruscotto del sito resta uno strumento interno]
    ),
    (
      [D19],
      [Aggiunta al cruscotto del sito della vista delle ore per ruolo e per persona]
    ),
    (
      [D20],
      [Adozione delle milestone 2026-11-30 (base di analisi e conoscenza delle tecnologie), 2026-12-18 (validazione dell'Analisi dei Requisiti), 2027-01-12 (PoC) e 2027-01-18 (RTB, prima della sessione d'esame)]
    ),
    (
      [D21],
      [Eliminazione dalle Norme di Progetto della regola che limita a 3 giorni la vita di un branch]
    ),
    (
      [D22],
      [Rotazione dei ruoli per lo sprint 2: Matteo Marcon Responsabile, Riccardo Peresson Amministratore, Jacopo De Donà Verificatore, gli altri Analisti]
    ),
    (
      [D23],
      [Riccardo Peresson, come Amministratore dello sprint 2, sperimenta in locale una pipeline per automatizzare la stesura dei verbali; le automazioni esistenti restano invariate]
    ),
    (
      [D24],
      [Redazione del verbale di questa riunione e del diario di bordo della settimana]
    ),
    (
      [D25],
      [Avvio della stesura dell'Analisi dei Requisiti dopo la sessione di design thinking, con ripartizione del lavoro concordata tra gli analisti]
    ),
    (
      [D26],
      [Affidamento all'Amministratore della modifica dei template dei documenti (formato AAAA-MM-GG e tabella «Controllo Documentale» ridotta), con apertura della relativa issue]
    ),
  ),
  // Ogni riga: (ID, Nome attività, Descrizione, Responsabile, Scadenza, ID Decisione, Issue GitHub)
  attivita-todo: (
    (
      [A16],
      [Verbale interno],
      [Stesura del verbale di questa riunione],
      [Matteo Arcandi],
      [2026-11-20],
      [D24],
      [#link("https://github.com/MemoryLeakersTeam/Documenti/issues/89")[\#89]],
    ),
    (
      [A17],
      [Diario di bordo],
      [Preparazione del diario di bordo della settimana],
      [Matteo Marcon],
      [2026-11-22],
      [D24],
      [#link("https://github.com/MemoryLeakersTeam/Documenti/issues/88")[\#88]],
    ),
    (
      [A18],
      [Bozza del Piano di Progetto],
      [Redigere la prima bozza con la sezione degli sprint 1 e 2: preventivo, consuntivo e budget residuo],
      [Jacopo Franco],
      [2026-11-24],
      [D18],
      [#link("https://github.com/MemoryLeakersTeam/Documenti/issues/91")[\#91]],
    ),
    (
      [A19],
      [Norme di Progetto],
      [Eliminare la regola dei 3 giorni di vita di un branch],
      [Riccardo Peresson],
      [2026-11-24],
      [D21],
      [#link("https://github.com/MemoryLeakersTeam/Documenti/issues/92")[\#92]],
    ),
    (
      [A20],
      [Template dei documenti],
      [Adottare il formato AAAA-MM-GG e ridurre la tabella «Controllo Documentale» nei template],
      [Riccardo Peresson],
      [2026-11-18],
      [D26],
      [#link("https://github.com/MemoryLeakersTeam/Documenti/issues/79")[\#79], #link("https://github.com/MemoryLeakersTeam/Documenti/issues/81")[\#81]],
    ),
    (
      [A21],
      [Vista ore per ruolo e persona],
      [Aggiungere al cruscotto del sito la vista delle ore svolte per ruolo e per persona],
      [Matteo Arcandi],
      [2026-11-24],
      [D19],
      [#link("https://github.com/MemoryLeakersTeam/MemoryLeakersTeam.github.io/issues/10")[\#10]],
    ),
  ),
  ora-fine-riunione: "15:18",
  data-prossima-riunione: "2026-11-24",
  ruoli-prossima-settimana: (
    ([*Responsabile*], [Matteo Marcon]),
    ([*Amministratore*], [Riccardo Peresson]),
    ([*Verificatore*], [Jacopo De Donà]),
    ([*Analisti*], [Matteo Arcandi, Chiara Protopapa, Jacopo Franco, Paolo Prevedello Ramirez]),
  ),
)

= Introduzione
Il presente documento attesta che, in data *17 novembre 2026* dalle ore 14:10 alle ore 15:18,
si è tenuta, in modalità virtuale, la decima riunione del gruppo *Memory Leakers*.

L'incontro ha chiuso lo sprint 1 con una retrospettiva sul lavoro svolto e sulle ore produttive. Ha poi fissato le milestone verso la RTB e assegnato i ruoli dello sprint 2.

= Resoconto

== Retrospettiva dello sprint 1
Jacopo De Donà ha riferito sulla configurazione dell'integrazione continua per versionamento e approvazione, sulle relative modifiche alle Norme di Progetto e sui template per issue e pull request. Ha riferito anche una modifica al sito: un documento approvato resta pubblicato anche quando esiste una nuova versione solo verificata.

Matteo Arcandi ha presentato il cruscotto delle ore produttive del sito. Il file dei dati contiene il preventivo, gli sprint e le voci inserite; le voci si aggiungono dal pannello di amministrazione e si possono esportare in CSV. Si possono inserire anche le ore degli sprint precedenti. Per la regola d'uso non ha modificato il Way of Working, in attesa di un parere del gruppo; Jacopo De Donà aggiungerà una sezione sul cruscotto alle Norme di Progetto.

Le ore produttive dichiarate per lo sprint 1 sono:
- Jacopo De Donà: 5 ore, per la configurazione dell'integrazione continua e dei template;
- Matteo Arcandi: 2 ore, per il cruscotto delle ore;
- Matteo Marcon: 0,5 ore, per il primo verbale esterno;
- Chiara Protopapa: 1,5 ore, per l'analisi del calendario delle milestone e le comunicazioni esterne;
- Jacopo Franco: 4 ore, per la verifica dei documenti;
- Paolo Prevedello Ramirez: 0,5 ore, per il verbale interno del 2026-11-03;
- Riccardo Peresson: 0,5 ore, per il verbale interno del 2026-11-10.

== Conferma delle decisioni prese in settimana
Il gruppo ha confermato le decisioni prese durante la settimana tramite messaggistica istantanea, relative alle attività assegnate nella riunione del 2026-11-10.

== Rendicontazione delle ore nel Piano di Progetto
Il gruppo ha discusso dove esporre preventivo e consuntivo delle ore. Il documento ufficiale è il Piano di Progetto, e gli altri gruppi non pubblicano questi dati sul proprio sito. Il gruppo ha quindi deciso di dedicare al Piano di Progetto una sezione per ogni sprint, con preventivo, consuntivo e ricalcolo del budget residuo. Il ricalcolo serve anche alla lettera di presentazione della RTB, che richiede una nuova previsione dei costi. Il cruscotto resta uno strumento interno, a cui si aggiunge la vista delle ore per ruolo e per persona.

La prima bozza del Piano di Progetto spetta a un analista e riporta sia lo sprint 1 sia lo sprint 2, perché il documento è in ritardo di uno sprint.

== Milestone
Chiara Protopapa ha proposto un calendario delle milestone. La RTB è fissata prima della sessione d'esame, perché la consegna finale è prevista per il 2027-03-23 e presentare dopo la sessione significherebbe pianificare un ritardo. Il gruppo ha adottato queste milestone:
- 2026-11-30: base di analisi e conoscenza delle tecnologie;
- 2026-12-18: validazione dell'Analisi dei Requisiti, con l'obiettivo di chiudere entro il 2026-12-11;
- 2027-01-12: PoC, che può iniziare prima della chiusura dell'analisi;
- 2027-01-18: RTB.

Riccardo Peresson, come Amministratore, crea le milestone su GitHub; ogni nuova issue va associata a una milestone.

Restano aperte le domande sulle ore disponibili per sprint e sul margine fino al 2027-03-23: il gruppo le tratta nella prossima riunione.

== Ruoli dello sprint 2
Riccardo Peresson ha chiesto di passare al ruolo di Amministratore per sperimentare in locale una pipeline che automatizzi la stesura dei verbali. Ha precisato che le automazioni esistenti restano invariate e che l'impegno stimato è di circa un'ora. Jacopo De Donà ha espresso il timore di perdere ore e di vanificare il lavoro dello sprint 1; il gruppo ha accolto la proposta.

Jacopo Franco ha chiesto di chiudere le verifiche in corso prima di cambiare ruolo. Jacopo De Donà ha preso il suo posto come Verificatore e Jacopo Franco è passato ai compiti di Analista.

== Norme di Progetto
Il gruppo ha rilevato che la regola dei 3 giorni di vita massima di un branch viene superata spesso nella pratica. Ha quindi deciso di eliminarla dalle Norme di Progetto.

== Analisi dei Requisiti, issue e template
L'Analisi dei Requisiti inizia dopo la sessione di design thinking. Gli analisti concordano tra loro come ripartire il lavoro. Riccardo Peresson, come Amministratore, apre le issue per la bozza dell'Analisi dei Requisiti, per la bozza del Piano di Progetto, per il diario di bordo e per i verbali.

I template dei documenti non sono ancora aggiornati con il formato AAAA-MM-GG e con la tabella «Controllo Documentale» ridotta, decisi il 2026-11-10. Spetta all'Amministratore aprire la relativa issue e risolverla.

Il Responsabile carica e rilascia sempre i diari di bordo. Chiara Protopapa ha dichiarato pronto il diario di bordo del 2026-11-16, che pubblica dopo la riunione.

== Organizzazione della riunione con Var Group
La riunione con Var Group si tiene il 2026-11-18 in presenza, dalle ore 14:00 alle ore 17:00. Matteo Marcon, come Responsabile, è l'interlocutore principale e scrive gli appunti nel documento condiviso. Gli altri membri lo seguono e aggiungono le proprie domande a partire dall'analisi preparata da Riccardo Peresson.

= Decisioni e attività
Si è infine proceduto alla ripartizione delle attività individuate nel corso della riunione, riportata nella tabella seguente.
