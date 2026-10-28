#import "../../Templates/DocumentiGenerici.typ": documento

#show: documento.with(
  titolo: "Analisi dei Capitolati",
  sottotitolo: "Valutazione e scelta dei capitolati d'appalto per l'A.A. 2026/2027",
  gruppo: "Memory Leakers",
  tipo-documento: "Analisi dei Capitolati",
  versione: "0.0.1",
  autore: "Memory Leakers",
  verificatore: "",
  stato: "Bozza",
  data: datetime(year: 2026, month: 10, day: 28),
  file-nome: "analisi-dei-capitolati.typ",
  registro-modifiche: (
    "0.0.1", "28/10/2026", "Stesura iniziale del documento di analisi dei capitolati.", "Memory Leakers", "",
  ),
  firma-responsabile: ""
)

// Regola per rendere in grassetto i titoli dei capitolati nell'indice
#show outline.entry: it => {
  if it.level == 1 and it.element.text.starts-with("C") {
    v(0.1em)
    strong(it)
  } else {
    it
  }
}

// Variabili colore per le tabelle coerenti con il template
#let colore-primario = rgb("#305b57")
#let colore-sfondo = rgb("#eaf7f2")
#let colore-bordo = rgb("#49736a")

= Introduzione
Il gruppo Memory Leakers (gruppo 3), composto da sette persone, ha analizzato tutti i capitolati proposti per l'anno accademico 2026/2027 per individuare il più affine alla candidatura; per ciascun capitolato il documento riporta, con lo stesso schema: descrizione, obiettivo, tecnologie richieste, pro e contro alla motivazione per il capitolato scelto e le conclusioni del gruppo.

*Fonti.* Ogni valutazione si basa sulla documentazione fornita da ogni proponente e sulle slide presentate in aula il 13/10/2026; per i capitolati C1, C5, C6 e C7 si aggiungono, inoltre, gli incontri esplorativi con le aziende (Appendice B), di cui sono riportati gli esiti. 

*Criteri di valutazione.* Il gruppo ha considerato: rischio tecnico e fattibilità nelle ore a disposizione, chiarezza dei requisiti e dei criteri di accettazione, supporto offerto dal proponente, interesse del gruppo e competenze di partenza, valore formativo, allineamento con i criteri del corso (documentazione, verifica, tracciabilità).

*Esito.* Il gruppo si candida al capitolato C6 (Var Group); in caso di mancata aggiudicazione indica come seconda scelta C7 (Ergon) e come alternative C1 (Vimar) e C5 (Miriade). Gli altri capitolati non sono stati selezionati per le ragioni riportate nelle rispettive conclusioni.

= Riepilogo
#table(
  columns: (1fr, 1.3fr, 0.8fr, 2.5fr),
  inset: 7pt,
  align: (col, row) => if row == 0 { center + horizon } else { left + horizon },
  fill: (x, y) => if y == 0 { colore-primario } else if calc.even(y) { colore-sfondo } else { none },
  stroke: 0.5pt + colore-bordo,
  [*#text(fill: white)[Capitolato]*], [*#text(fill: white)[Proponente]*], [*#text(fill: white)[Incontro]*], [*#text(fill: white)[Esito del gruppo]*],
  [C0 AIRA], [Sanmarco Informatica], [no], [Non selezionato: nessuna soglia di accettazione, più componenti AI in cascata],
  [C1 AURA], [Vimar], [22/10/2026], [Alternativa: requisiti molto chiari, tecnologie nuove e dominio meno vicino al gruppo],
  [C2 NEXUM Concierge], [Eggon], [no], [Non selezionato: carico dichiarato (480 ore a persona) incompatibile, stack AI da definire],
  [C3 FossDot], [Uranion], [no], [Non selezionato: hardware, firmware e backend, rischio tecnico troppo alto],
  [C4 Veicoli e post-vendita], [M31], [no], [Non selezionato: requisiti non specificati, microservizi],
  [C5 RareCare Navigator], [Miriade], [26/10/2026], [Alternativa: forte valore sociale, perimetro ampio e tecnologie nuove],
  [C6 Caching semantico e FinOps], [Var Group], [26/10/2026], [Capitolato scelto],
  [C7 SmartDashboard], [Ergon Informatica], [22/10/2026], [Seconda scelta: percorso completo, perimetro ampio],
  [C8 Sonar], [Halue], [no], [Non selezionato: stack vincolante],
  [C9 SpecCheck], [Zucchetti], [no], [Non selezionato: esito incerto, nessun criterio di accettazione]
)

= C0 - AIRA (Sanmarco Informatica)
== Descrizione
Sanmarco Informatica S.p.A. propone AIRA (AI Requests Automation), un sistema per gestire richieste aziendali non strutturate (ordini d'acquisto, ticket di assistenza, prenotazioni, opportunità commerciali) provenienti da canali eterogenei come e-mail, messaggistica e cartelle condivise. 
Le richieste arrivano come testo, note vocali, immagini e PDF scansionati, spesso con abbreviazioni e codici incompleti: presidiare a mano ogni fonte sovraccarica gli operatori e causa errori e ritardi. Il sistema ha l'obiettivo di elaborare i diversi formati con modelli AI, OCR e speech-to-text, trasformarli in dati strutturati (ad esempio JSON) e inoltrarli ai gestionali aziendali tramite API REST.

== Obiettivo
Il capitolato richiede una pipeline che:
- monitora in continuo i canali configurati (caselle di posta, WhatsApp, cartelle su filesystem), rilevando mittente, testo e allegati;
- filtra i dati in ingresso per isolare i clienti (tenant) ed evitare accessi non autorizzati;
- converte l'audio in testo e legge immagini e documenti scansionati (OCR e visione artificiale);
- interpreta le richieste con un LLM e le mappa su template per tipologia (ordine, ticket, caso, evento), associando ad esempio le descrizioni informali ai codici articolo del catalogo;
- avvia azioni configurabili: chiamate REST a portali B2B, ERP, CRM, ticketing oppure invio di e-mail;
- espone un'interfaccia web di amministrazione per configurare i canali, consultare lo storico dei log e gestire la persistenza dei dati.

Sono opzionali una dashboard analitica dei flussi e le risposte automatiche al mittente.

== Tecnologie richieste
Il proponente consiglia Java con Spring Boot (pipeline modulare a eventi), LangChain4j per l'interpretazione con LLM, Whisper, Google Speech, Tesseract o EasyOCR per speech-to-text e OCR, SQLite, MariaDB o PostgreSQL per i dati, Angular con TypeScript per l'interfaccia amministrativa, configurazione esterna in JSON o YAML.

== Pro e contro
=== Pro
- Problema aziendale concreto e ben motivato, con un'architettura a pipeline modulare facile da suddividere fra i componenti del gruppo.
- Tecnologie accessibili e documentate; supporto con metodologia Agile da parte di Sanmarco, azienda con solida esperienza industriale.
- Buon valore formativo: elaborazione multimodale, uso degli LLM per strutturare i dati, integrazione con servizi REST.

=== Contro
- Nessuna soglia quantitativa (volumi, accuratezza, copertura dei test) né criteri di accettazione misurabili.
- Ampiezza tecnica: tre tipi di elaborazione (audio, immagini, testo) più l'integrazione con i gestionali da realizzare e valutare nelle ore disponibili, senza metriche di accuratezza indicate dal proponente.
- La parte più delicata, associare descrizioni informali ai codici di catalogo, dipende da un catalogo di prova e da un livello di accuratezza non definiti; non sono forniti lo schema delle API di destinazione né dettagli sull'integrazione con WhatsApp.
- Trattamento di voce, immagini e dati commerciali potenzialmente sensibili, con isolamento dei tenant da progettare.
- Interesse limitato del gruppo per lo stack Java/Spring Boot e per il dominio B2B.

== Conclusioni
Il gruppo preferisce non procedere alla candidatura per questo capitolato. L'assenza di criteri di accettazione misurabili e dei dati necessari alla parte più critica rende difficile dimostrare in modo oggettivo il valore di un MVP, e l'ampiezza tecnica (audio, immagini, testo e integrazione con i gestionali) richiede un carico elevato rispetto alle ore a disposizione. La valutazione si basa sull’analisi autonoma del capitolato e sulla presentazione svolta in aula: non è stato svolto un incontro con l'azienda.

= C1 - AURA (Vimar)
== Descrizione
Vimar S.p.A. vuole mostrare come i servizi di AI generativa esistenti (Claude, ChatGPT, Gemini, Copilot) possano essere usati come interfaccia in linguaggio naturale per gli impianti domotici residenziali Vimar View Wireless, senza sviluppare un assistente dedicato. L'impianto consiste in una rete Bluetooth Mesh collegata al cloud Vimar tramite un gateway BLE. L'accesso programmatico passa dalle KNX IoT 3rd-party API, un'interfaccia REST in cui un ambiente (Location) contiene funzionalità (Function) i cui attributi sono i Datapoint. Il progetto rende queste API utilizzabili da un modello linguistico attraverso il Model Context Protocol (MCP): un server espone risorse e strumenti, un client permette al modello di scoprirli e usarli.

== Obiettivo
Il capitolato richiede tre componenti obbligatori:
- Infrastruttura cloud-ready: container, Infrastructure as Code, avvio con un solo comando (`docker compose up`); compatibilità con AWS, mentre il rilascio su AWS è opzionale.
- Server e client MCP: il server supporta le API KNX IoT (Authorization, Datapoint, Function, Information, Location, Subscription, Timeseries), in lettura e scrittura, con autenticazione OAuth2 e ricostruzione delle relazioni tra ambienti, funzionalità e datapoint; il client si interfaccia solo con il server realizzato.
- Agente o modello AI esterno commerciale, con autenticazione dell'utente tramite account MyVimar, scelta e memorizzazione dell'impianto nella conversazione, lettura e modifica dello stato dei dispositivi.

I casi d'uso previsti sono 17 casi base e 21 casi avanzati. Sono nice-to-have gli scenari multi-impianto, i comandi condizionali, lo storico e i trigger. La copertura dei test deve essere almeno del 75% su unità e integrazione, mentre almeno dell'80% sui test end-to-end. Sono previsti due incontri in presenza a Padova e due dimostrazioni al reparto R&D.

== Tecnologie richieste
- *Vincolanti:* Docker con docker-compose, KNX IoT 3rd-party API, OAuth2, repository Git pubblico con licenza open source.
- *Suggerite:* Python con l'SDK FastMCP (alternative TypeScript o Java), AWS Lightsail o EC2, database relazionali o Redis, CI con GitHub Actions, Terraform, AWS CDK o Ansible.
- *Hardware:* kit fisico portatile (gateway BLE, attuatori, comando tapparelle, sensori, termostato) fornito dall'azienda.

== Pro e contro
=== Pro
- Requisiti, casi d'uso e criteri di completamento molto chiari, già classificati per priorità; ampia libertà di partire da un MVP di due o tre casi base.
- Azienda preparata, partecipe e disponibile a incontri e a chiarire dubbi, con incontri periodici strutturati.
- Hardware reale già disponibile, con un mock generabile dall'OpenAPI e una demo online.
- Perimetro tecnico circoscritto, con focus prevalentemente sul back-end e nessuno sviluppo di interfacce web o mobile.
- Tecnologie attuali e spendibili (MCP, OAuth2, Infrastructure as Code, AWS, test su più livelli).

=== Contro
- Dipendenza da un'infrastruttura proprietaria (cloud Vimar) e un solo kit fisico per sette persone che richiede di organizzare lo sviluppo da remoto tramite i mock e il gateway cloud messi a disposizione.
- Tecnologie quasi tutte nuove per il gruppo (MCP, KNX IoT, OAuth2 con più attori).
- Soglia E2E dell'80% da definire rispetto ai requisiti di progetto; documentazione e infrastruttura da produrre in parallelo allo sviluppo (modello C4, stima dei costi AWS, sito statico).
- Modelli AI esterni non controllabili e costi di utilizzo dei modelli commerciali da chiarire.
- Dominio non pienamente in linea con gli interessi del gruppo.

== Esito dell'incontro del 22/10/2026
- *Priorità:* requisiti e priorità li definisce il gruppo; il minimo atteso è un server MCP funzionante su due o tre casi base; un nice-to-have è preferibile a un opzionale.
- *Richieste degli utenti:* l'LLM deve gestire varianti, sinonimi e richieste ambigue; i casi del capitolato non sono esaustivi e nuovi casi sono graditi.
- *Sicurezza:* nessuna protezione specifica lato API per l'uso con un LLM; per le scritture estese si può prevedere la conferma; ogni utente vede solo i propri impianti e il servizio AI non vede mai i token.
- *Un solo kit:* si comanda via cloud; un membro del gruppo lo tiene acceso e gli altri lavorano da remoto; sono disponibili un account amministratore con utenti extra, un mock e una demo online.

== Conclusioni
C1 è il capitolato con i criteri di completamento più definiti, un supporto molto strutturato e un risvolto pratico concreto. Il gruppo lo mantiene tra le alternative: le tecnologie sono quasi tutte nuove, la soluzione è quasi interamente back-end, il dominio soddisfa parzialmente gli interessi del gruppo, tuttavia il capitolato C6 tratta un tema maggiormente in linea con le preferenze espresse dal gruppo, mantenendo un perimetro altrettanto chiaro.

= C2 - NEXUM Concierge (Eggon)
== Descrizione
Eggon S.r.l. sviluppa NEXUM, una piattaforma di comunicazione aziendale e servizi HR composta da un backoffice amministrativo e da una PWA per il personale. Il progetto introduce nella PWA un assistente conversazionale (Concierge) che permette di trovare informazioni, comprendere procedure e accedere ai servizi in linguaggio naturale. L'MVP è limitato all'area ferie e permessi.

== Obiettivo
Il capitolato richiede in un'unica soluzione:
- una chat testuale con gestione del contesto del dialogo;
- un backoffice per caricare, sostituire e ritirare le fonti (PDF testuali), con stato di elaborazione;
- una knowledge base con risposte che citano le fonti e astensione quando le fonti non bastano o si contrariano;
- abilità di lettura dei dati personali e di registrazione delle richieste;
- autorizzazioni verificate dai servizi, gestione degli errori e tracciabilità di fonti ed esiti.

== Tecnologie richieste
Stack NEXUM: Angular con PrimeNG (backoffice), Angular con Tailwind CSS (PWA), Ruby on Rails per le API condivise, OAuth2 e JWT, PostgreSQL, Redis, AWS S3, Sidekiq. Lo stack AI e i modelli sono da concordare dopo l'aggiudicazione.

== Pro e contro
=== Pro
- Requisiti di business numerati e criteri di accettazione molto specifici; perimetro funzionale definito (ferie e permessi).
- Gruppo di comunicazione dedicato con l'azienda, referente disponibile e percorso strutturato.

=== Contro
- Perimetro ampio e obiettivi che richiedono un'analisi dei requisiti molto accurata.
- Stack AI e modelli da concordare solo dopo l'aggiudicazione.
- Tecnologie poco note al gruppo (Ruby on Rails) e dominio HR di limitato interesse.

== Conclusioni
Il gruppo preferisce non procedere alla candidatura per questo capitolato a causa dello stack poco noto e del dominio HR di limitato interesse.

= C3 - FossDot (Uranion)
== Descrizione
Uranion EMEA Ltd propone FossDot, uno smart speaker open source, estensibile e rispettoso della privacy, pensato come alternativa self-hosted ad Amazon Echo o Google Nest.

== Obiettivo
Il capitolato richiede quattro componenti:
- scelta e validazione dell'hardware di riferimento;
- firmware embedded (Rust preferenziale);
- servizio di bridging STT -> LLM -> TTS;
- interfaccia web per registrare e gestire più dispositivi.

== Tecnologie richieste
Rust embedded ed Embassy, Raspberry Pi o ESP32, openWakeWord, Silero VAD, faster-whisper, Piper, Model Context Protocol, Ollama, Axum e Tokio.

== Pro e contro
=== Pro
- Elevato valore formativo e tecnologie innovative (Rust, MCP, AI locale).

=== Contro
- Ambito estremamente ampio, che copre l'intero stack: hardware, firmware real-time, audio, backend asincrono, web.
- Rischio tecnico e organizzativo troppo alto rispetto alle ore a disposizione.

== Conclusioni
Il gruppo preferisce non procedere alla candidatura per questo capitolato a causa dell'eccessivo rischio tecnico legato all'hardware.

= C4 - Piattaforma per veicoli e servizi post-vendita (M31 S.r.l)
== Descrizione
M31 S.r.l. propone una piattaforma software distribuita per la gestione dei veicoli e dei servizi post-vendita nel settore automotive, mettendo in comunicazione casa madre, concessionarie e proprietari.

== Obiettivo
Centralizzare le informazioni su modelli e veicoli, migliorare il flusso di lavoro e offrire un unico punto di accesso per i proprietari.

== Tecnologie richieste
Node.js e Nest.js con TypeScript, Go, NATS, Kubernetes, PostgreSQL, MongoDB, Redis, Angular, architettura a microservizi.

== Pro e contro
=== Pro
- Dominio concreto e formativo su sistemi distribuiti ed event-driven.
=== Contro
- Requisiti non specificati e architettura a microservizi complessa per il gruppo.

== Conclusioni
Il gruppo preferisce non procedere alla candidatura per questo capitolato.

= C5 - RareCare Navigator (Miriade)
== Descrizione
Miriade S.r.l. propone RareCare Navigator, una piattaforma digitale con assistente virtuale basato su AI a supporto della gestione di malattie rare e complesse, a partire dalla Sindrome di Sanfilippo.

== Obiettivo
Permessi e ruoli (RBAC), workflow e notifiche per scadenze, chatbot RAG basato su fonti ufficiali verificate.

== Tecnologie richieste
Flutter o React Native per il frontend e architettura serverless su AWS con Amazon Bedrock o OpenAI.

== Pro e contro
=== Pro
- Forte valore sociale e formativo.
- Supporto molto strutturato da parte dell'azienda.
=== Contro
- Perimetro molto ampio e tecnologie nuove per il gruppo (serverless AWS, Bedrock, Flutter).

== Conclusioni
C5 rimane tra le alternative del gruppo, pur presentando un profilo di rischio più elevato rispetto a C6.

= C6 - Sistema AI di caching semantico e dashboard FinOps (Var Group)
== Descrizione
Var Group utilizza LiteLLM, un proxy open source compatibile con le API di OpenAI, per gestire il routing fra più provider. I limiti riscontrati riguardano la cache basata solo su hash, l'assenza di dashboard FinOps nativa e di forecast della spesa.

== Obiettivo
Estendere LiteLLM con due componenti originali:
- Cache semantica: livello di cache basato su embedding e ricerca per similarità.
- Dashboard FinOps: servizio separato che aggrega i consumi per team, progetto e utente, calcola il risparmio e produce forecast.

== Tecnologie richieste
Python, LiteLLM, FastAPI o Flask, Docker, Redis, Qdrant o pgvector, PostgreSQL, React con Chart.js o Streamlit.

== Motivazione della scelta
Il gruppo ha scelto C6 come prima scelta per i seguenti motivi:
- Tema attuale e rilevante, con risultati misurabili in token e costi risparmiati.
- Perimetro ben definito su un proxy esistente, senza hardware.
- Criteri di qualità chiari e supporto strutturato da parte di Var Group.
- Competenze di partenza solide (Python, Docker, SQL, Git).

== Conclusioni
Il gruppo si candida ufficialmente per lo sviluppo del capitolato C6.

= C7 - SmartDashboard (Ergon Informatica)
== Descrizione
Ergon Informatica S.r.l. propone SmartDashboard, una piattaforma di Business Intelligence end-to-end destinata alle aziende dei settori alimentare e dei trasporti, arricchita con intelligenza artificiale.

== Obiettivo
Architettura a tre livelli (Raw Data Store, Data Warehouse con star schema, web app con costruttore di dashboard) e layer AI per la generazione di visualizzazioni da linguaggio naturale.

== Tecnologie richieste
DuckDB, PostgreSQL, Python (Polars/Pandas), LLM tramite API commerciale, React/Angular/Vue.

== Pro e contro
=== Pro
- Percorso completo e formativo del dato.
- Supporto concreto con dataset di prova e chiavi API.
=== Contro
- Perimetro molto ampio e complessità nel garantire l'affidabilità del layer AI.

== Conclusioni
C7 costituisce la seconda scelta del gruppo.

= C8 - Sonar (Halue)
== Descrizione
Halue S.r.l. propone Sonar, un'applicazione web che si collega a uno store Shopify per ricostruirne la mappa delle dipendenze e identificare componenti non più utilizzati.

== Obiettivo
Scansione durevole, normalizzazione in un grafo di dipendenze, analisi statica del codice Liquid, motore di regole e interfaccia di navigazione.

== Tecnologie richieste
Next.js, Vercel Workflows, Supabase (PostgreSQL), TypeScript, Shopify Admin GraphQL API.

== Conclusioni
Il gruppo non procede alla candidatura a causa dello stack vincolante e specifico.

= C9 - SpecCheck (Zucchetti)
== Descrizione
Zucchetti S.p.A. propone di sviluppare SpecCheck, un insieme coordinato di skill, comandi, tool e plugin per OpenCode per verificare la tracciabilità casi d'uso -> requisiti -> codice.

== Obiettivo
Leggere diagrammi, specifiche e codice per verificarne la corrispondenza e segnalare discrepanze.

== Tecnologie richieste
OpenCode, skill e plugin personalizzati, Mermaid o XMI, Markdown.

== Conclusioni
Il gruppo non procede alla candidatura a causa dell'esito fortemente esplorativo e della mancanza di criteri di accettazione misurabili.

= Appendice A - Contesto e vincoli del gruppo
- *Composizione:* sette persone (Matteo Arcandi, Jacopo De Donà, Jacopo Franco, Matteo Marcon, Riccardo Peresson, Paolo Prevedello Ramirez, Chiara Protopapa).
- *Impegno:* ore produttive a persona entro l'intervallo 80-95 previsto dal Regolamento.
- *Calendario:* circa 20 settimane dall'aggiudicazione del 3 novembre 2026.
- *Costo:* preventivo non inferiore a 12.000 €.
- *Revisioni:* RTB e PB.

= Appendice B - Incontri esplorativi
#table(
  columns: (1fr, 1.2fr, 1.1fr, 2.2fr),
  inset: 7pt,
  align: (col, row) => if row == 0 { center + horizon } else { left + horizon },
  fill: (x, y) => if y == 0 { colore-primario } else if calc.even(y) { colore-sfondo } else { none },
  stroke: 0.5pt + colore-bordo,
  [*#text(fill: white)[Capitolato]*], [*#text(fill: white)[Proponente]*], [*#text(fill: white)[Data]*], [*#text(fill: white)[Partecipanti]*],
  [C7 SmartDashboard], [Ergon Informatica], [22/10/2026], [Gianluca Carlesso; Paolo Prevedello Ramirez, Chiara Protopapa, Jacopo Franco],
  [C1 AURA], [Vimar], [22/10/2026], [Mariano Sciacco, Domenico Bevilacqua; Jacopo De Donà, Matteo Marcon],
  [C6 Caching semantico e FinOps], [Var Group], [26/10/2026], [Dindo, Ferretti, Borgheresi, Massaro; quattro componenti del gruppo],
  [C5 RareCare Navigator], [Miriade], [26/10/2026], [Emanuele Righetto; componenti del gruppo]
)