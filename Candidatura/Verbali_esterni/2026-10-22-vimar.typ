#import "../../Templates/Verbali.typ": verbale, gloss, 
#let colore-primario = rgb("#305b57")
#let colore-sfondo = rgb("#eaf7f2")
#let colore-bordo = rgb("#49736a")

#show: verbale.with(
  titolo: "Verbale riunione esterna con Vimar del 22/10/2026",
  tipo-documento: "Verbale Esterno",
  data: datetime(year: 2026, month: 10, day: 22),
  ora: "16:00 - 17:00",
  luogo: "Microsoft Teams",
  versione: "1.0.0",
  stato: "Approvato",
  autore: "Jacopo De Donà",
  verificatore: "Chiara Protopapa",
  file-nome: "2026-10-22-vimar.pdf",
  gruppo: "Memory Leakers",
  ordine-del-giorno: (
    [Risposte di Vimar ai temi emersi dal sondaggio preliminare sul capitolato C1 - AURA],
    [Sessione di domande e risposte in diretta],
    [Prossimi passi e modalità di approvazione del verbale esterno]
  ),
  partecipanti: (
    "Mariano Sciacco (Vimar)", "Domenico Bevilacqua (Vimar)", "Jacopo De Donà", "Matteo Marcon"
  ),
  distribuzione: ("Memory Leakers", "Vimar", "Prof. Riccardo Cardin", "Prof. Tullio Vardanega"),
  registro-modifiche: (
    ([1.0.0], [26/10/2026], [Versione finale firmata], [Jacopo De Donà], [Paolo Prevedello Ramirez]),
    ([0.1.0], [26/10/2026], [Verifica del verbale], [Jacopo De Donà], [Chiara Protopapa]),
    ([0.0.2], [25/10/2026], [Aggiunta sezione decisioni ed attività], [Jacopo De Donà], []),
    ([0.0.1], [25/10/2026], [Bozza del verbale], [Jacopo De Donà], []),
  ),
  ora-fine-riunione: "17:00",
  mostra-conclusioni-automatiche: false,
  firma-responsabile: "Paolo Prevedello Ramirez",
  firma-esterna: "",
)

= Introduzione
Il presente documento attesta che in data *22 ottobre 2026* è avvenuto l'incontro con il #gloss[*proponente*]
*Vimar*, in videoconferenza tramite Microsoft Teams. L'incontro, rivolto a tutti i gruppi interessati, è stato
organizzato nell'ambito della fase di pre-assegnazione dei capitolati con lo scopo di rispondere ai dubbi raccolti
riguardo al capitolato *C1 - AURA*. I relatori per conto dell'azienda sono stati Mariano Sciacco e Domenico Bevilacqua.

= Preparazione all'incontro
Prima dell'incontro, l'azienda ha raccolto le domande dei gruppi interessati tramite un sondaggio. Il gruppo
*Memory Leakers* ha utilizzato il file condiviso su Google Drive per raccogliere in maniera #gloss[asincrona] i dubbi
dei singoli componenti, inviandoli poi tramite il sondaggio.

= Quesiti
I temi a cui hanno contribuito le domande del gruppo *Memory Leakers* sono stati i seguenti:
1. Che ruolo deve avere il client #gloss[MCP]?
2. Come funziona l'autenticazione MyVimar all'interno della chat?
3. Chi blocca le richieste sbagliate in caso di comandi critici?
4. È preferibile il #gloss[polling] o la #gloss[subscription] per lo stato dei dispositivi e le notifiche?
5. Quali richieste deve saper gestire l'assistente?
6. Esiste un ambiente simulato per sviluppare in parallelo?
7. Quali sono le priorità e cosa aspettarsi dal #gloss[PoC]?

Nel corso dell'incontro l'azienda ha comunque risposto a tutti i 14 temi emersi, riportati di seguito.

= Resoconto
== Architettura e linguaggi
=== Linguaggio e SDK
L'azienda non pone vincoli sul linguaggio: Python, Java o TypeScript sono tutti ammessi e la scelta va fatta in base
alle competenze del gruppo. È consigliato Python con #gloss[FastMCP], in quanto #gloss[SDK] ufficiale suggerito nel
capitolato e quello su cui l'azienda può fornire un supporto tecnico più diretto. Usare lo stesso SDK per client e
server MCP semplifica i test di integrazione tra i due.

=== Ruolo del client MCP
Lo scopo finale del progetto è il controllo dei dispositivi: l'#gloss[LLM] deve poter usare il server MCP sviluppato
dal gruppo. I servizi commerciali (es. Claude, ChatGPT) includono già un client MCP standard, per cui l'utilità di un
client proprio è legata soprattutto ai test di integrazione; eventuali #gloss[CLI], #gloss[TUI] o estensioni per
VS Code sono opzionali. La suddivisione della gestione degli errori tra server e client (es. dispositivo non
raggiungibile) sarà parte del lavoro di progettazione del gruppo. L'azienda ha inoltre sottolineato che, con un buon
server MCP, l'automazione non è un componente a sé, ma si ottiene tramite una #gloss[skill] o un prompt.

=== Collegamento dell'LLM per l'utente finale
Non è richiesto lo sviluppo di un'app o di un sito web: la soluzione è principalmente #gloss[back-end] e l'utente
utilizza l'interfaccia già pronta dei servizi LLM. È consigliato l'uso di un server MCP locale per test e debug,
mentre per l'utente finale serve un server MCP remoto con URL pubblico e autenticazione, utilizzabile da web, desktop
e mobile. È sufficiente il funzionamento con un qualsiasi servizio AI commerciale; il supporto a più servizi è
gradito, ma non è richiesta alcuna interfaccia di selezione.

=== Risorse LLM, cloud e consegna
Per l'LLM possono essere usati i piani gratuiti o studente dei servizi commerciali (es. connettore personalizzato di
Claude, Copilot con il GitHub Student Pack). Su richiesta, e da discutere in fase di avvio, l'azienda può fornire
accesso a un insieme ristretto di servizi #gloss[AWS] e una chiave LLM per alcune prove. Per la consegna è
sufficiente che la soluzione funzioni in locale tramite #gloss[Docker]: al collaudo sarà l'azienda a installarla su
AWS o su un proprio server.

== Protocolli e sicurezza
=== Autenticazione MyVimar
È necessario un account MyVimar con accesso all'impianto; ogni utente vede solo i propri impianti, anche più di uno.
Il server MCP associa ogni utente alla propria autorizzazione #gloss[OAuth2] e la utilizza verso le #gloss[API]: il
servizio AI non vede mai i #gloss[token]. La progettazione del flusso di login (es. link di autorizzazione da aprire
nel browser, permessi di lettura e scrittura da concedere) è a carico del gruppo. Per quanto riguarda la privacy, i
dati dell'impianto possono arrivare all'LLM per elaborare la risposta, mentre i dati sensibili come i token mai.

=== Comandi critici
Le API Vimar leggono e scrivono come qualsiasi altra applicazione e non prevedono protezioni specifiche per l'uso con
un LLM. Le letture possono essere dirette, mentre per le scritture (es. "spegni tutto") si può prevedere una conferma
da parte dell'utente. I permessi sono configurabili (sola lettura, lettura e scrittura, solo alcuni dispositivi)
tramite gli #gloss[scope] di #gloss[KNX IoT]. L'agente deve comprendere la richiesta e usare il #gloss[tool]
corretto; #gloss[guardrail] o skill aggiuntive sono ammessi se motivati nei requisiti.

=== Polling e notifiche
Per questo progetto il polling è adeguato, come previsto dal capitolato e concordato dal proponente. Generalmente un
servizio AI non riceve messaggi avviati da un #gloss[webhook], ma è possibile esplorare se qualche servizio lo
supporti.

=== Richieste gestite dall'assistente
Gli utenti non useranno le frasi esatte degli esempi: l'LLM deve gestire varianti, sinonimi e richieste ambigue. I
casi base e avanzati del capitolato sono esempi e non un elenco esaustivo, e costituiscono il punto di partenza per
i requisiti. Nuove interazioni non previste sono un nice-to-have gradito, da discutere con l'azienda. È stato
consigliato di far riformulare a un LLM le domande della test list e di provarle con modelli diversi, per aumentarne
la variabilità.

== Sviluppo e test
=== Kit di impianto
Il kit si collega al Wi-Fi e si comanda via cloud tramite le API KNX IoT, senza necessità di USB o #gloss[VPN]. Un
membro del gruppo terrà il kit a casa, sempre acceso e collegato, mentre gli altri lavoreranno da remoto tramite API.
L'azienda fornirà un account amministratore, al quale potranno essere aggiunti uno o più utenti previa registrazione
su MyVimar. È stato suggerito di premere un tasto sul kit e osservare cosa cambia via API, come modo più rapido per
comprendere il modello dati.

=== Ambiente simulato
A partire dalla specifica #gloss[OpenAPI] (YAML) di KNX IoT e con strumenti come #gloss[Prism] è possibile generare
in locale un #gloss[mock server] con risposte realistiche; è inoltre disponibile una demo online di KNX IoT con API di
mocking, inclusa nella documentazione per integratori. Il mock non replica esattamente il concetto di impianto di Vimar, per cui la validazione finale va effettuata sul kit. L'approccio consigliato è usare il mock per
lo sviluppo quotidiano e il kit per i test #gloss[end-to-end].

=== Test e CI
La copertura dell'80% dei test end-to-end si può misurare sui requisiti di progetto; la test list del capitolato
copre le casistiche base delle interazioni dell'utente con il servizio AI. Nei test automatici di unità e di
integrazione è possibile simulare il servizio AI tramite mock, ottenendo test ripetibili, deterministici e senza
costi. Per questi test vale la copertura del codice: minimo 75%, opzionalmente oltre il 90%. Essendo un LLM reale non
deterministico, l'azienda consiglia di tenerlo fuori dalla #gloss[CI].

== Organizzazione
=== Priorità e PoC
Il capitolato descrive esigenze di business: la definizione dei requisiti formali e delle relative priorità spetta al
gruppo come parte dell'analisi. Il PoC minimo atteso è un server MCP funzionante su 2-3 casi base: accesso
all'impianto, elenco degli impianti associati e stato di una luce. I requisiti opzionali e i nice-to-have non sono
obbligatori, ma i nice-to-have sono preferibili rispetto agli opzionali. È stato consigliato di partire dai criteri
obbligatori del capitolato e di costruire i requisiti a partire dai casi base.

=== Cosa studiare
Non c'è una scadenza entro cui informarsi, poiché il lavoro inizia dopo l'aggiudicazione; esplorare le tecnologie fin
da ora aiuta però a scegliere con consapevolezza. I punti di partenza indicati sono la documentazione KNX IoT per
integratori, le primitive Vimar rispetto al protocollo e lo standard MCP. Le difficoltà principali riscontrate negli
anni precedenti sono state requisiti poco chiari o mal indirizzati all'inizio, documentazione migliorabile e i forti
limiti degli LLM eseguiti in locale. L'azienda ha quindi raccomandato di chiarire presto i dubbi sui requisiti e di
evitare l'esecuzione dell'LLM in locale, preferendo i servizi commerciali.

=== SAL e incontri
Gli stati di avanzamento lavori (#gloss[SAL]) si terranno generalmente su Microsoft Teams, con la possibilità di
svolgerli in presenza nelle salette della sede Vimar in caso di necessità. Sono previsti due incontri obbligatori in
presenza: all'inizio del progetto, per la consegna del kit, e al collaudo finale. Sono inoltre previste
indicativamente due demo con i colleghi del reparto R&D, a metà progetto (PoC) e alla fine (#gloss[MVP]). L'azienda
si è resa disponibile per dubbi progettuali, scelte architetturali e coerenza della soluzione.

= Decisioni e attività

== Decisioni prese
Data la natura dell'incontro, non sono state prese decisioni vincolanti. Le indicazioni dell'azienda sono state raccolte come
requisiti e linee guida per la progettazione della soluzione, e sono state riportate nel verbale per chiarezza e tracciabilità.

#v(10pt)

== Attività da svolgere
#table(
  columns: (0.5fr, 1.2fr, 2.5fr, 1fr, 1fr),
  inset: 7pt,
  align: (col, row) => if row == 0 { center + horizon } else { left + horizon },
  fill: (x, y) => if y == 0 { colore-primario } else if calc.even(y) { colore-sfondo } else { none },
  stroke: 0.5pt + colore-bordo,
  [*#text(fill: white)[ID]*], [*#text(fill: white)[Nome Attività]*], [*#text(fill: white)[Breve Descrizione]*], [*#text(fill: white)[Responsabile]*], [*#text(fill: white)[Scadenza]*],
  [A1], [Verifica e invio del verbale], [Verifica del presente verbale e invio a Vimar per l'approvazione], [Chiara Protopapa, Riccardo Peresson], [28/10/2026],
  [A2], [Aggiornamento Glossario], [Inserimento dei nuovi termini emersi], [Jacopo Franco], [29/10/2026],
  [A3], [Valutazione capitolato C1], [Integrazione delle risposte ricevute nella valutazione del capitolato per la candidatura], [Tutto il gruppo], [30/10/2026],
  [A4], [Studio delle tecnologie], [Studio esplorativo di documentazione KNX IoT per integratori, standard MCP e FastMCP], [Tutto il gruppo], [Continuativa],
  [A5], [Avvio con Vimar], [In caso di aggiudicazione: concordare l'incontro di consegna del kit, individuare chi lo custodirà e valutare la richiesta di accesso AWS e chiave LLM], [Da assegnare], [Dopo il 03/11/2026],
)

= Conclusioni
L'incontro è stato utile per chiarire i dubbi sorti tra i componenti del gruppo riguardo all'architettura, alla
sicurezza e ai requisiti del capitolato *C1 - AURA* proposto da Vimar.

I componenti del gruppo *Memory Leakers* ringraziano *Vimar* per la disponibilità e la chiarezza dimostrata.
