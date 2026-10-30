#import "../../Templates/Verbali.typ": verbale, gloss

#let colore-primario = rgb("#305b57")
#let colore-sfondo = rgb("#eaf7f2")
#let colore-bordo = rgb("#49736a")

#show: verbale.with(
  titolo: "Verbale riunione esterna con Var Group del 26/10/2026",
  tipo-documento: "Verbale Esterno",
  data: datetime(year: 2026, month: 10, day: 26),
  ora: "15:00 - 15:40",
  luogo: "Microsoft Teams",
  versione: "1.0.2",
  stato: "Approvato",
  autore: "Jacopo Franco",
  verificatore: "Chiara Protopapa",
  file-nome: "2026-10-26-vargroup.pdf",
  gruppo: "Memory Leakers",
  ordine-del-giorno: (
    [RIsposte di Var Group ai dubbi dei gruppi presenti all'incontro],
    [Prossimi passi],
  ),
  partecipanti: ( "Stefano Dindo (Var Group)", "Laura Ferretti (Var Group)", "Alessio Borgheresi (Var Group)", "Michele Massaro (Var Group)",
    "Jacopo Franco", "Chiara Protopapa", "Jacopo De Donà", "Matteo Marcon"
  ),
  distribuzione: ("Memory Leakers", "Var Group", "Prof. Riccardo Cardin", "Prof. Tullio Vardanega"),
  registro-modifiche: (
    ([1.0.2], [28/10/2026], [Correzioni ortografiche], [Jacopo Franco], [Chiara Protopapa]),
    ([1.0.1], [28/10/2026], [Correzione data errata], [Jacopo Franco], [Chiara Protopapa]),
    ([1.0.0], [28/10/2026], [Firma ed approvazione del verbale], [Jacopo Franco], [Paolo Prevedello Ramirez]),
    ([0.1.0], [28/10/2026], [Verifica del verbale], [Jacopo Franco], [Chiara Protopapa]),
    ([0.0.1], [26/10/2026], [Bozza del verbale], [Jacopo Franco], []),
  ),
  ora-fine-riunione: "15:40",
  mostra-conclusioni-automatiche: false,
  firma-responsabile: "Paolo Prevedello Ramirez",
  firma-esterna: "",
)

= Introduzione
Il presente documento attesta che in data *26 ottobre 2026* è avvenuto l'incontro con il #gloss[proponente]
*Var Group S.p.A.*, in videoconferenza. L'incontro, rivolto a tutti i gruppi interessati, è stato
organizzato nell'ambito della fase di pre-assegnazione dei capitolati con lo scopo di rispondere ai dubbi raccolti
riguardo al capitolato *C6 - SCSDF*.

= Preparazione all'incontro
Prima dell'incontro, il gruppo *Memory Leakers* ha utilizzato un documento condiviso su Google Drive per raccogliere in maniera #gloss[asincrona] i dubbi tecnici e architetturali dei singoli componenti, organizzandoli in una scaletta di quesiti da sottoporre ai referenti aziendali durante la sessione di chiarimento.

= Quesiti
I temi principali a cui hanno contribuito i quesiti del gruppo *Memory Leakers* sono stati i seguenti:
1. È preferibile un #gloss[fork] diretto di #gloss[LiteLLM] o un #gloss[middleware] esterno?
2. L'#gloss[embedding] per la #gloss[cache semantica] va applicato solo all'ultimo prompt o all'intera cronologia?
3. Come vengono calcolati i costi #gloss[FinOps] per i modelli privati su #gloss[AWS Bedrock]?
4. La cache semantica è condivisa o separata tra i diversi team (#gloss[multi-tenancy])?
5. Verrà fornito un budget #gloss[API] aziendale per lo sviluppo e l'esecuzione dei test automatizzati?
6. Qual è la versione di LiteLLM usata in produzione?
7. È ammissibile il riuso di librerie vettoriali consolidate per la ricerca semantica?
8. Il progetto finale sarà interamente rilasciabile con licenza #gloss[open-source]?

Nel corso dell’incontro l’azienda ha comunque risposto a 12 temi emersi, tra cui le 8 domande poste, di seguito riportati.

= Resoconto

== Architettura e integrazione
=== Modalità di integrazione con LiteLLM
L'azienda ha confermato la necessità di operare tramite un fork diretto del repository di LiteLLM, escludendo lo sviluppo di un middleware esterno.

=== Versione di LiteLLM in produzione
La versione attualmente in produzione presso Var Group è la *1.91.2*, configurata con funzionalità di base. Questa rappresenterà il punto di partenza per l'analisi e lo sviluppo delle estensioni.

=== Riuso di librerie vettoriali
È consentito l'utilizzo di librerie open-source consolidate per la #gloss[ricerca vettoriale] e il calcolo della similarità (es. FAISS, Qdrant, scikit-learn), purché il loro funzionamento sia documentato e verificabile.

== Cache semantica e privacy
=== Perimetro della cache
La cache semantica sarà unica e condivisa per tutti i dipendenti dell'organizzazione per massimizzare il riuso. Qualora si presentassero rallentamenti, si valuterà in futuro la separazione per settori o team.

=== Strategia di embedding
In fase di progettazione e sperimentazione si valuterà se applicare l'embedding all'intera cronologia di conversazione, a una sua porzione o soltanto all'ultimo prompt inviato dall'utente.

=== Modello di scoring e qualità
Per la valutazione della qualità nella ricerca semantica, si lavorerà alla definizione di un modello di #gloss[scoring] basato sul grado di similarità e confidenza per misurare e validare i risultati rispetto a una soglia configurabile.

=== Layer di anonimizzazione
Il modulo di anonimizzazione (#gloss[Anonymizer]) è da considerarsi un'estensione opzionale. Per l'#gloss[MVP] la priorità principale rimane lo sviluppo solido del core (Cache Semantica e FinOps).

== Dashboard FinOps e gestione dati
=== Profilazione multi-tenant e mobilità del personale
A differenza della cache, la dashboard FinOps dev'essere strettamente profilata per team e progetti, gestendo in modo dinamico l'attribuzione dei costi anche quando le persone si spostano da un progetto/settore all'altro.

=== Calcolo dei costi complessivi e pricing
Il sistema FinOps monitorerà il costo complessivo di esercizio, includendo il consumo dei modelli (LLM ed embedding), i costi infrastrutturali e le componenti fisse o variabili. Var Group fornirà storici di consumo e un listino prezzi personalizzato per i modelli privati su AWS Bedrock.

=== Frequenza di aggiornamento delle metriche
Sebbene l'aggiornamento ideale sia in tempo reale, per le metriche della dashboard FinOps un ritardo (#gloss[delay]) di *10–15 minuti* è ritenuto pienamente accettabile.

== Risorse per lo sviluppo e licenza
=== Budget API e ambiente di test
Var Group fornirà un ambiente con budget API associati a cui il sistema dovrà attingere per coprire i consumi di embedding e #gloss[LLM] durante lo sviluppo e l'esecuzione dei test automatizzati nella pipeline di #gloss[CI/CD].

=== Licenza di rilascio
L'intero progetto sviluppato dal gruppo sarà rilasciato ufficialmente con licenza open-source, in piena conformità con i requisiti del regolamento didattico.


= Decisioni e attività

== Decisioni prese
Data la natura dell'incontro, non sono state prese decisioni vincolanti. Le indicazioni dell'azienda sono state raccolte come requisiti e linee guida per la progettazione della soluzione, e sono state riportate nel verbale per chiarezza e tracciabilità.

#v(10pt)

== Attività da svolgere
#table(
  columns: (0.5fr, 1.2fr, 2.5fr, 1fr, 1fr),
  inset: 7pt,
  align: (col, row) => if row == 0 { center + horizon } else { left + horizon },
  fill: (x, y) => if y == 0 { colore-primario } else if calc.even(y) { colore-sfondo } else { none },
  stroke: 0.5pt + colore-bordo,
  [*#text(fill: white)[ID]*], [*#text(fill: white)[Nome Attività]*], [*#text(fill: white)[Breve Descrizione]*], [*#text(fill: white)[Responsabile]*], [*#text(fill: white)[Scadenza]*],
  [A1], [Verifica e invio del verbale], [Verifica del presente verbale e invio a Var Group per l'approvazione], [Chiara Protopapa, Riccardo Peresson], [28/10/2026],
  [A2], [Aggiornamento Glossario], [Inserimento nel Glossario dei nuovi termini emersi (es. FinOps, embedding, multi-tenancy, scoring)], [Jacopo Franco], [29/10/2026],
  [A3], [Valutazione capitolato C6], [Integrazione delle risposte ricevute nella valutazione del capitolato C6 per la candidatura], [Tutto il gruppo], [29/10/2026],
  [A4], [Studio delle tecnologie], [Studio esplorativo della codebase di LiteLLM (v1.91.2), delle librerie vettoriali (FAISS, Qdrant) e dei modelli di scoring], [Tutto il gruppo], [Continuativa],
  [A5], [Avvio con Var Group], [In caso di aggiudicazione: concordare l'accesso all'ambiente di sviluppo con budget API e la tabella di pricing AWS Bedrock], [Da assegnare], [Dopo il 03/11/2026],
)

= Conclusioni
L'incontro è stato utile per chiarire i dubbi sorti tra i componenti del gruppo riguardo all'architettura, alla cache semantica, alla dashboard FinOps e ai requisiti del capitolato *C6 - SCSDF* proposto da Var Group S.p.A.

I componenti del gruppo *Memory Leakers* ringraziano *Var Group S.p.A.* per la disponibilità e la chiarezza dimostrata.