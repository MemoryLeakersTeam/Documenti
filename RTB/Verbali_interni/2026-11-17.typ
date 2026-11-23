#import "../../Templates/Verbali.typ": gloss, verbale

// Collegamento a una voce del glossario sul sito
#let g(id, termine) = link(
  "https://memoryleakersteam.github.io/glossario#" + id,
  text(fill: black, gloss(termine)),
)

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
    [Ruoli dello sprint 2 e automazione dei verbali],
    [Organizzazione della riunione con Var Group],
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
      [Rendicontazione di preventivo, consuntivo e budget residuo delle ore in una sezione per sprint del Piano di Progetto]
    ),
    (
      [D19],
      [Aggiunta al cruscotto del sito della vista delle ore per ruolo e per persona]
    ),
    (
      [D20],
      [Adozione delle milestone 2026-11-30, 2026-12-18, 2027-01-12 e 2027-01-18 (RTB, prima della sessione d'esame)]
    ),
    (
      [D21],
      [Rotazione dei ruoli per lo sprint 2]
    ),
    (
      [D22],
      [Sperimentazione in locale di una pipeline per automatizzare la stesura dei verbali, a cura dell'Amministratore]
    ),
    (
      [D23],
      [Redazione del verbale di questa riunione e del diario di bordo della settimana]
    ),
    (
      [D24],
      [Avvio della stesura dell'Analisi dei Requisiti dopo la sessione di design thinking]
    ),
    (
      [D25],
      [Aggiornamento dei template dei documenti a cura dell'Amministratore]
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
      [D23],
      [#link("https://github.com/MemoryLeakersTeam/Documenti/issues/89")[\#89]],
    ),
    (
      [A17],
      [Diario di bordo],
      [Preparazione del diario di bordo della settimana],
      [Matteo Marcon],
      [2026-11-22],
      [D23],
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
      [Template dei documenti],
      [Adottare il formato AAAA-MM-GG e ridurre la tabella «Controllo Documentale» nei template],
      [Riccardo Peresson],
      [2026-11-18],
      [D25],
      [#link("https://github.com/MemoryLeakersTeam/Documenti/issues/79")[\#79], #link("https://github.com/MemoryLeakersTeam/Documenti/issues/81")[\#81]],
    ),
    (
      [A20],
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

// I collegamenti al glossario non vanno sottolineati
#show underline: it => it.body

= Introduzione
Il presente documento attesta che, in data *2026-11-17* dalle ore 14:10 alle ore 15:18,
si è tenuta, in modalità virtuale, la decima riunione del gruppo *Memory Leakers*.

L'incontro ha chiuso lo #g("sprint", "sprint") 1 con la #g("sprint-retrospective", "retrospettiva") sul lavoro svolto. Ha poi fissato le #g("milestone", "milestone") verso la #g("rtb", "RTB") e assegnato i ruoli dello sprint 2.

= Resoconto

== Retrospettiva dello sprint 1
Sono state riesaminate le attività dello sprint 1: la configurazione dell'#g("ci-cd", "integrazione continua") per versionamento e approvazione dei documenti, i #g("template", "template") per #g("issues", "issue") e #g("pull-request", "pull request") e la modifica al sito che mantiene pubblicata l'ultima versione approvata di un documento. È stato presentato il cruscotto delle #g("ore-produttive", "ore produttive"), nel quale le ore si registrano dal pannello di amministrazione e si esportano in CSV. Le ore dello sprint 1 sono state dichiarate da ciascun membro. I template dei documenti non adottano ancora il formato AAAA-MM-GG e la tabella «Controllo Documentale» ridotta, decisi il 2026-11-10: l'Amministratore apre la relativa issue e la risolve.

== Conferma delle decisioni prese in settimana
Il gruppo ha confermato le decisioni prese durante la settimana tramite messaggistica istantanea, relative alle attività assegnate nella riunione del 2026-11-10.

== Rendicontazione delle ore produttive
È stato valutato dove esporre #g("preventivo", "preventivo") e #g("consuntivo", "consuntivo") delle ore. Il documento ufficiale è il #g("piano-di-progetto", "Piano di Progetto"), mentre gli altri gruppi non pubblicano questi dati sul proprio sito. Si è quindi deciso di dedicare al Piano di Progetto una sezione per ogni sprint, con preventivo, consuntivo e ricalcolo del budget residuo; il ricalcolo serve anche alla lettera di presentazione della RTB, che richiede una nuova previsione dei costi. Il cruscotto resta uno strumento interno e si arricchisce della vista delle ore per ruolo e per persona.

La prima bozza del Piano di Progetto spetta a un analista e riporta sia lo sprint 1 sia lo sprint 2.

== Milestone
La RTB è fissata prima della sessione d'esame: la consegna finale è prevista per il 2027-03-23 e presentare dopo la sessione significherebbe pianificare un ritardo. Il gruppo ha adottato queste milestone:
- 2026-11-30: base di analisi e conoscenza delle tecnologie;
- 2026-12-18: validazione dell'#g("analisi-dei-requisiti", "Analisi dei Requisiti"), con l'obiettivo di chiudere entro il 2026-12-11;
- 2027-01-12: #g("poc", "PoC"), che può iniziare prima della chiusura dell'analisi;
- 2027-01-18: RTB.

L'Amministratore crea le milestone su GitHub, e ogni nuova issue va associata a una milestone. Le domande 3 e 4 della issue \#62, sulle ore disponibili per sprint e sul margine fino al 2027-03-23, sono rinviate alla riunione del 2026-11-24.

== Ruoli dello sprint 2 e automazione dei verbali
Sono stati assegnati i ruoli dello sprint 2, riportati nella tabella in fondo al documento. Jacopo De Donà passa al ruolo di Verificatore e Jacopo Franco a quello di Analista. Riccardo Peresson, come Amministratore, sperimenta in locale una #g("pipeline", "pipeline") per automatizzare la stesura dei verbali; le automazioni esistenti restano invariate e l'impegno stimato è di circa un'ora.

== Riunione con Var Group
La #g("design-thinking", "sessione di design thinking") con Var Group si tiene il 2026-11-18 in presenza, dalle ore 14:00 alle ore 17:00. Il Responsabile è l'interlocutore principale e redige gli appunti nel documento condiviso; gli altri membri aggiungono le proprie domande. La stesura dell'Analisi dei Requisiti inizia dopo la sessione, e gli analisti concordano tra loro la ripartizione del lavoro.

= Decisioni e attività
Si è infine proceduto alla ripartizione delle attività individuate nel corso della riunione, riportata nella tabella seguente.
