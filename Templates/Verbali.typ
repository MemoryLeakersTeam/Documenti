#let verbale(
  titolo: "VERBALE DI RIUNIONE N. 01",
  gruppo: "Memory Leakers",
  tipo-documento: "Verbale Interno",
  versione: "1.0.0",
  autore: "",
  verificatore: "",
  stato: "Approvato",
  data: "",
  ora: "",
  luogo: "Google Meet",
  file-nome: "",
  registro-modifiche: (),
  ordine-del-giorno: (),
  partecipanti: (),
  distribuzione: (
    "Membri del Gruppo",
    "Committente / Docente"
  ),
  // --- PARAMETRI AGGIUNTI PER RISOLVERE L'ERRORE ---
  attivita-todo: (),
  ora-fine-riunione: "11:30",
  ruoli-prossima-settimana: (),
  data-prossima-riunione: "",
  body
) = {
  // Variabili Colore
  let colore-primario = rgb("#305b57")
  let colore-secondario = rgb("#41837b")
  let colore-sfondo = rgb("#eaf7f2")
  let colore-bordo = rgb("#49736a")

  // Impostazioni Pagina
  set page(
    paper: "a4",
    margin: (x: 2cm, y: 2.5cm),
    header: context {
      if counter(page).get().first() > 1 [
        #grid(
          columns: (auto, 1fr, auto),
          align: horizon,
          image("Immagini/MemoryLeakersLogo.jpeg", height: 50pt),
          align(center)[
            #text(8.5pt, fill: luma(120))[*#tipo-documento* | #gruppo]
          ],
          image("Immagini/Logo_unipd.png", height: 28pt)
        )
        #v(-12pt)
        #line(length: 100%, stroke: 0.5pt + colore-primario)
      ]
    },
    footer: align(center)[
      #context text(9pt, fill: luma(120))[Pagina #counter(page).display()]
    ]
  )

  set text(font: "Liberation Sans", size: 10.5pt, lang: "it")
  set par(justify: true)

  show heading: it => [
    #set text(fill: colore-primario)
    #it
  ]

  align(center + horizon)[
    #text(24pt, weight: "bold", fill: colore-primario)[#titolo]
    
    #v(0.6cm)
    #text(16pt, weight: "medium", fill: colore-secondario)[Gruppo: *#gruppo*]

    #v(2cm)

    #grid(
      columns: (auto, auto),
      column-gutter: 2cm,
      align: horizon + center,
      image("Immagini/MemoryLeakersLogo.jpeg", width: 100%),
      image("Immagini/Logo_unipd.png", width: 50%)
    )

    #v(2cm)

    #text(13pt, tracking: 1pt, fill: rgb("#555555"))[CORSO DI INGEGNERIA DEL SOFTWARE] \
    #v(4pt)
    #text(11pt, style: "italic", fill: rgb("#777777"))[Anno Accademico 2026/2027]
  ]

  pagebreak()

  [== Controllo Documentale]

  table(
    columns: (1fr, 2.5fr),
    inset: 7pt,
    fill: (x, y) => if x == 0 { colore-sfondo } else { none },
    stroke: 0.5pt + colore-bordo,
    [*Titolo Doc.:*], titolo,
    [*Versione:*], versione,
    [*Autore:*], autore,
    [*Stato:*], stato,
    [*Verificato da:*], verificatore,
    [*In data:*], data,
    [*Tipo documento:*], tipo-documento,
    [*File:*], file-nome
  )

  v(8pt)

  if registro-modifiche.len() > 0 [
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
      ..registro-modifiche.flatten()
    )
    #v(8pt)
  ]

  if ordine-del-giorno.len() > 0 [
    #block(
      fill: colore-sfondo,
      inset: 10pt,
      radius: 4pt,
      stroke: 0.5pt + colore-bordo,
      width: 100%,
    )[
      #text(weight: "bold", fill: colore-primario)[Ordine del Giorno:]
      #list(..ordine-del-giorno)
    ]
    #v(8pt)
  ]

  // Dettagli riunione
  table(
    columns: (1fr, 3fr),
    inset: 7pt,
    fill: (x, y) => if x == 0 { colore-sfondo } else { none },
    stroke: 0.5pt + colore-bordo,
    [*Data e Ora:*], [#data #if ora != "" [ (#ora) ]],
    [*Luogo / Link:*], luogo,
    [*Partecipanti:*], [
      #for p in partecipanti [
        - #p \
      ]
    ],
    [*Distribuzione:*], [
      #for d in distribuzione [
        - #d \
      ]
    ]
  )

  v(10pt)

  // Indice
  outline(
    title: [Indice dei Contenuti],
    indent: 1.5em,
  )

  v(15pt)

  //Contenuto effettivo verbale, aggiungere punti dell'indice
  body

  v(10pt)

  // --- TABELLA ATTIVITÀ (TO-DO) GENERATA AUTOMATICAMENTE ---
  if attivita-todo.len() > 0 [
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
      ..attivita-todo.flatten()
    )
    #v(10pt)
  ]

  //conclusionui e ruoli prossima riunuione
  [= Conclusioni]
  [La riunione si è conclusa alle ore #ora-fine-riunione con la validazione delle attività assegnate.]

  if ruoli-prossima-settimana.len() > 0 [
    #v(5pt)
    [== Tabella Ruoli per la Prossima Settimana]
    #table(
      columns: (1fr, 2fr),
      inset: 7pt,
      fill: (x, y) => if y == 0 { colore-primario } else if calc.even(y) { colore-sfondo } else { none },
      stroke: 0.5pt + colore-bordo,
      [*#text(fill: white)[Ruolo]*], [*#text(fill: white)[Membro Assegnato]*],
      ..ruoli-prossima-settimana.flatten()
    )
  ]

  if data-prossima-riunione != "" [
    #v(8pt)
    #block(
      fill: colore-sfondo,
      stroke: (left: 4pt + colore-primario),
      inset: (x: 10pt, y: 8pt),
      width: 100%,
      radius: (right: 4pt),
    )[
      *Data Prossima Riunione:* #data-prossima-riunione
    ]
  ]
}