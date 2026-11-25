#import "../../Templates/Verbali.typ": gloss, verbale

// Collegamento a una voce del glossario sul sito
#let g(id, termine) = link(
  "https://memoryleakersteam.github.io/glossario#" + id,
  text(fill: black, gloss(termine)),
)

#show: verbale.with(
  dati: yaml("2026-11-24.yml"),
  titolo: "Verbale interno del 2026-11-24",
  tipo-documento: "Verbale Interno",
  data: datetime(year: 2026, month: 11, day: 24),
  ora: "14:00 – 15:45",
  luogo: "Discord",
  autore: "Paolo Prevedello Ramirez",
  file-nome: "2026-11-24.pdf",
  gruppo: "Memory Leakers",
  ordine-del-giorno: (
    [Gestione del repository e del sito web],
    [Revisione del flusso architetturale: caching semantico e dialoghi multiturno],
    [Analisi dei Requisiti e scelta delle tecnologie],
    [Piano di Progetto e Norme di Progetto],
    [Organizzazione di GitHub e automazione dei verbali],
    [Pianificazione della formazione con Var Group],
    [Preparazione dello stand-up di venerdì con Var Group],
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
      [D26],
      [Il merge di una pull request spetta al suo autore dopo l'approvazione del verificatore; l'approvazione al rilascio del Responsabile è richiesta solo per il sito web],
    ),
    (
      [D27],
      [Esclusione dei filtri per ruolo e ore residue dalla sezione interna delle ore del sito],
    ),
    (
      [D28],
      [Aggiunta al diagramma di flusso del controllo che interrompe l'elaborazione ed evita il salvataggio in cache in caso di errore o timeout di Bedrock],
    ),
    (
      [D29],
      [Riorganizzazione dell'Analisi dei Requisiti per aree funzionali: Dashboard (Jacopo Franco e Matteo Arcandi) e caching semantico (Chiara Protopapa e Paolo Prevedello Ramirez)],
    ),
    (
      [D30],
      [Posticipo della scadenza della issue sulla scelta delle tecnologie alla fine della prossima settimana],
    ),
    (
      [D31],
      [Calcolo del preventivo ore degli sprint sulle sole issue produttive, con ore stimate pari a 0 per i verbali],
    ),
    (
      [D32],
      [Abbandono dell'automazione dei verbali tramite LLM e mantenimento della stesura manuale],
    ),
  ),
  // Ogni riga: (ID, Nome attività, Descrizione, Responsabile, Scadenza, ID Decisione, Issue GitHub)
  attivita-todo: (
    (
      [A21],
      [Materiale per lo stand-up],
      [Invio su Teams a Var Group del diagramma di flusso aggiornato e del mini ordine del giorno],
      [Matteo Marcon],
      [2026-11-26],
      [D28],
      [#link("https://github.com/MemoryLeakersTeam/Documenti/issues/98")[\#98]],
    ),
    (
      [A22],
      [Piano di Progetto],
      [Nuova versione minor con analisi dei rischi, preventivi degli sprint e sezione sull'analisi dei requisiti],
      [Jacopo Franco],
      [2026-12-01],
      [D31],
      [#link("https://github.com/MemoryLeakersTeam/Documenti/issues/106")[\#106]],
    ),
    (
      [A23],
      [Norme di Progetto],
      [Aggiornamento con la regola sul merge delle pull request, la non produttività delle ore dei verbali e le norme per l'analisi dei requisiti],
      [Riccardo Peresson],
      [2026-12-01],
      [D26, D31],
      [#link("https://github.com/MemoryLeakersTeam/Documenti/issues/107")[\#107]],
    ),
    (
      [A24],
      [Analisi dei Requisiti: Dashboard],
      [Prosecuzione della bozza con la sezione Dashboard, attori e casi d'uso],
      [Matteo Arcandi, Jacopo Franco],
      [2026-11-28],
      [D29],
      [#link("https://github.com/MemoryLeakersTeam/Documenti/issues/87")[\#87]],
    ),
    (
      [A25],
      [Analisi dei Requisiti: caching semantico],
      [Prosecuzione della bozza con la sezione caching semantico, attori e casi d'uso],
      [Chiara Protopapa, Paolo Prevedello Ramirez],
      [2026-11-28],
      [D29],
      [#link("https://github.com/MemoryLeakersTeam/Documenti/issues/87")[\#87]],
    ),
    (
      [A26],
      [Verbale interno],
      [Stesura del verbale di questa riunione],
      [Paolo Prevedello Ramirez],
      [2026-11-27],
      [D32],
      [#link("https://github.com/MemoryLeakersTeam/Documenti/issues/108")[\#108]],
    ),
  ),
  ora-fine-riunione: "15:45",
  data-prossima-riunione: "2026-12-01",
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
Il presente documento attesta che, in data *2026-11-24* dalle ore 14:00 alle ore 15:45,
si è tenuta, in modalità virtuale, l'undicesima riunione del gruppo *Memory Leakers*.

L'incontro ha fatto il punto sul lavoro in corso, ha rivisto il flusso architetturale del caching semantico, ha riorganizzato l'#g("analisi-dei-requisiti", "Analisi dei Requisiti") e ha preparato lo stand-up di venerdì e la formazione con Var Group.

= Resoconto

== Gestione del repository e del sito web
È stato confermato il flusso di approvazione: chi apre una #g("pull-request", "pull request") la mergia autonomamente dopo l'approvazione del verificatore. Il Responsabile interviene per approvare il rilascio solo per quanto riguarda il sito web.

Le date delle vecchie versioni sul sito sono state sistemate manualmente, mentre lo script aggiorna ora automaticamente anno, mese e giorno dei nuovi rilasci; non risultano issue aperte in merito.

Il gruppo ha valutato l'aggiunta di filtri per ruolo e per ore residue nella sezione interna delle ore del sito. Si è deciso di non procedere, perché l'aspetto è puramente estetico e interno e non giustifica il tempo necessario.

== Revisione del flusso architetturale: caching semantico e dialoghi multiturno
Per gestire il contesto nei dialoghi multiturno sono state analizzate due alternative:
+ l'introduzione di un mini-LLM che riformula la domanda con il contesto, con il rischio di superare il limite massimo di overhead di 0,5 s;
+ l'introduzione dello «stato», cioè del contesto salvato in parallelo in assenza di dati sensibili, da combinare con la domanda successiva per generare l'embedding.

È stata inoltre valutata l'integrazione a monte, al Livello 1, di un piccolo classificatore o di un'euristica che stabilisca se la domanda è autoesplicativa o richiede il contesto o la cache. L'euristica considererebbe, ad esempio, la presenza di pronomi, le domande brevi o quelle dipendenti dal tempo come «che giorno è oggi». L'ipotesi è di partire dal Livello 2 per il #g("poc", "PoC") e di valutare il Livello 1 per l'MVP.

Per la gestione degli errori, in caso di errore o timeout di Bedrock il flusso deve interrompersi, evitando la classificazione e il salvataggio in cache di risposte non valide.

Resta da chiarire il caso limite della richiesta di «rigenerazione della risposta» da parte dell'utente, che rischia di restituire la stessa risposta dalla cache. Il punto verrà portato a Var Group.

== Analisi dei Requisiti e tecnologie
Il lavoro sull'Analisi dei Requisiti sarà diviso per aree tematiche, il Sistema A (caching semantico) e il Sistema B (Dashboard), e non più solo per tipologia di requisito (obbligatori, desiderabili, opzionali). Ogni area comprende anche attori e casi d'uso. Sono stati formati due sottogruppi: Jacopo Franco e Matteo Arcandi per la Dashboard, Chiara Protopapa e Paolo Prevedello Ramirez per il caching semantico. L'obiettivo per lo stand-up di venerdì è presentare almeno una prima bozza dei requisiti.

La scadenza della issue sulla scelta delle tecnologie è stata posticipata alla fine della prossima settimana, a chiusura dello #g("sprint", "sprint") e della #g("milestone", "milestone"): il termine precedente era troppo stretto per motivare adeguatamente le scelte.

== Piano di Progetto e Norme di Progetto
La bozza del #g("piano-di-progetto", "Piano di Progetto") è stata rivista e aggiornata. La versione attuale resta preliminare (patch); con l'aggiunta delle nuove sezioni, cioè l'analisi dei rischi con codici di categoria e i preventivi, si passerà alla prima versione minor.

Per il preventivo delle ore di ogni sprint si userà la stima delle issue produttive, escludendo, con ore pari a 0, le attività «palestra» come la stesura dei verbali.

Lo sviluppo vero e proprio del PoC inizierà indicativamente a dicembre, dopo il consolidamento di Analisi dei Requisiti, Piano di Progetto e Piano di Qualifica.

Le Norme di Progetto vanno aggiornate con la non produttività delle ore dei verbali, la regola sul merge delle pull request e la descrizione di come si svolge l'analisi dei requisiti.

== Organizzazione di GitHub e automazione dei verbali
Su GitHub vanno sempre compilati i metadati laterali di #g("issues", "issue") e pull request, cioè scadenza, sprint di riferimento, assegnatario e label di documentazione e versione. Dopo ogni modifica va reinviata esplicitamente la richiesta di verifica.

Riccardo Peresson ha riferito l'esito della sperimentazione in locale di una #g("pipeline", "pipeline") basata su LLM per la stesura dei verbali. La pipeline è stata scartata, perché richiede troppo tempo di esecuzione e verifica e appunti così dettagliati da equivalere alla stesura manuale.

Il verbale esterno della riunione del 2026-11-18 va aggiornato con una patch che colleghi correttamente le decisioni e le sub-issue dell'Analisi dei Requisiti, prima dell'invio via email a Var Group.

== Pianificazione della formazione con Var Group
È stata definita la proposta degli argomenti e del monte ore indicativo: 2 ore su LiteLLM, 2 ore sul caching semantico e 1,5 ore sulla Dashboard, più un eventuale follow-up sui requisiti. Le fasce orarie da proporre sono il martedì dalle 15:00 o 15:30 alle 17:00, dopo la riunione interna, oppure il mercoledì, il giovedì o il venerdì dalle 14:00 alle 16:00. L'obiettivo è la presenza di almeno 5-6 membri su 7, con registrazione degli incontri per gli assenti.

== Preparazione dello stand-up di venerdì con Var Group
Sono stati fissati i punti da portare allo stand-up di venerdì:
- presentazione della bozza iniziale della Dashboard;
- discussione dei punti aperti sulla bozza degli ADR;
- presentazione del diagramma di flusso multiturno e dei dubbi tecnici: scelta tra mini-LLM, con eventuale aumento dell'overhead massimo, e introduzione dello «stato»; uso di un classificatore o di un'euristica per le domande autoesplicative o dipendenti dal tempo; gestione della cache in caso di rigenerazione della risposta;
- definizione del calendario e delle ore di formazione su LiteLLM, caching e Dashboard, e conferma della possibilità di registrare le call.

Il Responsabile invierà su Teams a Var Group il diagramma di flusso aggiornato e un mini ordine del giorno.

= Decisioni e attività
Si è infine proceduto alla ripartizione delle attività individuate nel corso della riunione, riportata nella tabella seguente.
