#import "../../Templates/Verbali.typ": gloss, verbale

#show: verbale.with(
  titolo: "Verbale interno del 03/11/2026",
  tipo-documento: "Verbale Interno",
  data: datetime(year: 2026, month: 11, day: 03),
  ora: "14:00 – 16:00",
  luogo: "Google Meet",
  versione: "1.0.0",
  stato: "Approvato",
  autore: "Paolo Prevedello Ramirez",
  verificatore: "Jacopo Franco",
  file-nome: "2026-11-03.pdf",
  gruppo: "Memory Leakers",
  ordine-del-giorno: (
    [Aggiudicazione del capitolato e pianificazione delle attività successive],
    [Revisione delle procedure di versionamento nel Way of Working],
    [Modifiche alla struttura dei Verbali],
    [Aggiornamento della struttura del Sito Web],
    [Rotazione dei ruoli e assegnazione delle attività],
    [Pianificazione delle prossime riunioni e strumenti di comunicazione],
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
    ([1.0.0], [12/11/2026], [Firma responsabile], [Chiara Protopapa], [-]),
    ([0.1.1], [03/11/2026], [Correzioni varie], [Paolo Prevedello Ramirez], [Jacopo Franco]),
    ([0.1.0], [03/11/2026], [Stesura del verbale dell'ottavo incontro], [Paolo Prevedello Ramirez], [Jacopo Franco]),

  ),
  // Ogni riga: (ID, Decisione presa)
  decisioni: (
    (
      [D1],
      [Deciso di spostare i prossimi incontri su Discord per sfruttare la trascrizione delle riunioni],
    ),
    (
      [D2],
      [Decisa la revisione della norma di versionamento nel Way of Working: le modifiche minori incrementano la versione a 0.1.x, gli aggiornamenti sostanziali a 0.2.0, l'approvazione per il rilascio porta a 1.0.0 senza necessità di ulteriore verifica],
    ),
    (
      [D3],
      [Deciso di aggiornare il template dei Verbali aggiungendo le colonne per l'origine della decisione e l'issue GitHub correlata, proseguendo con la numerazione incrementale dei decisioni e azioni],
    ),
    (
      [D4],
      [Deciso di rimuovere la numerazione dalla sezione del sito web e organizzare la voce RTB sopra la Candidatura],
    ),
    (
      [D5],
      [Deciso di scrivere una mail a VarGroup S.p.A. per fissare un incontro conoscitivo per la settimana successiva],
    ),
    (
      [D6],
      [Definita la rotazione dei ruoli per le prossime 2 settimane: Chiara Protopapa (Responsabile), Jacopo De Donà (Amministratore), Jacopo Franco (Verificatore), Matteo Arcandi, Matteo Marcon, Riccardo Peresson, Paolo Prevedello Ramirez (Analisti)],
    ),
    (
      [D7],
      [Deciso di aggiornare la struttura delle board di progetto su GitHub suddividendo le attività in sprint dedicati],
    ),
    (
      [D8],
      [Deciso di procedere con la stesura del prossimo diario di bordo e con la preparazione dei quesiti per l'avvio delle attività esterne],
    ),
    (
      [D9],
      [Deciso di procedere alla redazione del verbale interno dell'incontro del 03/11/2026],
    ),
  ),
  // Ogni riga: (ID, Nome attività, Descrizione, Responsabile, Scadenza, ID Decisione, Issue GitHub)
  attivita-todo: (
    (
      [A1],
      [Contatto VarGroup],
      [Inviare email a VarGroup S.p.A. per fissare un incontro conoscitivo per la settimana successiva],
      [Chiara Protopapa],
      [04/11/2026],
      [D5],
      [N/D],
    ),
    (
      [A2],
      [Modifica Template Verbale],
      [Modifica del template dei verbali per aggiungere origine decisione e issue GitHub],
      [Matteo Marcon],
      [05/11/2026],
      [D3],
      [#link("https://github.com/MemoryLeakersTeam/Documenti/issues/54")[\#54]],
    ),
    (
      [A3],
      [Diario di bordo],
      [Stesura del prossimo diario di bordo],
      [Chiara Protopapa],
      [09/11/2026],
      [D8],
      [#link("https://github.com/MemoryLeakersTeam/Documenti/issues/55")[\#55]],
    ),
    (
      [A4],
      [Organizzazione GitHub Board],
      [Studio e configurazione della suddivisione della board GitHub in sprint],
      [Jacopo De Donà],
      [10/11/2026],
      [D7],
      [N/D],
    ),
    (
      [A5],
      [Redazione Verbale],
      [Redazione del verbale interno dell'incontro del 03/11/2026],
      [Paolo Prevedello Ramirez],
      [10/11/2026],
      [D9],
      [#link("https://github.com/MemoryLeakersTeam/Documenti/issues/53")[\#53]],
    ),
    (
      [A6],
      [Configurazione Discord],
      [Predisposizione del server Discord per le riunioni interne],
      [Jacopo De Donà],
      [10/11/2026],
      [D1],
      [N/D],
    ),
    (
      [A7],
      [Domande riunione esterna],
      [Preparazione delle domande generali sull'avvio delle attività per la prossima riunione esterna],
      [Riccardo Peresson],
      [10/11/2026],
      [D8],
      [N/D],
    ),
    (
      [A8],
      [Modifica Sito Web],
      [Aggiornamento della struttura e rimozione della numerazione sul sito web],
      [Matteo Arcandi],
      [10/11/2026],
      [D4],
      [N/D],
    ),
  ),
  ora-fine-riunione: "16:00",
  data-prossima-riunione: "10/11/2026",
  ruoli-prossima-settimana: (
    ([*Responsabile*], [Chiara Protopapa]),
    ([*Amministratore*], [Jacopo De Donà]),
    ([*Verificatore*], [Jacopo Franco]),
    ([*Analisti*], [Matteo Arcandi, Matteo Marcon, Riccardo Peresson, Paolo Prevedello Ramirez]),
  ),
  firma-responsabile: "Chiara Protopapa"
)

= Introduzione
Il presente documento attesta che, in data *3 novembre 2026* dalle ore 14:00 alle ore 16:00,
si è tenuta, in modalità virtuale, l'ottava riunione del gruppo *Memory Leakers*.

L'incontro si è aperto con la notizia dell'avvenuta aggiudicazione del capitolato ed è stato incentrato sulla riorganizzazione delle attività di progetto, il perfezionamento dei processi normativi interni e la ripartizione dei ruoli per le successive due settimane.

= Resoconto

== Aggiudicazione capitolato e passi successivi
A seguito dell'ufficializzazione dell'aggiudicazione del capitolato d'appalto, il gruppo ha discusso la pianificazione generale delle prime attività e l'avvio dei contatti ufficiali con l'azienda proponente (*VarGroup S.p.A.*).

== Revisione del Way of Working e convenzioni di versionamento
Sono state analizzate e chiarite le procedure di versionamento dei documenti da integrare nel *Way of Working*:
- Tracciamento puntuale di ogni modifica e indicazione del singolo autore nel registro delle modifiche;
- Avvio del versionamento di una bozza a partire dallo stato *0.1.0*;
- Incremento alla versione *0.1.x* per correzioni minori e a *0.2.0* per aggiornamenti sostanziali alla bozza;
- L'approvazione finale di rilascio (*1.0.0*) viene eseguita dal Responsabile di progetto senza necessitare di un'ulteriore verifica formale;
- Chi effettua il commit a seguito di approvazione deve registrare il verificatore senza modificare la versione del documento.

== Struttura dei Verbali e tracciabilità
È stato concordato di aggiornare la struttura della modulistica dei verbali inserendo la corrispondenza diretta con GitHub tramite due nuove colonne nelle tabelle: l'origine della decisione e l'indicatore della relativa *issue* di riferimento. Inoltre, la numerazione degli identificativi di decisioni e azioni proseguirà in ordine progressivo rispecchiando la storia dei verbali precedenti.

== Modifiche al Sito Web
Si è deciso di riorganizzare la struttura del sito web del gruppo eliminando le numerazioni presenti nei menu e riordinando le sezioni in modo da collocare la voce *RTB* al di sopra della sezione *Candidatura*.

== Strumenti di comunicazione e prossime riunioni
È stato approvato il passaggio delle riunioni interne sulla piattaforma *Discord*, che consente la trascrizione automatica degli incontri, quindi facilitando la stesura dei verbali interni.

= Decisioni e attività
Si è infine proceduto alla ripartizione delle attività individuate nel corso della riunione, riportata nella tabella seguente.
