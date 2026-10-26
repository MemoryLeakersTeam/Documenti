#import "../../Templates/Verbali.typ": verbale, gloss

#let colore-primario = rgb("#305b57")
#let colore-sfondo = rgb("#eaf7f2")
#let colore-bordo = rgb("#49736a")

#show: verbale.with(
  titolo: "Verbale riunione esterna con Ergon Informatica del 22/10/2026",
  tipo-documento: "Verbale Esterno",
  data: datetime(year: 2026, month: 10, day: 22),
  ora: "15:30 - 15:50",
  luogo: "Microsoft Teams",
  versione: "0.0.2",
  stato: "Approvato",
  autore: "Jacopo franco",
  verificatore: "Chiara Protopapa",
  file-nome: "2026-10-22-ergon.pdf",
  gruppo: "Memory Leakers",
  ordine-del-giorno: (
    [Presentazione breve del gruppo all'azienda Ergon Informatica C7 - SmartDashBoard],
    [Domande del gruppo e chiarimenti richiesti],
    [Prossimi passi]
  ),
  partecipanti: ( "Gianluca Carlesso (Ergon)",
    "Paolo Prevedello Ramirez", "Chiara Protopapa", "Jacopo Franco"
  ),
  distribuzione: ("Memory Leakers", "Ergon Informatica", "Prof. Riccardo Cardin", "Prof. Tullio Vardanega"),
  registro-modifiche: (
    ([0.0.2],[26/10/2026], [Aggiunta sezione decisioni ed attività], [Jacopo Franco], []),
    ([0.0.1], [24/10/2026], [Bozza del verbale], [Jacopo Franco], [Chiara Protopapa]),
  ),
  ora-fine-riunione: "15:50",
  mostra-conclusioni-automatiche: false,
  firma-responsabile: "",
  firma-esterna: "",
)

= Introduzione 
Il presente documento attesta che in data *22 ottobre 2026* dalle ore 15:30 alle ore 15:50 è avvenuto l'incontro con il #gloss[*proponente*] 
*Ergon Informatica*, in videoconferenza. La riunione è stata organizzata con lo scopo di discutere alcune domande e dubbi sorti tra i 
componenti del gruppo riguardo al capitolato *C7 - SmartDashBoard* proposto da Ergon Informatica. L'incontro esplorativo si è svolto in videoconferenza tramite Microsoft Teams, con la
partecipazione di Paolo Prevedello Ramirez, Chiara Protopapa e Jacopo Franco in rappresentanza del gruppo.

= Preparazione all'incontro 
Il gruppo *Memory Leakers* ha utilizzato un file condiviso su Google Drive per inserire in maniera #gloss[asincrona] i dubbi dei singoli 
componenti riguardo al capitolato. E' stata richiesta preventivamente la possibilità di usare la funzionalità di registrazione e 
la trascrizione della riunione, in modo da facilitare la stesura  del verbale, richiesta a cui l'azienda ha risposto positivamente.

= Quesiti
I quesiti posti all'azienda sono stati i seguenti:
1. Qual è l'approccio ideale per evitare l'esecuzione di SQL libero? È preferibile la generazione di un
 formato intermedio (es. JSON) validato dal backend oppure la generazione diretta gestita tramite #gloss[guardrail] e #gloss[whitelist]?
2. Quali controlli deve effettuare il sistema per garantire la coerenza degli insight generati dall'AI rispetto ai dati?
3. Come devono essere gestite le richieste ambigue?
4. L'azienda fornirà un dataset rappresentativo con domande e risultati attesi per testare l'accuratezza dell'LLM,
 oppure la definizione dei casi di test sarà a carico del gruppo?
5. In quale formato verranno resi disponibili i dati del gestionale ERP, dataset statico oppure connessione dinamica
 per testare l'aggiornamento periodico?
6. L'azienda fornirà credenziali o budget per l'utilizzo di API di modelli AI commerciali (es. GPT, Claude)?
7. I filtri devono agire in modo globale su tutti i widget della dashboard oppure devono supportare anche un ambito selettivo?
8. L'analisi automatica per la generazione degli insight deve limitarsi ai soli dati correntemente mostrati nella dashboard
 o deve potersi estendere all'intero #gloss[data warehouse]?

= Resoconto 
== Generazione delle query e whitelist 
Alla domanda sull'approccio ideale per evitare l'esecuzione di #gloss[SQL libero], l'azienda 
ha risposto che l'#gloss[LLM] può eventualmente generare query dirette. Il rischio principale è che, 
fornendo all'LLM l'accesso allo schema del database, il modello possa interrogare anche tabelle non 
pertinenti al proprio scopo. La *whitelist* serve proprio a indicare esplicitamente quali tabelle 
l'LLM è autorizzato a utilizzare per la generazione delle query. 

== Controlli di coerenza degli insight generati 
L'azienda ha indicato due livelli di controllo: regole rigide a livello di prompt (ad esempio 
"non inventare nulla", "non dedurre nulla") per evitare che il modello generi numeri inventati; 
test automatici empirici, sottoponendo al modello domande specifiche e domande a trabocchetto; 
è stata fatta notare la necessità di rieseguire questi test ogni volta che si cambia o si aggiorna 
il modello #gloss[LLM] utilizzato, poiché le risposte possono variare. 

== Gestione delle richieste ambigue 
In caso di richiesta ambigua, l'azienda ha indicato che l'#gloss[LLM], tramite un #gloss[System prompt] 
opportunamente strutturato, non deve mostrare sicurezza su ciò che 
ha compreso, ma deve porre domande di chiarimento all'utente per ottenere le specifiche mancanti.

== Dataset di test e benchmark
Per testare l'affidabilità delle risposte generate, l'azienda ha confermato che fornirà
direttamente un dataset di test, accompagnato da un insieme di domande e dai relativi risultati
attesi.

== Dati del caso di studio ERP
Per l'#gloss[ingestione] dei dati del gestionale #gloss[ERP], l'azienda ha riferito di aver
previsto una soluzione statica. Ha indicato che in futuro si potrebbe eventualmente valutare
un'evoluzione verso una soluzione automatica, che permetterebbe di osservare anche gli
aggiornamenti dei dati nel tempo.

== Chiavi API e modelli offline
L'azienda fornirà le chiavi di accesso alle #gloss[API] dei modelli AI commerciali, con un
#gloss[credito precaricato] che verrà ricaricato al bisogno. È stato sconsigliato l'uso di
modelli offline in locale (ad esempio #gloss[Ollama]), per la mancanza di tempo rispetto
alla complessità del progetto e per i requisiti hardware necessari a ottenere risultati
attendibili.

== Filtri della dashboard
In fase iniziale, i filtri agiranno su tutti i #gloss[widget] presenti a schermo. È stato
indicato come requisito desiderabile la possibilità di raggruppare alcuni widget all'interno di
"contenitori", in modo che i filtri al loro interno agiscano solo sui widget del contenitore
stesso e non su quelli esterni.

== Scope degli insight e schema del database
Nella funzionalità di base, l'analisi degli insight riguarda solo i dati attualmente caricati
nella dashboard. Come requisito desiderabile, è stata indicata la possibilità di esplorare anche
altri dati correlati, fornendo all'LLM uno schema del database in formato #gloss[JSON] con
l'elenco delle tabelle e il relativo significato.

= Consiglio finale dell'azienda
L'azienda ha raccomandato di prestare molta attenzione alla fase di analisi dei requisiti.
Essendo il progetto molto ampio e ricco di funzionalità interessanti, è necessario
circoscriverlo con precisione fin dall'inizio, per evitare di impiegare un tempo molto
superiore a quello disponibile per il corso o di non riuscire a completare il lavoro.

= Decisioni e attività

== Decisioni prese
Data la natura dell'incontro, non sono state prese decisioni vincolanti. Le indicazioni fornite da Ergon Informatica sono state raccolte come requisiti, vincoli e linee guida per la perimetrazione e la progettazione della soluzione *SmartDashboard*, e sono state riportate nel presente verbale per chiarezza e tracciabilità.

#v(10pt)

== Attività da svolgere
#table(
  columns: (0.5fr, 1.2fr, 2.5fr, 1fr, 1fr),
  inset: 7pt,
  align: (col, row) => if row == 0 { center + horizon } else { left + horizon },
  fill: (x, y) => if y == 0 { colore-primario } else if calc.even(y) { colore-sfondo } else { none },
  stroke: 0.5pt + colore-bordo,
  [*#text(fill: white)[ID]*], [*#text(fill: white)[Nome Attività]*], [*#text(fill: white)[Breve Descrizione]*], [*#text(fill: white)[Responsabile]*], [*#text(fill: white)[Scadenza]*],
  [A1], [Verifica e invio del verbale], [Verifica del presente verbale e invio ai referenti di Ergon Informatica per l'approvazione], [Chiara Protopapa] , [Riccardo Peresson], [28/10/2026],
  [A2], [Aggiornamento Glossario], [Inserimento dei nuovi termini tecnici emersi (es. Whitelist, System Prompt, Guardrail, DuckDB, Widget Contenitore, JSON Schema)], [Jacopo Franco], [29/10/2026],
  [A3], [Valutazione capitolato C7], [Integrazione delle risposte ricevute nella valutazione del capitolato SmartDashboard per la candidatura e perimetrazione dei requisiti MVP], [Tutto il gruppo], [30/10/2026],
  [A4], [Studio delle tecnologie], [Studio esplorativo del database colonnare DuckDB, della gestione di query dirette con whitelist e delle tecniche di prompt engineering per evitare allucinazioni], [Tutto il gruppo], [Continuativa],
  [A5], [Avvio con Ergon Informatica], [In caso di aggiudicazione: concordare la consegna del dataset di test con domande e risultati attesi, definire la predisposizione dell'ambiente di lavoro e fissare la riunione di avvio], [Da assegnare], [Dopo il 03/11/2026],
)

= Conclusioni
L'incontro è stato utile per chiarire i dubbi sorti tra i componenti del gruppo riguardo
all'architettura e ai requisiti del capitolato proposto da Ergon Informatica.

I componenti del gruppo *Memory Leakers* ringraziano *Ergon Informatica* per la disponibilità e
la chiarezza dimostrata.