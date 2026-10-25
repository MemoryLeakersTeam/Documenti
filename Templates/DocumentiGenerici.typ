#let gloss(term) = [#term#sub[G]]

#let documento(
  titolo: "TITOLO DEL DOCUMENTO",
  sottotitolo: "",
  gruppo: "Memory Leakers",
  tipo-documento: "Documento Interno",
  versione: "1.0.0",
  autore: "",
  verificatore: "",
  stato: "In Approvazione",
  data: datetime.today(),
  file-nome: "",
  registro-modifiche: (),
  mostra-controllo-documentale: true,
  mostra-registro-modifiche: true,
  firma-responsabile: "",
  body
) = {
  // Variabili Colore (Coerenti con i Verbali)
  let colore-primario = rgb("#305b57")
  let colore-secondario = rgb("#41837b")
  let colore-sfondo = rgb("#eaf7f2")
  let colore-bordo = rgb("#49736a")
  let data-str = data.display("[day]/[month]/[year]")

  // Impostazioni Pagina
  set page(
    paper: "a4",
    margin: (x: 2cm, y: 2.5cm),
    header: context {
      if counter(page).get().first() > 1 [
        #block(width: 100%)[
          #grid(
            columns: (1fr, 1fr),
            align: horizon,
            image("Immagini/MemoryLeakersLogo.jpg", height: 45pt),
            align(right, image("Immagini/Logo_unipd.png", height: 28pt))
          )
          #place(center + horizon)[
            #text(8.5pt, fill: luma(120))[*#tipo-documento* | #gruppo]
          ]
        ]
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
  show table.cell: set par(justify: false)

  show heading: it => [
    #set text(fill: colore-primario)
    #it
  ]

  //prima pagina
  align(center + horizon)[
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
      image("Immagini/MemoryLeakersLogo.jpg", width: 100%),
      image("Immagini/Logo_unipd.png", width: 50%)
    )

    #v(2cm)

    #text(13pt, tracking: 1pt, fill: rgb("#555555"))[CORSO DI INGEGNERIA DEL SOFTWARE] \
    #v(4pt)
    #text(11pt, style: "italic", fill: rgb("#777777"))[Anno Accademico 2026/2027]
  ]

  pagebreak()

 //controllo documentale

  if mostra-controllo-documentale [
    == Controllo Documentale

    #table(
      columns: (1fr, 2.5fr),
      inset: 7pt,
      fill: (x, y) => if x == 0 { colore-sfondo } else { none },
      stroke: 0.5pt + colore-bordo,
      [*Titolo Doc.:*], titolo,
      [*Versione:*], versione,
      [*Autore:*], autore,
      [*Stato:*], stato,
      [*Verificato da:*], verificatore,
      [*In data:*], data-str,
      [*Tipo documento:*], tipo-documento,
      [*File:*], file-nome
    )

    #v(8pt)
  ]

  if mostra-registro-modifiche and registro-modifiche.len() > 0 [
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

  // Indice dei Contenuti
  context outline(
    title: [Indice dei Contenuti],
    indent: 1.5em,
    target: selector(heading).after(here()),
  )

  v(15pt)

  //corpo documento
  body

 //firma
 place(bottom + right, dy: -0.5cm)[
    #block(width: 45%)[
      #align(center)[
        #if firma-responsabile != "" and firma-responsabile != "Firma del Responsabile di Progetto" [
          #text(
            font: ("Dancing Script", "Z003", "Liberation Serif"),
            size: 16pt,
            fill: rgb("#1a2b4c")
          )[#firma-responsabile]
          #v(-5pt)
        ]
        #line(length: 100%, stroke: 0.5pt + rgb("#a0a0a0"))
        #v(2pt)
        #text(9.5pt, weight: "medium", fill: rgb("#404040"))[Firma del Responsabile di Progetto]
      ]
    ]
  ]
}