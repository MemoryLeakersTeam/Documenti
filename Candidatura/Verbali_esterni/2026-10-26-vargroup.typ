#import "../../Templates/Verbali.typ": verbale, gloss

#let colore-primario = rgb("#305b57")
#let colore-sfondo = rgb("#eaf7f2")
#let colore-bordo = rgb("#49736a")

#show: verbale.with(
  titolo: "Verbale riunione esterna con Var Group del 26/10/2026",
  tipo-documento: "Verbale Esterno",
  data: datetime(year: 2026, month: 10, day: 26),
  ora: "15:00",
  luogo: "Microsoft Team",
  versione: "0.0.1",
  stato: "Bozza",
  autore: "Jacopo Franco",
  verificatore: "",
  file-nome: "2026-10-26-vargroup.pdf",
  gruppo: "Memory Leakers",
  ordine-del-giorno: (
    [RIsposte di Vargroup ai dubbi dei gruppi presenti all'incontro],
    [Prossimi passi],
  ),
  partecipanti: ( "Stefano Dindo (Var Group)", "Laura Ferretti (Var Group)", "Alessio Borgheresi (Var Group)", "Michele Massaro (Var Group)",
    "Jacopo Franco", "Chiara Protopapa", "Jacopo De Donà", "Matteo Marcon"
  ),
  distribuzione: ("Memory Leakers", "Var Group", "Prof. Riccardo Cardin", "Prof. Tullio Vardanega"),
  registro-modifiche: (
    ([0.0.1], [26/10/2026], [Bozza del verbale], [Jacopo Franco], []),
  ),
  ora-fine-riunione: "15:40",
  mostra-conclusioni-automatiche: false,
  firma-responsabile: "",
  firma-esterna: "",
)

= Introduzione


= Preparazione all'incontro


= Quesiti


= Resoconto
== 


= Decisioni e attività

== Decisioni prese


#v(10pt)

== Attività da svolgere


= Conclusioni