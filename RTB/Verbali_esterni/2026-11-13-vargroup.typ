#import "../../Templates/Verbali.typ": verbale, gloss

#let colore-primario = rgb("#305b57")
#let colore-sfondo = rgb("#eaf7f2")
#let colore-bordo = rgb("#49736a")

#show: verbale.with(
  titolo: "Verbale riunione esterna con Var Group del 2026-11-13",
  tipo-documento: "Verbale Esterno",
  azienda: "Var Group",
  data: datetime(year: 2026, month: 11, day: 13),
  ora: "16:00 - 16:25",
  luogo: "Microsoft Teams",
  file-nome: "2026-11-13-vargroup.pdf",
  gruppo: "Memory Leakers",
  ordine-del-giorno: (
    [Risposte di Var Group ai quesiti dei gruppi aggiudicatari del capitolato],
    [Definizione dei prossimi passi e delle modalità organizzative],
  ),
  partecipanti: (
    "Stefano Dindo (Var Group)",
    "Laura Ferretti (Var Group)",
    "Alessio Borgheresi (Var Group)",
    "Michele Massaro (Var Group)",
    "Jacopo Franco",
    "Chiara Protopapa",
    "Jacopo De Donà",
    "Matteo Marcon",
    "Riccardo Peresson"
  ),
  distribuzione: (
    "Memory Leakers",
    "Var Group",
    "Prof. Riccardo Cardin",
    "Prof. Tullio Vardanega"
  ),
  ora-fine-riunione: "16:25",
  mostra-conclusioni-automatiche: true,
  firma-esterna: "",

  decisioni: (
   (
      [DE1],
      [Proposto lo svolgimento della sessione di design thinking mercoledì 18 novembre 2026, in presenza dalle ore 14:00 alle ore 17:00]
    ),
    (
      [DE2],
      [Proposto lo svolgimento degli incontri settimanali di stand-up il venerdì, in remoto dalle ore 16:30 alle ore 17:00]
    ),
    (
      [DE3],
      [Individuato Microsoft Teams come strumento per le comunicazioni rapide con Var Group]
    )
  ),
  attivita-todo: (
    (
      [AE1],
      [Email a Var Group],
      [Inviare email a VarGroup S.p.A. per confermare data e orario della sessione di design thinking e fascia oraria degli incontri di stand-up],
      [Chiara Protopapa],
      [2026-11-13],
      [DE1, DE2],
      [N/D],
    ),
  )
)

= Introduzione
Il presente documento riporta quanto discusso durante il primo incontro tra il gruppo *Memory Leakers* e il proponente *Var Group S.p.A.*, tenutosi in data *13 novembre 2026*, a seguito dell'aggiudicazione del capitolato *C6 - SCSDF*. 
L'incontro, svolto congiuntamente al gruppo 3 *Bit Crusher*, ha avuto l'obiettivo di fornire riscontro ai quesiti sollevati dai gruppi e di definire le modalità organizzative per l'avvio delle attività progettuali.

= Preparazione all'incontro
Prima dell'incontro, il gruppo *Memory Leakers* ha predisposto un documento condiviso su Google Drive per raccogliere in maniera asincrona le questioni da trattare con il proponente.

= Quesiti
In sintesi, i principali quesiti posti dal gruppo *Memory Leakers* sono stati i seguenti:
+ In cosa consiste la sessione di design thinking? Quando e come si svolgerà?
+ Presso quale sede si terranno gli incontri in presenza? In caso di necessità, sarà possibile partecipare da remoto?
+ È possibile definire un calendario per gli incontri successivi? 
+ È possibile individuare un canale di messaggistica istantanea per facilitare le comunicazioni tra il gruppo e l'azienda?

= Resoconto

== Sessione di design thinking
La sessione di design thinking avrà lo scopo di approfondire i flussi, analizzare congiuntamente i requisiti funzionali e confrontarsi sulle principali scelte progettuali. 
Durante l'incontro verranno inoltre esaminate le possibili soluzioni e verificata la coerenza con quanto previsto dal capitolato.
L'azienda ha proposto la data di *mercoledì 18 novembre 2026*, dalle ore *14:00 alle 17:00*, per lo svolgimento della sessione di design thinking presso la sede di Var Group a Padova, in via Salboro.
Per i partecipanti che non potranno essere presenti, sarà possibile predisporre un collegamento da remoto.

== Organizzazione degli incontri
Per garantire un confronto costante durante lo svolgimento del progetto, è stata proposta l'organizzazione di incontri periodici di *stand-up*, da tenersi *ogni venerdì* su Microsoft Teams.

Come possibili fasce orarie sono state proposte le seguenti alternative: dalle 16:30 alle 17:00 oppure dalle 17:00 alle 17:30.
Il gruppo *Memory Leakers*, in accordo con il gruppo Bit Crusher, ha manifestato la propria preferenza per la prima fascia oraria (*16:30 - 17:00*).

Oltre agli incontri settimanali, Var Group ha manifestato la propria disponibilità a organizzare ulteriori incontri, qualora se ne presenti la necessità. Questi potranno essere dedicati a sessioni di Q&A, retrospettive oppure sessioni formative.

== Canale di comunicazione
Per velocizzare le comunicazioni tra il gruppo e l'azienda, è stato individuato *Microsoft Teams* come strumento di riferimento per la messaggistica istantanea.
A tal fine, verrà predisposto dall'azienda un apposito canale dedicato alle comunicazioni operative relative al progetto.

= Decisioni e attività
Di seguito sono riportate le decisioni prese durante l'incontro e le relative attività individuate per darne seguito.
