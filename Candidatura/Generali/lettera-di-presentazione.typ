// Colori
#let colore-primario = rgb("#305b57")
#let colore-secondario = rgb("#41837b")
#let colore-sfondo = rgb("#eaf7f2")
#let colore-bordo = rgb("#49736a")

// Dati da modificare
#let titolo = "Lettera di Presentazione"
#let sottotitolo = ""
#let gruppo = "Memory Leakers"
#let tipo-documento = "Lettera"
#let data-str = "30/10/2026"

// Componenti del gruppo: (Nome e Cognome, Matricola)
#let membri = (
  ("Matteo Arcandi", "2084625"),
  ("Jacopo De Donà", "2104894"),
  ("Jacopo Franco", "2145358"),
  ("Matteo Marcon", "2101060"),
  ("Riccardo Peresson", "2138002"),
  ("Paolo Prevedello Ramirez", "2111944"),
  ("Chiara Protopapa", "2137997"),
)

// Dati della lettera
#let mittente = (
  nome: "Memory Leakers",
  email: "memoryleakersteam@gmail.com",
)
#let destinatario = (
  nome: "Università degli Studi di Padova",
  riga1: "Dipartimento di Matematica \"Tullio Levi-Civita\"",
  riga2: "Corso di Laurea in Informatica",
  riga3: "Via Trieste 63, 35121 Padova (PD)",
)
#let oggetto = "Candidatura capitolato C6"
#let responsabile = "Memory Leakers"

// Pagina
#set page(
  paper: "a4",
  margin: (x: 2cm, y: 2.5cm),
  footer: align(center)[
    #context text(9pt, fill: luma(120))[Pagina #counter(page).display()]
  ]
)

#set text(font: "Liberation Sans", size: 10.5pt, lang: "it")
#set par(justify: true)
#show table.cell: set par(justify: false)

// Copertina
#align(center + horizon)[
  #text(24pt, weight: "bold", fill: colore-primario)[#titolo]

  #if sottotitolo != "" [
    #v(0.4cm)
    #text(14pt, weight: "medium", fill: colore-secondario)[#sottotitolo]
  ]

  #v(0.6cm)
  #text(16pt, weight: "medium", fill: colore-secondario)[Gruppo: *#gruppo*]

  #v(2cm)

  #grid(
    columns: (auto, auto),
    column-gutter: 2cm,
    align: horizon + center,
    image("../../Templates/Immagini/MemoryLeakersLogo.jpg", width: 100%),
    image("../../Templates/Immagini/Logo_unipd.jpeg", width: 50%)
  )

  #v(2cm)

  #text(13pt, tracking: 1pt, fill: rgb("#555555"))[CORSO DI INGEGNERIA DEL SOFTWARE] \
  #v(4pt)
  #text(11pt, style: "italic", fill: rgb("#777777"))[Anno Accademico 2026/2027]
  #v(1cm)
  #text(16pt, weight: "medium", fill: colore-secondario)[*Componenti:*]
  #block(width: 50%)[
  #table(
      columns: (2fr, 1fr),
      inset: 7pt,
      align: (col, row) => if row == 0 { center + horizon } else { left + horizon },
      fill: (x, y) => if y == 0 { colore-primario } else if calc.even(y) { colore-sfondo } else { none },
      stroke: 0.5pt + colore-bordo,
      [*#text(fill: white)[Nome e cognome]*],
      [*#text(fill: white)[Matricola]*],
      ..membri.flatten()
    )
  ]
]

#pagebreak()

// ───────────── Lettera ─────────────

// Mittente (sinistra) e destinatario (destra)
#grid(
  columns: (1fr, 1fr),
  column-gutter: 1cm,
  [
    #image("../../Templates/Immagini/MemoryLeakersLogo.jpg", height: 75pt)
    #text(fill: rgb("#555555"))[email: ]#link("mailto:" + mittente.email)[#mittente.email]
  ],
  align(right)[
    #v(1cm)
    #text(weight: "bold")[#destinatario.nome] \
    #destinatario.riga1 \
    #destinatario.riga2 \
    #destinatario.riga3
  ]
)

#v(1cm)

// Luogo e data
#align(right)[Padova, #data-str]

#v(0.8cm)

// Oggetto
#block(
  width: 100%,
  inset: (y: 6pt, x: 8pt),
  fill: colore-sfondo,
  stroke: (left: 2pt + colore-primario),
)[
  *Oggetto:* #oggetto
]

#v(0.8cm)
// Saluto iniziale
Egregio Prof. Tullio Vardanega, \
Egregio Prof. Riccardo Cardin,

#v(0.3cm)

// Corpo della lettera
Con la presente, il gruppo Memory Leakers (Gruppo 3) intende comunicarVi ufficialmente la propria candidatura al capitolato *C6 – Sistema IA di Caching Semantico e Dashboard FinOps*, proposto dall'azienda *Var Group S.p.A.* nell'ambito del Progetto Didattico del corso di Ingegneria del Software.

Per lo svolgimento del progetto abbiamo predisposto una #link("https://github.com/MemoryLeakersTeam")[#text(fill: colore-secondario)[#underline[GitHub Organization]]] dedicata, e la documentazione per la candidatura è integralmente consultabile sul nostro #link("https://memoryleakersteam.github.io/#candidatura")[#text(fill: colore-secondario)[#underline[sito ufficiale]]]. Di seguito sono elencati i documenti prodotti finora:

 - *Lettera di presentazione*
 - *Analisi dei capitolati*
 - *Dichiarazione degli impegni*
 - *Verbali interni ed esterni*
 - *Way of working*

Nella Dichiarazione degli impegni abbiamo indicato un costo complessivo stimato di *12.865€* per lo svolgimento del progetto e una data di consegna fissata al *23 marzo 2027*.

Per qualsiasi delucidazione rimaniamo a Vostra completa disposizione.

#v(0.5cm)

// Chiusura e firma
Cordiali saluti,

#v(0.3cm)

#align(right)[
  #block(width: 45%)[
    #align(center)[
      #text(
        font: ("Dancing Script", "Z003", "Liberation Serif"),
        size: 16pt,
        fill: rgb("#1a2b4c")
      )[#responsabile]
      #v(-5pt)
      #line(length: 100%, stroke: 0.5pt + rgb("#a0a0a0"))
      #v(2pt)
      #text(9.5pt, weight: "medium", fill: rgb("#404040"))[Firma del Gruppo]
    ]
  ]
]