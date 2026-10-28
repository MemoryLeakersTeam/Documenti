#import "../../Templates/Verbali.typ": verbale, gloss, 
#let colore-primario = rgb("#305b57")
#let colore-sfondo = rgb("#eaf7f2")
#let colore-bordo = rgb("#49736a")

#show: verbale.with(
  titolo: "Verbale riunione esterna con Miriade del 26/10/2026",
  tipo-documento: "Verbale Esterno",
  data: datetime(year: 2026, month: 10, day: 26),
  ora: "17:00 - 17:30",
  luogo: "Google Meet",
  versione: "1.0.0",
  stato: "Approvato",
  autore: "Matteo Marcon",
  verificatore: "Chiara Protopapa",
  file-nome: "2026-10-26-miriade.pdf",
  gruppo: "Memory Leakers",
  ordine-del-giorno: (
    [Risposte di Miriade ai quesiti posti sul capitolato C5 - RareCare Navigator],
  ),
  partecipanti: (
    "Emanuele Righetto (Miriade)", "Matteo Marcon", "Jacopo De Donà", "Chiara Protopapa", "Riccardo Peresson"
  ),
  distribuzione: ("Memory Leakers", "Miriade", "Prof. Riccardo Cardin", "Prof. Tullio Vardanega"),
  registro-modifiche: (
    ([1.0.0], [28/10/2026], [Firma ed approvazione del verbale], [Matteo Marcon], [Paolo Prevedello Ramirez]),
    ([0.1.0], [27/10/2026], [Verifica del verbale], [Matteo Marcon], [Chiara Protopapa]),
    ([0.0.1], [27/10/2026], [Bozza del verbale], [Matteo Marcon], []),
  ),
  ora-fine-riunione: "17:30",
  mostra-conclusioni-automatiche: false,
  firma-responsabile: "Paolo Prevedello Ramirez",
  firma-esterna: "",
)

= Introduzione
Il presente documento attesta che in data *26 ottobre 2026* è avvenuto l'incontro con il #gloss[*proponente*]
*Miriade*, in videoconferenza tramite Google Meet. L'incontro è stato
organizzato nell'ambito della fase di pre-assegnazione dei capitolati con lo scopo di rispondere ai dubbi raccolti
riguardo al capitolato *C5 - RareCare Navigator*. Il relatore per conto dell'azienda è stato Emanuele Righetto, mentre in rappresentanza del gruppo hanno partecipato Matteo Marcon, Jacopo De Donà, Chiara Protopapa e Riccardo Peresson.

= Preparazione all'incontro
Il gruppo *Memory Leakers* ha utilizzato un file condiviso su Google Drive per raccogliere in maniera #gloss[asincrona] i dubbi dei singoli componenti, inviandoli poi tramite email all'azienda come richiesto dalla stessa. 
Giovedì 22 ottobre 2026 l'azienda ha trasmesso via email le risposte alle domande formulate dal gruppo. Ciononostante, si è ritenuto opportuno procedere comunque con un incontro online, al fine di discutere e approfondire gli argomenti del progetto.

= Quesiti
Riassumendo, le questioni poste dal gruppo sono state le seguenti:
1. Quale ruolo assumono nella pianificazione del progetto le tre evoluzioni proposte?
2. Saranno previsti momenti di confronto e approfondimento tecnico sulle tecnologie specifiche suggerite?
3. Prevedete un'integrazione diretta con i sistemi informativi sanitari pubblici?
4. Ci fornirete voi la documentazione e le fonti ufficiali da utilizzare o sarà compito del gruppo reperire e selezionare tali risorse?
5. Avete definito i criteri con cui verificare il rispetto dei requisiti di pertinenza delle risposte dell'assistente? Sarà disponibile un dataset per valutare l'affidabilità?
6. Quali profili utente vi aspettate di vedere effettivamente implementati e funzionanti?
7. Ritenete necessario sviluppare un modulo applicativo specifico per anonimizzare o mascherare i dati sensibili?
8. Metterete a disposizione un account #gloss[AWS] o dei crediti per gestire i test che potrebbero generare costi?
9. Quale livello di completezza vi aspettate per l'interfaccia dell'#gloss[MVP]?

= Resoconto
== Pianificazione delle evoluzioni
L’azienda collaborerà con il gruppo per definire i requisiti e le funzionalità da implementare.
In una prima fase verrà realizzato l’assistente #gloss[RAG] attraverso il popolamento di un database vettoriale a partire dalla documentazione fornita; questo  consentirà al chatbot di recuperare le informazioni pertinenti in base al contesto della richiesta.
In una seconda fase verranno valutate funzionalità di analisi automatica finalizzate all’estrazione di informazioni strutturate e alla generazione di suggerimenti.
Tali suggerimenti avranno carattere consultivo e non dovranno costituire indicazioni operative. Il chatbot non dovrà assumere decisioni autonome e le eventuali proposte dovranno prima essere approvate.
Le evoluzioni successive andranno valutate secondo tempi e risorse disponibili.

== Approfondimenti tecnici
L'azienda ha confermato di disporre internamente di competenze tecniche nei diversi ambiti proposti, precisando che la scelta delle tecnologie suggerite è stata effettuata con l'obiettivo di poter fornire supporto al gruppo durante lo sviluppo del progetto.
Per quanto riguarda l’eventuale componente mobile, è stato specificato che la risorsa con competenze su React Native è attualmente impegnata in un altro progetto. Pertanto, l'azienda ha suggerito di valutare Flutter come possibile alternativa. 

== Sistemi informativi sanitari pubblici
Sebbene sia stata riconosciuta l'utilità, attualmente non è prevista un'integrazione diretta con i sistemi informativi sanitari pubblici, anche in considerazione delle diversità degli strumenti adottati a livello regionale.
È stato inoltre specificato che il Care Navigator e gli altri attori coinvolti, in base ai rispettivi permessi, potranno caricare documenti all’interno della piattaforma, quali esami, referti e altra documentazione pertinente.

== Documenti e fonti ufficiali
Verranno forniti i riferimenti e i documenti verificati in collaborazione con l'associazione Sanfilippo fighters.

== Pertinenza delle risposte
L’azienda ha indicato che l’assistente RAG potrà essere configurato tramite prompt e/o Guardrails per utilizzare esclusivamente fonti verificate ed evitare informazioni non supportate. Sarà possibile svolgere sessioni di test con il supporto dell’associazione, ma al momento non è stato definito un dataset specifico per la validazione.

== Profili utente
È stato chiarito che #gloss[AVP] è una soluzione suggerita, ma non vincolante.
È stata espressa la preferenza per una gestione dinamica dei ruoli e dei permessi, che consenta di configurare nuove tipologie di utente e i relativi permessi senza modificare direttamente il codice.
I profili utente di base previsti sono Caregiver, Care Navigator, Insegnante, Professionista (medico o terapista). Sarà possibile introdurre opzionalmente ulteriori figure, tuttavia l'azienda ha sottolineato la necessità di stabilire delle priorità.

== Anonimizzazione dei dati sensibili
L’azienda ha indicato che la protezione dei dati sensibili sarà eventualmente approfondita con l’associazione e il team legale. 
Il mascheramento dei dati identificativi potrebbe essere gestito tramite i filtri PII di Amazon Bedrock Guardrails, mentre lo sviluppo di un modulo applicativo dedicato potrebbe non rientrare nello scope del progetto. 

== Gestione dei costi dei test
Verrà messo a disposizione un account AWS con permessi limitati. Sarà necessario coordinarsi con il reparto IT per definire eventuali autorizzazioni aggiuntive e contenere i costi. 
Il gruppo dovrà quindi tenere conto di possibili rallentamenti nelle tempistiche.

== Interfaccia
L’azienda ha chiarito che il livello di completezza dell’interfaccia dovrà essere definito in base alle priorità e ai tempi disponibili, valutando opportuni compromessi tra funzionalità e cura della #gloss[UX/UI]. Ha inoltre offerto la possibilità di organizzare workshop con il team di design system per supportare la definizione dei flussi applicativi e dell’interfaccia.
Per lo sviluppo, Flutter è fortemente consigliato per la componente mobile, mentre per il web è possibile valutare tecnologie differenti. È stato infine sottolineato che l’uso di strumenti di AI è incoraggiato come supporto allo sviluppo, purché il gruppo mantenga il controllo del codice e delle scelte architetturali.

= Decisioni e attività

== Decisioni prese
Data la natura dell'incontro, non sono state prese decisioni vincolanti. Le indicazioni dell'azienda sono state raccolte come
requisiti, approfondimenti e linee guida per la progettazione della soluzione e l'analisi del capitolato e sono state riportate nel verbale per chiarezza e tracciabilità.

#v(10pt)

== Attività da svolgere
#table(
  columns: (0.5fr, 1.2fr, 2.5fr, 1fr, 1fr),
  inset: 7pt,
  align: (col, row) => if row == 0 { center + horizon } else { left + horizon },
  fill: (x, y) => if y == 0 { colore-primario } else if calc.even(y) { colore-sfondo } else { none },
  stroke: 0.5pt + colore-bordo,
  [*#text(fill: white)[ID]*], [*#text(fill: white)[Nome Attività]*], [*#text(fill: white)[Breve Descrizione]*], [*#text(fill: white)[Responsabile]*], [*#text(fill: white)[Scadenza]*],
  [A1], [Verifica e invio del verbale], [Verifica del presente verbale e invio a Miriade per l'approvazione], [Chiara Protopapa, Riccardo Peresson], [28/10/2026],
  [A2], [Aggiornamento Glossario], [Inserimento dei nuovi termini emersi], [Jacopo Franco], [29/10/2026],
  [A3], [Valutazione capitolato C5], [Integrazione delle risposte ricevute nella valutazione del capitolato per la candidatura], [Tutto il gruppo], [30/10/2026],
  [A4], [Studio delle tecnologie], [Studio esplorativo di database vettoriali, Flutter, React Native, AWS], [Tutto il gruppo], [Continuativa],
  [A5], [Avvio con Miriade], [In caso di aggiudicazione: concordare l'incontro di avvio], [Da assegnare], [Dopo il 03/11/2026],
)

= Conclusioni
L'incontro è stato utile per chiarire i dubbi emersi nell'analisi del capitolato *C5 - RareCare Navigator* proposto da Miriade.

I componenti del gruppo *Memory Leakers* ringraziano *Miriade* per il contributo fornito nell'approfondimento del progetto proposto, la disponibilità e la chiarezza dimostrata.
