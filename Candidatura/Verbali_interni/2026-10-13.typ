#import "../../Templates/templateVerbali.typ": verbale, gloss

#show: verbale.with(
  tipo: "Verbale interno",
  data: datetime(year: 2026, month: 10, day: 13),
  versione: "0.0.1",
  stato: "Bozza",
  gruppo: "Memory Leakers",
  // logo: image("assets/logo.png", width: 45%),
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
  registro: (
    (ver: "0.0.1", data: "13/10/2026", autore: "Jacopo De Donà",
     verificatore: "Chiara Protopapa", descrizione: [Bozza del primo incontro]),
  ),
  revisore: "...",
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
#figure(
  table(
    columns: (2fr, 1.5fr, auto),
    [Descrizione], [Responsabile], [Scadenza],
    [Redazione del verbale], [Jacopo De Donà], [14/10/2026],
    [Creazione del template #gloss[Typst]], [Chiara Protopapa], [19/10/2026],
    [Creazione dell'indirizzo email], [Riccardo Peresson], [14/10/2026],
    [Creazione del logo], [Jacopo Franco, Paolo Prevedello Ramirez], [15/10/2026],
    [Creazione dell'organizzazione GitHub], [Matteo Marcon], [15/10/2026],
    [Creazione del sito #gloss[GitHub Pages]], [Marco Arcandi], [19/10/2026],
  ),
  caption: [Decisioni intraprese e attività conseguenti],
)

= Conclusione della riunione
Il gruppo ha infine stabilito la data della prossima riunione interna che si terrà il 19/10/2026 alle 14:00.
