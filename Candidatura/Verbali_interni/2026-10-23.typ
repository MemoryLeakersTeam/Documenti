#import "../../Templates/Verbali.typ": verbale, gloss

#show: verbale.with(
  titolo: "Verbale interno del 23/10/2026",
  tipo-documento: "Verbale Interno",
  data: datetime(year: 2026, month: 10, day: 23),
  ora: "13:20 – 14:10",
  luogo: "Google Meet",
  versione: "1.0.0",
  stato: "Approvato",
  autore: "Matteo Marcon",
  verificatore: "Chiara Protopapa",
  file-nome: "2026-10-23.pdf",
  gruppo: "Memory Leakers",
  ordine-del-giorno: (
    [Definizione argomenti da trattare nell'attività "Diario di Bordo" del 26/10/2026],
    [Definizione del template per le presentazioni nelle attività "Diario di Bordo"],
    [Aggiornamento glossario],
    [Discussione sui capitolati in seguito agli incontri con Ergon Informatica Srl e VIMAR SpA],
    [Varie ed eventuali],
  ),
  partecipanti: (
    "Matteo Arcandi", "Jacopo De Donà", "Jacopo Franco",
    "Matteo Marcon", "Riccardo Peresson", "Paolo Prevedello Ramirez", "Chiara Protopapa",
  ),
  distribuzione: ("Memory Leakers", "Prof. Riccardo Cardin", "Prof. Tullio Vardanega"),
  // Ogni riga: (Ver., Data, Descrizione, Autore, Verificatore)
  registro-modifiche: (
    ([1.0.0], [28/10/2026], [Firma ed approvazione del verbale], [Matteo Marcon], [Paolo Prevedello Ramirez]),
    ([0.1.0], [27/10/2026], [Verifica del verbale], [Matteo Marcon], [Chiara Protopapa]),
    ([0.0.1], [26/10/2026], [Bozza del quarto incontro], [Matteo Marcon], []),
  ),
  // Ogni riga: (ID, Decisione presa)
  decisioni: (
    ([D1], [Definiti gli argomenti da trattare nel primo Diario di Bordo]),
    ([D2], [Adottato *Google Presentazioni* per le presentazioni del gruppo]),
    ([D3], [Definito un nuovo template necessario per le presentazioni]),
    ([D4], [Deciso di aggiornare il glossario con l'inserimento di nuovi termini]),
    ([D5], [Deciso di modificare il sito in modo da permettere collegamenti puntuali ai termini del glossario]),
    ([D6], [Deciso di iniziare a predisporre la stesura dei documenti di candidatura nella prossima riunione interna, comunque in attesa delle riunioni esterne programmate]),
    ([D7], [Anticipazione alle ore 13:00 della prossima riunione interna del 26/10/2026]),

  ),
  // Ogni riga: (ID, Nome attività, Descrizione, Responsabile, Scadenza)
  attivita-todo: (
    ([A1], [Google Presentazioni], [Stesura template presentazioni], [Paolo Prevedello Ramirez], [25/10/2026]),
    ([A2], [Google Presentazioni], [Stesura presentazione Diario di Bordo del 26/10/2026], [Paolo Prevedello Ramirez], [25/10/2026]),
    ([A3], [Glossario], [Aggiornamento glossario], [Jacopo Franco], [27/10/2026]),
    ([A4], [Sito], [Aggiornamento sito per collegamenti al glossario], [Matteo Arcandi], [27/10/2026]),
    ([A5], [Verbale], [Redazione del verbale interno], [Matteo Marcon], [27/10/2026]),
    ([A6], [Verbale], [Redazione del verbale esterno con Ergon Informatica Srl], [Jacopo Franco], [27/10/2026]),
    ([A7], [Verbale], [Redazione del verbale esterno con VIMAR SpA], [Jacopo De Donà], [27/10/2026]),
  ),
  ora-fine-riunione: "14:10",
  data-prossima-riunione: "26/10/2026 alle ore 13:00",
  firma-responsabile: "Paolo Prevedello Ramirez"
)

= Introduzione
Il presente documento attesta che, in data *23 ottobre 2026* dalle ore 13:20 alle ore 14:10,
si è tenuta, in modalità virtuale, la quarta riunione del gruppo *Memory Leakers*.

L'incontro aveva lo scopo di preparare l'attività "Diario di Bordo" prevista per il giorno 26/10/2026, discutere degli aggiornamenti necessari da apportare al glossario e confrontarsi sui capitolati in seguito agli incontri avvenuti con Ergon Informatica Srl e VIMAR SpA.

= Resoconto

== Attività "Diario di Bordo"
Al fine di organizzare la partecipazione all'attività "Diario di Bordo" del 26/10/2026, il gruppo ha discusso sui temi da portare all'attenzione dell'aula, tra i quali lo stato di avanzamento, gli obiettivi futuri a breve termine, le difficoltà incontrate nel periodo in esame, i dubbi e le incertezze su come procedere nello svolgimento di specifiche attività del progetto didattico.

== Template presentazioni
Vista la necessità di adottare un template unico per tutte le attività del tipo "Diario di Bordo", il gruppo ha deciso di utilizzare #gloss[*Google Presentazioni*] come strumento per la preparazione di tali attività.

== Aggiornamento glossario
Il gruppo ha discusso della necessità di integrare ulteriori termini nel glossario e al contempo modificare la struttura del sito in modo da permettere collegamenti diretti dai documenti alle definizioni presenti nella pagina web dedicata.

== Discussione sui capitolati
A seguito degli incontri avvenuti giovedì 22 ottobre 2026 in merito ai capitolati *C7* - *Smart Dashboard* e *C1* - *AURA*, rispettivamente con l'azienda *Ergon Informatica Srl* alle ore 15:30 e con l'azienda *VIMAR SpA* alle ore 16:00, il gruppo ha approfondito la propria valutazione sui capitolati, tenendo conto delle risposte finora pervenute ai quesiti posti alle aziende ritenute dal gruppo di maggior interesse e in vista della predisposizione della documentazione necessaria alla candidatura.

== Varie ed eventuali
Il gruppo ha deciso di anticipare alle ore 13:00 la riunione già prevista lunedì 26/10/2026, in vista delle riunioni esterne programmate lo stesso giorno alle ore 15:00 con *VarGroup SpA* e alle ore 17:00 con *Miriade Srl*.

= Decisioni e attività
Si è infine proceduto alla ripartizione delle attività individuate nel corso della riunione, riportata nella tabella seguente.