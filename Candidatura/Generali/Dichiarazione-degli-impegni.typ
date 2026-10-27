#import "/Templates/DocumentiGenerici.typ": documento, gloss

#show: documento.with(
  titolo: "Dichiarazione degli Impegni",
  sottotitolo: "Pianificazione delle risorse e preventivo dei costi",
  tipo-documento: "Documento Interno",
  versione: "0.0.2",
  autore: "Jacopo De Donà, Matteo Marcon, Chiara Protopapa",
  verificatore: "",
  stato: "Bozza",
  data: datetime(year: 2026, month: 10, day: 27),
  file-nome: "Dichiarazione_degli_impegni.pdf",
  gruppo: "Memory Leakers",
  registro-modifiche: (
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

- *Verificatore:* Esegue la verifica formale e i test di qualità sui documenti prodotti e sul codice sorgente sviluppato, assicurando la piena conformità ai requisiti. Valuta se il lavoro svolto dal team rispetta gli standard definiti tranite *Definition of Done*. La sua presenza è costante e si intensifica notevolmente da quando inizia la parte di codifica.

= Impegno individuale
Il gruppo ha analizzato il capitolato *C6 - Sistema AI di caching semantico e dashboard FinOps*, proposto da *VarGroup SpA*, e ha valutato di impegnare *93 ore* produttive per ciascun componente, distribuite per i vari ruoli, per un totale di *651 ore produttive*.

== Distribuzione delle ore
La tabella seguente illustra la distribuzione delle 93 ore per ciascun membro del gruppo nei 6 ruoli definiti.

#table(
  columns: (1.5fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
  inset: 6pt,
  align: (col, row) => if row == 0 { center + horizon } else { center + horizon },
  fill: (x, y) => if y == 0 { rgb("#305b57") } else if calc.even(y) { rgb("#eaf7f2") } else { none },
  stroke: 0.5pt + rgb("#49736a"),
  table.header(
    text(fill: white)[Componente], 
    text(fill: white)[Res], 
    text(fill: white)[Amm], 
    text(fill: white)[Anal], 
    text(fill: white)[Prog], 
    text(fill: white)[Progr], 
    text(fill: white)[Ver],
    text(fill: white)[*Totale*]
  ),
  
  [Matteo A], [9], [8], [11], [16], [26], [23], [*93*],
  [Chiara], [9], [8], [11], [16], [26], [23], [*93*],
  [Matteo M], [9], [8], [11], [16], [26], [23], [*93*],
  [Paolo], [9], [8], [11], [16], [26], [23], [*93*],
  [Jacopo D], [8], [8], [12], [16], [26], [23], [*93*],
  [Riccardo], [8], [8], [12], [16], [26], [23], [*93*],
  [Jacopo F], [8], [8], [12], [16], [26], [23], [*93*],
  [*Totale*], [*60*], [*56*], [*80*], [*112*], [*182*], [*161*], [*651*]
)

== Analisi svolta
La ripartizione delle ore precedentemente indicata è stata definita a seguito di un analisi puntuale sulle necessità del progetto:
- *Responsabile*: la scelta di dedicare *60 ore* complessive a questo ruolo, pari a circa 3 ore a settimana distribuite lungo tutta la durata del progetto, è volta a garantire un coordinamento efficace e rappresentanza continua.
- *Amministratore*: per questo ruolo il gruppo ritiene opportuno dedicare un totale di *56 ore*, tenendo conto dell'utilizzo di strumenti come GitHub e GitHub Projects che consentono di automatizzare e velocizzare i flussi di lavoro.
- *Analista*: vista la necessità di una fase di analisi, focalizzata soprattutto nelle prime settimane, per definire accuratamente i requisiti, per il ruolo di analista sono state previste *80 ore*.
- *Progettista*: per la progettazione delle funzionalità chiave richieste dal capitolato, quali la cache semantica e la dashboard FinOps, il gruppo ha riservato *112 ore* a questo ruolo. 
- *Programmatore*: per lo sviluppo delle funzionalità previste si riservano *182 ore*.
- *Verificatore*:  il gruppo prevede un totale di *161 ore* per il ruolo di verificatore, suddivise in circa un terzo per la verifica della documentazione e circa due terzi per la revisione del codice e i test, ritenuti una parte fondamentale per un corretto sviluppo vista la natura del tema.

Nel complesso, questa suddivisione garantisce un adeguato equilibrio tra le attività preliminari di analisi e progettazione, necessarie a definire i requisiti e delineare le soluzioni da implementare, e le attività di sviluppo e verifica, alle quali destiniamo circa il 53% del monte ore complessivo.

= Rotazione dei ruoli
Al fine di consentire a tutti i componenti del gruppo di ricoprire ciascun ruolo per un periodo di tempo adeguato ad acquisire le competenze necessarie, si prevede di effettuare una rotazione dei ruoli ogni due settimane. Il gruppo ha stabilito che inizialmente gli #gloss[sprint] avranno una durata di due settimane, in linea con la frequenza prevista per la rotazione. In futuro, la durata degli sprint potrà eventualmente essere ridotta a una settimana, prevedendo in tal caso una rotazione dei ruoli ogni due sprint.

= Analisi dei rischi


= Preventivo dei costi
Il preventivo dei costi si basa sulla suddivisione oraria moltiplicata per il costo orario associato a ciascun ruolo. 


== Tabella dei costi orari
#table(
  columns: (2fr, 1.5fr, 1.5fr, 1.5fr),
  inset: 6pt,
  align: (col, row) => if row == 0 { center + horizon } else { center + horizon },
  fill: (x, y) => if y == 0 { rgb("#305b57") } else if calc.even(y) { rgb("#eaf7f2") } else { none },
  stroke: 0.5pt + rgb("#49736a"),
  table.header(
    text(fill: white)[Ruolo], 
    text(fill: white)[Costo orario (€/h)],
    text(fill: white)[Ore previste (h)],
    text(fill: white)[Costo totale (€)]
    ),
    
    [Responsabile], [30], [60], [1800],
    [Amministratore], [20], [56], [1120],
    [Analista], [25], [80], [2000],
    [Progettista], [25], [112], [2800],
    [Programmatore], [15], [182], [2730],
    [Verificatore], [15], [161], [2415],
    [*Totale*], [], [*651*], [*12865*],
)

== Costo totale
A seguito delle analisi svolte, il preventivo finale dei costi risulta essere *12865 €*.

= Data di consegna prevista
Il gruppo ha stimato una durata complessiva del progetto di circa *20 settimane* a partire dall'aggiudicazione del capitolato. Si impegna pertanto a completare tutte le attività entro e non oltre il *19 marzo 2027*.

#v(10pt)

