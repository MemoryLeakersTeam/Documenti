#let colore-primario = rgb("#305b57")    
#let colore-secondario = rgb("#41837b")  
#let colore-sfondo = rgb("#eaf7f2")  //per tabelle
#let colore-bordo = rgb("#49736a") 

#set page(
  paper: "a4",
  margin: (x: 2cm, y: 2.5cm),
  
  header: context {
    if counter(page).get().first() > 1 [
      #grid(
        columns: (auto, 1fr, auto),
        align: horizon,
        image("Immagini/MemoryLeakersLogo.jpeg", height: 40pt),
        
        align(center)[
          #text(8.5pt, fill: luma(120))[*Verbale Interno* | Memory Leakers]
        ],
        
        image("Immagini/Logo_unipd.png", height: 22pt)
      )
      #v(-4pt)
      #line(length: 100%, stroke: 0.5pt + colore-primario)
    ]
  },
  footer: align(center)[
    #context text(9pt, fill: luma(120))[Pagina #counter(page).display()]
  ]
)

#set text(font: "Liberation Sans", size: 10.5pt, lang: "it")
#set par(justify: true)

#show heading: it => [
  #set text(fill: colore-primario)
  #it
]

//Pafina iniziale
#align(center + horizon)[
  
  
  #text(24pt, weight: "bold", fill: colore-primario)[VERBALE INTERNO]
  
  #v(0.6cm)

  #text(16pt, weight: "medium", fill: colore-secondario)[*Memory Leakers*]

  #v(2cm)
  
  #grid(
    columns: (auto, auto),
    column-gutter: 2cm,
    align: horizon + center,
    image("Immagini/MemoryLeakersLogo.jpeg", width: 100%),
    image("Immagini/Logo_unipd.png", width: 50%)
  )

  #v(2cm)

  // 3. CORSO E ANNO ACCADEMICO
  #text(13pt, tracking: 1pt, fill: rgb("#555555"))[CORSO DI INGEGNERIA DEL SOFTWARE] \
  #v(4pt)
  #text(11pt, style: "italic", fill: rgb("#777777"))[Anno Accademico 2026/2027]

]

#pagebreak()



== Controllo Documentale

#table(
  columns: (1fr, 2.5fr),
  inset: 7pt,
  fill: (x, y) => if x == 0 { colore-sfondo } else { none },
  stroke: 0.5pt + colore-bordo,
  [*Titolo Doc.:*], [Verbale di Riunione N. 01],
  [*Versione:*], [1.0.0],
  [*Autore:*], [Nome e Cognome],
  [*Stato:*], [In Approvazione / Approvato],
  [*Verificato da:*], [Nome Cognome (Verificatore)],
  [*In data:*], [16/10/2026],
  [*Tipo documento:*], [Interno / Esterno],
  [*File:*], [verbale_01.pdf]
)

#v(8pt)

== Registro delle Modifiche

#table(
  columns: (auto, auto, 2.5fr, 1fr, 1fr),
  inset: 7pt,
  align: (col, row) => if row == 0 { center + horizon } else { left + horizon },
  fill: (x, y) => if y == 0 { colore-primario } else if calc.even(y) { colore-sfondo } else { none },
  stroke: 0.5pt + colore-bordo,
  [*#text(fill: white)[Ver.]*], 
  [*#text(fill: white)[Data]*], 
  [*#text(fill: white)[Descrizione e/o Modifiche]*], 
  [*#text(fill: white)[Autore]*],
  [*#text(fill: white)[Verificatore]*],

  [0.1.0], [], [], [], [],
  [0.2.0], [], [], [], [],
  [1.0.0], [], [], [], []
)

#v(8pt)
//ordine del giorno
#block(
  fill: colore-sfondo,
  inset: 10pt,
  radius: 4pt,
  stroke: 0.5pt + colore-bordo,
  width: 100%,
)[
  #text(weight: "bold", fill: colore-primario)[Ordine del Giorno:]
  #list(
    [],
  )
]

#v(8pt)

//tabella dettagli riunione
#table(
  columns: (1fr, 3fr),
  inset: 7pt,
  fill: (x, y) => if x == 0 { colore-sfondo } else { none },
  stroke: 0.5pt + colore-bordo,
  
  [*Data e Ora:*], [],
  [*Luogo:*], [Google Meet],
  [*Partecipanti:*], [
    x (presente/assente)
  ],
  [*Distribuzione:*], [
    
  ]
)

#v(10pt)

#outline(
  title: [Indice dei Contenuti],
  indent: 1.5em,
)

#v(15pt)

// sezioni

= Introduzione


= Resoconto


== Discussione Punto 1


== Discussione Punto 2


= Decisioni


#v(10pt)

== Attività da Svolgere (To-Do)

#table(
  columns: (1.2fr, 2.5fr, 1fr, 1fr),
  inset: 7pt,
  align: (col, row) => if row == 0 { center + horizon } else { left + horizon },
  fill: (x, y) => if y == 0 { colore-primario } else if calc.even(y) { colore-sfondo } else { none },
  stroke: 0.5pt + colore-bordo,
  
  [*#text(fill: white)[Nome Attività]*], 
  [*#text(fill: white)[Breve Descrizione]*], 
  [*#text(fill: white)[Responsabile]*], 
  [*#text(fill: white)[Scadenza]*],

  
)

#v(10pt)

= Conclusioni
testo

== Tabella Ruoli per la Prossima Settimana
#table(
  columns: (1fr, 2fr),
  inset: 7pt,
  fill: (x, y) => if y == 0 { colore-primario } else if calc.even(y) { colore-sfondo } else { none },
  stroke: 0.5pt + colore-bordo,
  [*#text(fill: white)[Ruolo]*], [*#text(fill: white)[Membro Assegnato]*],
  
)

#v(8pt)

#block(
  fill: colore-sfondo,
  stroke: (left: 4pt + colore-primario),
  inset: (x: 10pt, y: 8pt),
  width: 100%,
  radius: (right: 4pt),
)[
  *Data Prossima Riunione:* 
]