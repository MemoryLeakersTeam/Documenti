#import "../../Templates/Verbali.typ": verbale, gloss

#show: verbale.with(
  titolo: "Verbale interno del 13/10/2026",
  tipo-documento: "Verbale Interno",
  data: datetime(year: 2026, month: 10, day: 13),
  ora: "17:10 – 18:00",
  luogo: "Google Meet",
  versione: "1.0.1",
  stato: "Approved",
  autore: "Jacopo De Donà",
  verificatore: "Chiara Protopapa",
  file-nome: "2026-10-13.pdf",
  gruppo: "Memory Leakers",
  ordine-del-giorno: (
    [Scelta del nome del gruppo],
    [Creazione dell'indirizzo email],
    [Scelta dei canali di comunicazione],
    [Organizzazione repository e documentazione],
    [Discussione dei capitolati],
    [Varie ed eventuali],
  ),
  partecipanti: (
    "Matteo Arcandi", "Jacopo De Donà", "Jacopo Franco",
    "Matteo Marcon", "Riccardo Peresson", "Paolo Prevedello Ramirez", "Chiara Protopapa",
  ),
  distribuzione: ("Memory Leakers", "Prof. Riccardo Cardin", "Prof. Tullio Vardanega"),
  // Ogni riga: (Ver., Data, Descrizione, Autore, Verificatore)
  registro-modifiche: (
    ([1.0.1], [23/10/2026], [Firma ed approvazione del verbale], [Jacopo De Donà], [Paolo Prevedello Ramirez]),
    ([1.0.0], [20/10/2026], [Prima versione completa del verbale], [Jacopo De Donà], [Chiara Protopapa]),
    ([0.0.1], [13/10/2026], [Bozza del primo incontro], [Jacopo De Donà], [Chiara Protopapa]),
  ),
  // Ogni riga: (ID, Decisione presa)
  decisioni: (
    ([D1], [Adozione del nome ufficiale *Memory Leakers*]),
    ([D2], [Adozione dei canali di comunicazione *WhatsApp* e *Google Meet*]),
    ([D3], [Adozione di #gloss[*Typst*] come linguaggio per la documentazione]),
    ([D4], [Pubblicazione della documentazione su #gloss[*GitHub Pages*]]),
  ),
  // Ogni riga: (ID, Nome attività, Descrizione, Responsabile, Scadenza)
  attivita-todo: (
    ([A1], [Verbale], [Redazione del verbale], [Jacopo De Donà], [14/10/2026]),
    ([A2], [Template], [Creazione del template #gloss[Typst]], [Chiara Protopapa], [19/10/2026]),
    ([A3], [Email], [Creazione dell'indirizzo email], [Riccardo Peresson], [14/10/2026]),
    ([A4], [Logo], [Creazione del logo], [Jacopo Franco, Paolo Prevedello Ramirez], [15/10/2026]),
    ([A5], [GitHub], [Creazione dell'organizzazione GitHub], [Matteo Marcon], [15/10/2026]),
    ([A6], [Sito], [Creazione del sito #gloss[GitHub Pages]], [Matteo Arcandi], [19/10/2026]),
  ),
  ora-fine-riunione: "18:00",
  data-prossima-riunione: "19/10/2026 alle ore 14:00",
  firma-responsabile: "Paolo Prevedello Ramirez"
)

= Introduzione
Il presente documento attesta che, in data *13 ottobre 2026* dalle ore 17:10 alle ore 18:00,
si è tenuta, in modalità virtuale, la prima riunione del gruppo *Memory Leakers*.

L'incontro aveva lo scopo di definire il #gloss[*way of working*] per i compiti iniziali e
configurare alcune caratteristiche del gruppo, come il nome, nonchè organizzare le prossime attività.

= Resoconto

== Scelta del nome del gruppo
Dopo una breve serie di proposte ed un relativo sondaggio, è stato adottato *_Memory Leakers_* come nome ufficiale.

== Scelta dei canali di comunicazione
Sono stati adottati i seguenti canali:
- *WhatsApp* per le comunicazioni quotidiane;
- #gloss[*Google Meet*] per le riunioni da remoto.

== Discussione dei capitolati
A seguito di un brainstorming iniziale, sono stati decisi i capitolati su cui il gruppo si focalizzerà, analizzando attentamente le specifiche di ciascuno ed eventualmente contattando i proponenti per chiarimenti.
Al momento della riunione, i capitolati ad aver suscitato maggiore interesse sono stati i seguenti:
- *Capitolato C1* - *AURA*, proposto da VIMAR;
- *Capitolato C5* - *RareCare*, proposto da Miriade;
- *Capitolato C6* - *Caching Semantico*, proposto da Var Group;
== Organizzazione documentale
È stato deciso di adottare #gloss[*Typst*] come linguaggio per la documentazione, che verrà pubblicata su
#gloss[*GitHub Pages*].

= Decisioni e attività
Si è infine proceduto alla ripartizione delle attività individuate nel corso della riunione, riportata nella tabella seguente.
