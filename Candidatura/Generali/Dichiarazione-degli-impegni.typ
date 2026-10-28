#import "/Templates/DocumentiGenerici.typ": documento, gloss

#let colore-primario = rgb("#305b57")
#let colore-secondario = rgb("#41837b")
#let colore-sfondo = rgb("#eaf7f2")
#let colore-bordo = rgb("#49736a")

// Ore e costo orario per ruolo: tabelle e grafici sono generati da qui
#let ruoli = (
  (nome: "Responsabile", ore: 60, tariffa: 30),
  (nome: "Amministratore", ore: 56, tariffa: 20),
  (nome: "Analista", ore: 80, tariffa: 25),
  (nome: "Progettista", ore: 112, tariffa: 25),
  (nome: "Programmatore", ore: 182, tariffa: 15),
  (nome: "Verificatore", ore: 161, tariffa: 15),
)
// Un colore per ruolo, nello stesso ordine di `ruoli` (palette verificata per il daltonismo)
#let colori-ruoli = (rgb("#2a78d6"), rgb("#eb6834"), rgb("#1baf7a"), rgb("#eda100"), rgb("#e87ba4"), rgb("#008300"))
// Colore del testo sopra ciascun colore di ruolo
#let testo-ruoli = (white, white, black, black, black, white)

#let ore-totali = ruoli.map(r => r.ore).sum()
#let costo(r) = r.ore * r.tariffa
#let costo-totale = ruoli.map(costo).sum()

// 12865 -> "12.865 €"
#let euro(n) = {
  let cifre = str(n).clusters()
  let out = ""
  for (i, c) in cifre.enumerate() {
    if i > 0 and calc.rem(cifre.len() - i, 3) == 0 { out += "." }
    out += c
  }
  out + " €"
}

// (60, 651) -> "9,2%", sempre con un decimale
#let percentuale(parte, totale) = {
  let decimi = calc.round(parte / totale * 1000)
  str(int(decimi / 10)) + "," + str(int(calc.rem(decimi, 10))) + "%"
}

// Grafico a barre orizzontali: una barra per ruolo, valore e quota a fine barra
#let grafico-barre(valore, formato) = {
  let massimo = calc.max(..ruoli.map(valore))
  let totale = ruoli.map(valore).sum()
  grid(
    columns: (auto, 1fr),
    column-gutter: 8pt,
    row-gutter: 5pt,
    align: (right + horizon, left + horizon),
    ..ruoli.map(r => (
      text(9.5pt)[#r.nome],
      stack(
        dir: ltr,
        spacing: 5pt,
        rect(width: valore(r) / massimo * 78%, height: 13pt, fill: colore-secondario, radius: (right: 2pt)),
        align(horizon, text(9pt)[*#formato(valore(r))* #text(fill: luma(110))[(#percentuale(valore(r), totale))]]),
      ),
    )).flatten(),
  )
}

// Barra al 100% con la quota di ciascun ruolo sul totale
#let barra-quote(valore) = {
  let totale = ruoli.map(valore).sum()
  grid(
    columns: ruoli.map(r => valore(r) * 1fr),
    column-gutter: 2pt,
    ..ruoli.enumerate().map(((i, r)) => rect(
      width: 100%,
      height: 22pt,
      fill: colori-ruoli.at(i),
      radius: if i == 0 { (left: 2pt) } else if i == ruoli.len() - 1 { (right: 2pt) } else { 0pt },
      align(center + horizon, text(8.5pt, weight: "bold", fill: testo-ruoli.at(i))[#percentuale(valore(r), totale)]),
    )),
  )
}

#let legenda-ruoli = grid(
  columns: ruoli.len(),
  column-gutter: 12pt,
  ..ruoli.enumerate().map(((i, r)) => stack(
    dir: ltr,
    spacing: 4pt,
    box(width: 8pt, height: 8pt, fill: colori-ruoli.at(i), radius: 1.5pt),
    text(8.5pt)[#r.nome],
  )),
)

#let rischio(descrizione, probabilita, impatto, mitigazione) = block(breakable: false, table(
  columns: (1fr, 3.5fr),
  inset: 7pt,
  fill: (x, y) => if x == 0 { colore-sfondo } else { none },
  stroke: 0.5pt + colore-bordo,
  [*Descrizione*], descrizione,
  [*Probabilità*], probabilita,
  [*Impatto*], impatto,
  [*Mitigazione*], mitigazione,
))

#show: documento.with(
  titolo: "Dichiarazione degli Impegni",
  sottotitolo: "Pianificazione delle risorse e preventivo dei costi",
  tipo-documento: "Documento Esterno",
  versione: "0.0.3",
  autore: "Jacopo De Donà, Matteo Marcon, Chiara Protopapa",
  verificatore: "",
  stato: "Bozza",
  data: datetime(year: 2026, month: 10, day: 28),
  file-nome: "Dichiarazione_degli_impegni.pdf",
  gruppo: "Memory Leakers",
  registro-modifiche: (
    "0.0.3", "28/10/2026", "Aggiunta di grafici, periodi di rallentamento e analisi dei rischi", "Jacopo De Donà", "",
    "0.0.2", "27/10/2026", "Continuazione stesura", "Matteo Marcon", "",
    "0.0.1", "27/10/2026", "Stesura iniziale del documento e pianificazione ore", "Chiara Protopapa", "",
  )
)

= Introduzione
Il presente documento descrive la Dichiarazione degli Impegni per i componenti del gruppo *Memory Leakers* nello sviluppare il progetto del capitolato *C6 - Sistema AI di caching semantico e dashboard FinOps*. 

Con questo documento ciascun componente del gruppo dichiara di aver compreso il carico di lavoro richiesto e prende l'impegno di svolgere con continuità e responsabilità le attività del progetto, rispettando scadenze, ruoli e way of working definito dal gruppo.

= Analisi dei ruoli
Durante il ciclo di vita del progetto, i membri del gruppo si alterneranno nei seguenti ruoli, distribuendo l'impegno in base alle diverse fasi di avanzamento:

- *Responsabile:* Coordina il team, gestisce la pianificazione temporale e rappresenta il gruppo nei rapporti con i committenti e la proponente. Supervisiona lo stato di avanzamento del progetto e risolve eventuali criticità organizzative. L'impegno è distribuito in modo costante per tutta la durata del progetto, per poter garantire stabilità nell'avanzamento.

- *Amministratore:* Definisce, configura, controlla e mantiene l'ambiente di lavoro condiviso come i repository GitHub e il kanban project. Garantisce l'efficienza degli strumenti di supporto e il rispetto del Way of Working definito dal gruppo. La sua attività è più presente all'avvio del progetto ma si protrae per tutta la lunghezza del progetto per garantire manutenzione costante.

- *Analista:* Conduce l'analisi approfondita dei requisiti, redigendo la documentazione iniziale e individuando i casi d'uso e i requisiti funzionali e qualitativi. Interagisce attivamente con i documenti di capitolato per definire le basi funzionali del sistema. Questo ruolo è centrale e intensivo soprattutto nelle prime settimane di avvio del progetto mentre diminuirà le ore di lavoro con l'avanzamento del progetto.

- *Progettista:* Definisce l'architettura software di alto livello e di dettaglio (*design*), focalizzandosi su componenti critici come la cache semantica e la dashboard FinOps. Traduce i requisiti emersi dall'analisi nel design. La presenza di questo ruolo diventa particolarmente significativa a seguito dell'analisi dei requisiti.

- *Programmatore:* Implementa il codice sorgente del sistema applicativo seguendo rigorosamente le specifiche di design definite dai progettisti. Si occupa dello sviluppo effettivo delle funzionalità e della stesura del codice. Questo ruolo entra nel vivo ed è maggiormente presente nella seconda parte del progetto, durante la fase di codifica vera e propria.

- *Verificatore:* Esegue la verifica formale e i test di qualità sui documenti prodotti e sul codice sorgente sviluppato, assicurando la piena conformità ai requisiti. Valuta se il lavoro svolto dal team rispetta gli standard definiti tramite *Definition of Done*. La sua presenza è costante e si intensifica notevolmente da quando inizia la parte di codifica.

= Impegno individuale
Il gruppo ha analizzato il capitolato *C6 - Sistema AI di caching semantico e dashboard FinOps*, proposto da *VarGroup SpA*, e ha valutato di impegnare *93 ore* produttive per ciascun componente, distribuite per i vari ruoli, per un totale di *651 ore produttive*.

== Distribuzione delle ore
La tabella seguente illustra la distribuzione delle 93 ore per ciascun membro del gruppo nei 6 ruoli definiti. Per indicare i ruoli vengono utilizzati i seguenti acronimi:
- *Resp* = Responsabile
- *Amm* = Amministratore
- *Analist* = Analista
- *Progett* = Progettista
- *Programm* = Programmatore
- *Verif* = Verificatore

#figure(
  table(
    columns: (2.2fr, 1fr, 1fr, 1fr, 1fr, 1.2fr, 1fr, 1fr),
    inset: 6pt,
    align: (col, row) => if col == 0 { left + horizon } else { center + horizon },
    fill: (x, y) => if y == 0 { colore-primario } else if calc.even(y) { colore-sfondo } else { none },
    stroke: 0.5pt + colore-bordo,
    table.header(
      [*#text(fill: white)[Componente]*],
      [*#text(fill: white)[Resp]*],
      [*#text(fill: white)[Amm]*],
      [*#text(fill: white)[Analist]*],
      [*#text(fill: white)[Progett]*],
      [*#text(fill: white)[Programm]*],
      [*#text(fill: white)[Verif]*],
      [*#text(fill: white)[Totale]*],
    ),
    [Matteo Arcandi], [9], [8], [11], [16], [26], [23], [*93*],
    [Jacopo De Donà], [8], [8], [12], [16], [26], [23], [*93*],
    [Jacopo Franco], [8], [8], [12], [16], [26], [23], [*93*],
    [Matteo Marcon], [9], [8], [11], [16], [26], [23], [*93*],
    [Riccardo Peresson], [8], [8], [12], [16], [26], [23], [*93*],
    [Paolo Prevedello Ramirez], [9], [8], [11], [16], [26], [23], [*93*],
    [Chiara Protopapa], [9], [8], [11], [16], [26], [23], [*93*],
    [*Totale*], ..ruoli.map(r => [*#r.ore*]), [*#ore-totali*],
  ),
  caption: [Ore produttive per componente e ruolo],
)

#figure(
  block(width: 100%, inset: (y: 4pt), grafico-barre(r => r.ore, v => [#v h])),
  caption: [Ore produttive complessive per ruolo e relativa quota sul totale di #ore-totali ore],
)

== Analisi svolta
La ripartizione delle ore precedentemente indicata è stata definita a seguito di un'analisi puntuale sulle necessità del progetto:
- *Responsabile*: la scelta di dedicare *60 ore* complessive a questo ruolo, pari a circa 3 ore a settimana distribuite lungo tutta la durata del progetto, è volta a garantire un coordinamento efficace e rappresentanza continua.
- *Amministratore*: per questo ruolo il gruppo ritiene opportuno dedicare un totale di *56 ore*, tenendo conto dell'utilizzo di strumenti come GitHub e GitHub Projects che consentono di automatizzare e velocizzare i flussi di lavoro.
- *Analista*: vista la necessità di una fase di analisi, focalizzata soprattutto nelle prime settimane, per definire accuratamente i requisiti, per il ruolo di analista sono state previste *80 ore*.
- *Progettista*: per la progettazione delle funzionalità chiave richieste dal capitolato, quali la cache semantica e la dashboard FinOps, il gruppo ha riservato *112 ore* a questo ruolo. 
- *Programmatore*: per lo sviluppo delle funzionalità previste si riservano *182 ore*.
- *Verificatore*:  il gruppo prevede un totale di *161 ore* per il ruolo di verificatore, suddivise in circa un terzo per la verifica della documentazione e circa due terzi per la revisione del codice e i test, ritenuti una parte fondamentale per un corretto sviluppo vista la natura del tema.

Nel complesso, questa suddivisione garantisce un adeguato equilibrio tra le attività preliminari di analisi e progettazione, necessarie a definire i requisiti e delineare le soluzioni da implementare, e le attività di sviluppo e verifica, alle quali destiniamo circa il 53% del monte ore complessivo.

= Rotazione dei ruoli
Al fine di consentire a tutti i componenti del gruppo di ricoprire ciascun ruolo per un periodo di tempo adeguato ad acquisire le competenze necessarie, si prevede di effettuare una rotazione dei ruoli ogni due settimane. Il gruppo ha stabilito che inizialmente gli #gloss[sprint] avranno una durata di due settimane, in linea con la frequenza prevista per la rotazione. In futuro, la durata degli sprint potrà eventualmente essere ridotta a una settimana, prevedendo in tal caso una rotazione dei ruoli ogni due sprint.

= Periodi di rallentamento
Il gruppo ha individuato due periodi in cui il lavoro rallenterà, possibilmente fino a uno stato di inattività: il periodo natalizio e la sessione d'esame invernale.

#figure(
  table(
    columns: (1.5fr, 1fr, 1fr),
    inset: 7pt,
    align: (col, row) => if col == 0 { left + horizon } else { center + horizon },
    fill: (x, y) => if y == 0 { colore-primario } else if calc.even(y) { colore-sfondo } else { none },
    stroke: 0.5pt + colore-bordo,
    table.header(
      [*#text(fill: white)[Periodo]*],
      [*#text(fill: white)[Da]*],
      [*#text(fill: white)[A]*],
    ),
    [Periodo natalizio], [24/12/2026], [01/01/2027],
    [Sessione invernale], [18/01/2027], [19/02/2027],
  ),
  caption: [Periodi di rallentamento previsti],
)

= Analisi dei rischi
Viste le risorse limitate, anche in termini di tempo, e l'inesperienza del gruppo in progetti di queste dimensioni, sono stati individuati i principali rischi che potrebbero causare ritardi, insieme alle azioni previste per contenerli.

== Stima errata delle risorse
#rischio(
  [La ripartizione delle ore tra i ruoli e nel tempo potrebbe rivelarsi errata, a causa dell'inesperienza del gruppo nella pianificazione di progetti di queste dimensioni, causando carenza di risorse su alcune attività.],
  [Alta],
  [Alto],
  [Il responsabile confronta a ogni sprint le ore svolte con quelle preventivate ed eventuali scostamenti vengono discussi nella riunione successiva per ridistribuire le attività o pianificare una fase di riallineamento.],
)

== Incomprensione dei requisiti
#rischio(
  [Un'analisi superficiale o una comunicazione insufficiente con il proponente potrebbero portare a requisiti incompleti o fraintesi, con conseguenti modifiche costose nelle fasi avanzate.],
  [Media],
  [Alto],
  [Analisi dei requisiti attenta e puntuale, con domande raccolte in modo asincrono e chiarite tempestivamente con VarGroup durante gli incontri periodici.],
)

== Tecnologie nuove per il gruppo
#rischio(
  [Il capitolato propone diverse tecnologie sconosciute alla maggior parte dei membri del gruppo, in particolare quelle legate alla cache semantica: LiteLLM, i modelli di embedding, i vector store (Qdrant o pgvector) e Redis. Il tempo necessario per apprenderle potrebbe rallentare le attività di progettazione e sviluppo.],
  [Alta],
  [Medio],
  [Studio delle tecnologie fin dalle prime settimane, condivisione delle conoscenze all'interno del gruppo e confronto con il proponente in caso di dubbi.],
)

= Preventivo dei costi
Il preventivo dei costi si basa sulla suddivisione oraria moltiplicata per il costo orario associato a ciascun ruolo.

== Tabella dei costi orari
#figure(
  table(
    columns: (2fr, 1fr, 1.2fr, 1.2fr),
    inset: 7pt,
    align: (col, row) => if col == 0 { left + horizon } else { center + horizon },
    fill: (x, y) => if y == 0 { colore-primario } else if calc.even(y) { colore-sfondo } else { none },
    stroke: 0.5pt + colore-bordo,
    table.header(
      [*#text(fill: white)[Ruolo]*],
      [*#text(fill: white)[Ore]*],
      [*#text(fill: white)[Costo orario]*],
      [*#text(fill: white)[Costo]*],
    ),
    ..ruoli.map(r => ([#r.nome], [#r.ore], [#r.tariffa €/h], [#euro(costo(r))])).flatten(),
    [*Totale*], [*#ore-totali*], [-], [*#euro(costo-totale)*],
  ),
  caption: [Ore, costo orario e costo complessivo per ruolo],
)

#figure(
  block(width: 100%, inset: (y: 4pt), grafico-barre(costo, euro)),
  caption: [Costo complessivo per ruolo e relativa quota sul preventivo di #euro(costo-totale)],
)

== Confronto tra ore e costi
Il grafico seguente confronta, per ciascun ruolo, la quota sulle ore totali con la quota sul costo totale. I ruoli con un costo orario più alto, come il responsabile e il progettista, incidono sul preventivo più di quanto incidano sulle ore; al contrario, programmatore e verificatore coprono più della metà delle ore ma circa il 40% dei costi.

#figure(
  block(width: 100%, inset: (y: 4pt))[
    #align(center, legenda-ruoli)
    #v(8pt)
    #grid(
      columns: (auto, 1fr),
      column-gutter: 8pt,
      row-gutter: 6pt,
      align: (right + horizon, left + horizon),
      text(9.5pt)[Ore], barra-quote(r => r.ore),
      text(9.5pt)[Costi], barra-quote(costo),
    )
  ],
  caption: [Quota di ciascun ruolo sulle ore totali e sul costo totale],
)

== Costo totale
A seguito delle analisi svolte, il preventivo finale dei costi risulta essere *#euro(costo-totale)*.

= Data di consegna prevista
Il gruppo ha stimato una durata complessiva del progetto di circa *20 settimane* a partire dall'aggiudicazione del capitolato. Si impegna pertanto a completare tutte le attività entro e non oltre il *19 marzo 2027*.


