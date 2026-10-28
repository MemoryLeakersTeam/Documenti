#import "../../Templates/DocumentiGenerici.typ": documento

#show: documento.with(
  titolo: "Analisi dei Capitolati",
  sottotitolo: "Valutazione e scelta dei capitolati d'appalto per l'A.A. 2026/2027",
  gruppo: "Memory Leakers",
  tipo-documento: "Analisi dei Capitolati",
  versione: "0.0.1",
  autore: "Matteo Arcandi",
  verificatore: "",
  stato: "Bozza",
  data: datetime(year: 2026, month: 10, day: 28),
  file-nome: "analisi-dei-capitolati.pdf",
  registro-modifiche: (
    "0.0.1", "28/10/2026", "Stesura iniziale del documento di analisi dei capitolati.", "Matteo Arcandi", "",
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

#strong[Fonti.] Ogni valutazione si basa sulla documentazione fornita da ogni proponente e sulle slide presentate in aula il 13/10/2026; per i capitolati C1, C5, C6 e C7 si aggiungono, inoltre, gli incontri esplorativi con le aziende (Appendice B), di cui sono riportati gli esiti.

#strong[Criteri di valutazione.] Il gruppo ha considerato: rischio tecnico e fattibilità nelle ore a disposizione, chiarezza dei requisiti e dei criteri di accettazione, supporto offerto dal proponente, interesse del gruppo e competenze di partenza, valore formativo, allineamento con i criteri del corso (documentazione, verifica, tracciabilità).

#strong[Esito.] Il gruppo si candida al capitolato C6 (Var Group); in caso di mancata aggiudicazione indica come seconda scelta C7 (Ergon) e come alternative C1 (Vimar) e C5 (Miriade). Gli altri capitolati non sono stati selezionati per le ragioni riportate nelle rispettive conclusioni.

= Riepilogo

#table(
  columns: (1.2fr, 1.3fr, 0.8fr, 2.3fr),
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
  [C9 SpecCheck], [Zucchetti], [no], [Non selezionato: esito incerto, nessun criterio di accettazione],
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

Il proponente consiglia:
- Java con Spring Boot (pipeline modulare a eventi);
- LangChain4j per l'interpretazione con LLM;
- Whisper, Google Speech, Tesseract o EasyOCR per speech-to-text e OCR;
- SQLite, MariaDB o PostgreSQL per i dati;
- Angular con TypeScript per l'interfaccia amministrativa;
- configurazione esterna in JSON o YAML.

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

Il gruppo preferisce non procedere alla candidatura per questo capitolato. L'assenza di criteri di accettazione misurabili e dei dati necessari alla parte più critica rende difficile dimostrare in modo oggettivo il valore di un MVP, e l'ampiezza tecnica (audio, immagini, testo e integrazione con i gestionali) richiede un carico elevato rispetto alle ore a disposizione. La valutazione si basa sull'analisi autonoma del capitolato e sulla presentazione svolta in aula: non è stato svolto un incontro con l'azienda.

= C1 - AURA (Vimar)

== Descrizione

Vimar S.p.A. vuole mostrare come i servizi di AI generativa esistenti (Claude, ChatGPT, Gemini, Copilot) possano essere usati come interfaccia in linguaggio naturale per gli impianti domotici residenziali Vimar View Wireless, senza sviluppare un assistente dedicato. L'impianto consiste in una rete Bluetooth Mesh collegata al cloud Vimar tramite un gateway BLE. L'accesso programmatico passa dalle KNX IoT 3rd-party API, un'interfaccia REST in cui un ambiente (#emph[Location]) contiene funzionalità (#emph[Function]) i cui attributi sono i #emph[Datapoint]. Il progetto rende queste API utilizzabili da un modello linguistico attraverso il Model Context Protocol (MCP): un server espone risorse e strumenti, un client permette al modello di scoprirli e usarli.

== Obiettivo

Il capitolato richiede tre componenti obbligatori:

- #strong[Infrastruttura cloud-ready:] container, Infrastructure as Code, avvio con un solo comando (docker compose up); compatibilità con AWS, mentre il rilascio su AWS è opzionale.
- #strong[Server e client MCP:] il server supporta le API KNX IoT (Authorization, Datapoint, Function, Information, Location, Subscription, Timeseries), in lettura e scrittura, con autenticazione OAuth2 e ricostruzione delle relazioni tra ambienti, funzionalità e datapoint; il client si interfaccia solo con il server realizzato.
- Agente o modello AI esterno commerciale, con autenticazione dell'utente tramite account MyVimar, scelta e memorizzazione dell'impianto nella conversazione, lettura e modifica dello stato dei dispositivi.
I casi d'uso previsti sono 17 casi base (accesso, elenco impianti, lettura e comando di luci e tapparelle, comandi su più dispositivi) e 21 casi avanzati (richieste ambigue, sinonimi, richieste implicite come «è buio», conferma per comandi estesi, elementi non trovati). Sono #emph[nice-to-have] gli scenari multi-impianto, i comandi condizionali, lo storico e i trigger. La copertura dei test deve essere almeno del 75% su unità e integrazione, mentre almeno dell'80% sui test end-to-end. Sono previsti due incontri in presenza a Padova e due dimostrazioni al reparto R&D.

== Tecnologie richieste

- #strong[Vincolanti:] Docker con docker-compose, KNX IoT 3rd-party API, OAuth2, repository Git pubblico con licenza open source.
- #strong[Suggerite:] Python con l'SDK FastMCP (alternative TypeScript o Java), AWS Lightsail o EC2, database relazionali o Redis, CI con GitHub Actions, Terraform, AWS CDK o Ansible.
- #strong[Hardware:] kit fisico portatile (gateway BLE, attuatori, comando tapparelle, sensori, termostato) fornito dall'azienda.

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

- #strong[Priorità:] requisiti e priorità li definisce il gruppo; il minimo atteso è un server MCP funzionante su due o tre casi base; un nice-to-have è preferibile a un opzionale.
- #strong[Richieste degli utenti:] l'LLM deve gestire varianti, sinonimi e richieste ambigue; i casi del capitolato non sono esaustivi e nuovi casi sono graditi.
- #strong[Sicurezza:] nessuna protezione specifica lato API per l'uso con un LLM; per le scritture estese (ad esempio «spegni tutto») si può prevedere la conferma; ogni utente vede solo i propri impianti e il servizio AI non vede mai i token.
- #strong[Un solo kit:] si comanda via cloud; un membro del gruppo lo tiene acceso e gli altri lavorano da remoto; sono disponibili un account amministratore con utenti extra, un mock e una demo online; la validazione finale va fatta sul kit.
- #strong[Polling:] per questo progetto è accettabile; i trigger via webhook sono da esplorare.
- #strong[Architettura:] nessun vincolo sul linguaggio (Python con FastMCP consigliato); serve un server MCP remoto con URL pubblico e autenticazione, mentre in consegna basta il funzionamento locale con Docker; per unità e integrazione l'AI si può simulare con mock, tenendo il modello reale fuori dalla CI; sconsigliato l'LLM locale.

== Conclusioni

C1 è il capitolato con i criteri di completamento più definiti, un supporto molto strutturato e un risvolto pratico concreto. Il gruppo lo mantiene tra le alternative: le tecnologie sono quasi tutte nuove, la soluzione è quasi interamente back-end, il dominio soddisfa parzialmente gli interessi del gruppo, tuttavia il capitolato C6 tratta un tema maggiormente in linea con le preferenze espresse dal gruppo, mantenendo un perimetro altrettanto chiaro.

= C2 - NEXUM Concierge (Eggon)

== Descrizione

Eggon S.r.l. sviluppa NEXUM, una piattaforma di comunicazione aziendale e servizi HR composta da un backoffice amministrativo e da una PWA per il personale. Il progetto introduce nella PWA un assistente conversazionale (Concierge) che permette di trovare informazioni, comprendere procedure e accedere ai servizi in linguaggio naturale, collegando la conoscenza aziendale alle funzioni operative della piattaforma. L'MVP è limitato all'area ferie e permessi; combina quattro capacità: regolamenti aziendali caricati dal backoffice, manuali di NEXUM, lettura dei dati personali e registrazione delle richieste con riepilogo e conferma esplicita.

== Obiettivo

Il capitolato richiede in un'unica soluzione:

- una chat testuale con gestione del contesto del dialogo;
- un backoffice per caricare, sostituire e ritirare le fonti (PDF testuali), con stato di elaborazione;
- una knowledge base con risposte che citano le fonti e astensione quando le fonti non bastano o si contraddicono;
- abilità di lettura dei dati personali e di registrazione delle richieste;
- autorizzazioni verificate dai servizi, gestione degli errori e degli invii ripetuti, tracciabilità di fonti ed esiti.
Il capitolato definisce 16 requisiti di business (RB-01…RB-16) con criteri di accettazione dettagliati. Non sono richiesti marketplace di plugin, memoria fra conversazioni, voce o allegati.

== Tecnologie richieste

Stack NEXUM:
- Angular con PrimeNG (backoffice);
- Angular con Tailwind CSS (PWA);
- Ruby on Rails per le API condivise;
- OAuth2 e JWT;
- PostgreSQL;
- Redis;
- AWS S3;
- Sidekiq.

Lo stack AI e i modelli sono da concordare dopo l'aggiudicazione; l'MVP può essere dimostrato in un ambiente autonomo con servizi di prova o simulatori conformi a un contratto d'integrazione.

== Pro e contro

=== Pro

- Requisiti di business numerati e criteri di accettazione molto specifici; perimetro funzionale definito (ferie e permessi).
- Gruppo di comunicazione dedicato con l'azienda, referente disponibile e percorso strutturato, vicino a un contesto di lavoro reale.
- Regole di sicurezza e tracciabilità chiare.

=== Contro

- Perimetro ampio e obiettivi che richiedono un'analisi dei requisiti molto accurata per scomporli in attività gestibili.
- Stack AI e modelli da concordare solo dopo l'aggiudicazione; soglie quantitative (accuratezza, tempi, costi) rinviate a una definizione successiva.
- Dipendenza da un contratto di integrazione ancora da stabilire; molte regole da progettare (astensione, conferme, idempotenza).
- Tecnologie poco note al gruppo (Ruby on Rails) e dominio HR di limitato interesse.

== Conclusioni

Il gruppo preferisce non procedere alla candidatura per questo capitolato: il perimetro è ampio e richiede un'analisi dei requisiti molto accurata per essere scomposto in attività gestibili, le scelte sullo stack AI sono rinviate a dopo l'aggiudicazione, lo stack di sviluppo è poco noto al gruppo e il dominio ha suscitato limitato interesse; inoltre la componente RAG è presente anche in C5, che offre più supporto sul dominio. La valutazione si basa solo sui documenti forniti dalla proponente dato che non è stato svolto alcun incontro con l'azienda.

= C3 - FossDot (Uranion)

== Descrizione

Uranion EMEA Ltd propone FossDot, uno smart speaker open source, estensibile e rispettoso della privacy, pensato come alternativa self-hosted ad Amazon Echo o Google Nest. Gli smart speaker commerciali sono dispositivi chiusi, legati al cloud del produttore e a un solo assistente, con privacy opaca e obsolescenza programmata. In FossDot il proprietario mantiene il controllo sui dati, sceglie liberamente il provider AI (modelli locali o cloud), collega servizi esterni tramite MCP e abilita Skills e Agents, mentre più dispositivi cooperano in casa.

== Obiettivo

Il capitolato richiede quattro componenti:

- scelta e validazione dell'hardware di riferimento (cinque combinazioni proposte e fornite da Uranion), con distinta base e prototipo racchiudibile in un contenitore;
- firmware embedded (Rust preferenziale) per cattura audio, wake word, streaming e riproduzione;
- servizio di bridging STT → LLM → TTS con astrazione sul provider e client MCP;
- interfaccia web per registrare e gestire più dispositivi.
L'MVP richiede il flusso «wake word, domanda, risposta vocale» su un dispositivo fisico. La consegna completa aggiunge più provider (anche locali con Ollama), MCP, Skills e Agents, multi-dispositivo, aggiornamenti OTA e hardening. Copertura dei test almeno dell'80% per le componenti software, da concordare per il firmware.

== Tecnologie richieste

Non è imposto uno stack; è richiesto il rilascio con licenza permissiva (Apache 2.0 o MIT). Riferimenti suggeriti:
- Rust embedded ed Embassy;
- Raspberry Pi o microcontrollori ESP32;
- Seeed ReSpeaker;
- openWakeWord;
- Silero VAD;
- faster-whisper;
- Piper;
- Model Context Protocol;
- Ollama;
- Axum e Tokio;
- containerizzazione e CI/CD incoraggiate.

== Pro e contro

=== Pro

- Elevato valore formativo e tecnologie innovative (Rust, MCP, AI locale).
- Referenti dedicati, momenti di approfondimento tecnico e comunicazione chiara.

=== Contro

- Ambito estremamente ampio, che copre l'intero stack: hardware, firmware real-time, audio, backend asincrono, web.
- Competenze molto eterogenee e in gran parte nuove per il gruppo.
- Reperimento, assemblaggio e calibrazione dell'hardware, con possibili ritardi nelle consegne.
- Latenza della catena vocale e collaudo del firmware difficili da pianificare nelle ore disponibili.

== Conclusioni

Il gruppo preferisce non procedere alla candidatura per questo capitolato: pur riconoscendone il valore, l'ampiezza e la varietà delle competenze richieste, dall'hardware al backend, e la gestione dell'hardware fisico comportano un rischio tecnico e organizzativo troppo alto rispetto al totale delle ore e al calendario.

= C5 - RareCare Navigator (Miriade)

== Descrizione

Miriade S.r.l. propone RareCare Navigator, una piattaforma digitale con assistente virtuale basato su AI a supporto della gestione di malattie rare e complesse, a partire dalla Sindrome di Sanfilippo. Oggi la rete di cura (centri clinici, pediatrici, terapisti, scuola, servizi sociali) non è coordinata e il carico organizzativo ricade sulla famiglia. Il progetto affianca la figura del Care Navigator (case manager) con un assistente AI, checklist e timeline di cura, un'area di coordinamento con permessi granulari e un fascicolo digitale cifrato. Il prototipo sarà validato con l'associazione Sanfilippo Fighters.

== Obiettivo

Il capitolato elenca diciotto requisiti (R1-R18):

- #strong[obbligatori:] permessi e ruoli (RBAC), workflow e notifiche per scadenze (invalidità, PAI/PEI) via push ed email, chatbot RAG basato solo su fonti ufficiali verificate;
- #strong[opzionali:] assistente vocale, mappatura geospaziale, analisi predittiva dei bisogni;
- #strong[sicurezza e privacy:] conformità GDPR con TLS 1.3 e AES-256, autenticazione a più fattori e OAuth2;
- #strong[architettura e interfaccia:] cloud nativo e serverless, pattern a plugin per estendere ad altre patologie («Disease Pack», configurazione e non codice), accessibilità WCAG 2.1 AA, frontend cross-platform;
- #strong[servizi AI:] RAG con risposte verificate, estrazione di entità cliniche da testo e voce, checklist dinamiche da PAI/PEI.

== Tecnologie richieste

Il capitolato raccomanda:
- Flutter o React Native per il frontend;
- un'architettura serverless su AWS (Lambda, API Gateway) con Amazon Bedrock, oppure OpenAI o modelli open source.

L'allegato tecnico, non vincolante, propone:
- Cognito (identità e MFA);
- Amazon Verified Permissions;
- Step Functions ed EventBridge;
- Bedrock Knowledge Bases e Guardrails;
- Aurora Serverless con pgvector;
- S3, SNS e SES, in regione UE.

L'allegato segnala anche le criticità: la cifratura end-to-end in senso stretto è incompatibile con le funzioni AI lato server, l'RBAC da solo non basta, le «allucinazioni» vanno ridotte e misurate con un dataset di valutazione, i dati estratti non vanno scritti senza conferma umana, e servono una DPIA e attenzione a AI Act e dispositivi medici.

== Pro e contro

=== Pro

- Forte valore sociale e formativo: AI generativa applicata a un caso reale.
- Supporto molto strutturato: competenze su cloud, AI, UX e dominio clinico, formazione iniziale e possibilità di affiancare una figura specializzata.
- Perimetro negoziabile con il gruppo, requisiti numerati, architettura di riferimento e indicazioni sui flussi dati; una persona del design system può aiutare all'inizio inerentemente a struttura e bozza grafica.

=== Contro

- Perimetro molto ampio per il tempo a disposizione: RBAC con relazioni, RAG con astensione, notifiche, fascicolo digitale, app cross-platform.
- Tecnologie quasi tutte nuove per il gruppo (serverless AWS, Bedrock, Flutter): serve tempo di apprendimento.
- Dati sanitari di minori: GDPR e DPIA, attenzione alla WCAG 2.1 AA, rischio nelle risposte errate dell'AI.
- Nessuna soglia di test né dataset di valutazione: va costruito e fatto validare dall'azienda in collaborazione con l'associazione.
- Account AWS sandbox non ancora garantito, con permessi iniziali limitati; la proprietà del codice a fine progetto è di norma di Miriade (da discutere).

== Conclusioni

C5 offre uno dei supporti più ricchi tra i capitolati e un tema di forte valore sociale, ma richiede di costruire quasi da zero un prodotto completo con molte tecnologie nuove, vincoli stringenti su privacy e accessibilità e un dataset di valutazione da creare. Il perimetro è negoziabile, ma il gruppo ritiene più rischiosa la scelta di questo capitolato in rapporto alle ore disponibili rispetto a C6 e C7. Rimane tra le alternative.

= C6 - Sistema AI di caching semantico e dashboard FinOps (Var Group)

== Descrizione

Var Group usa un'architettura AI a due livelli. Il primo aggrega modelli pubblici (Claude Enterprise, GPT, ricerca web) per attività che non toccano dati riservati. Il secondo, privato su AWS, ospita modelli proprietari, agenti e connettori verso ERP, CRM, SharePoint e Atlassian, con dati classificati su tre livelli di sensibilità (Gold, Silver, Bronze). Un orchestratore AI riceve ogni richiesta, da un processo automatico o da un'interfaccia conversazionale, e la instrada in base all'identità dell'utente e alla natura del dato.

L'instradamento è affidato a LiteLLM, un proxy open source compatibile con le API di OpenAI, già in produzione presso Var Group: gestisce il routing fra più provider, le chiavi e le credenziali. I limiti riscontrati dall'azienda sono:

- cache solo esatta (basata su hash): due domande equivalenti ma formulate in modo diverso generano due chiamate, raddoppiando i costi;
- nessuna dashboard FinOps nativa né visibilità aggregata sui costi;
- nessuna previsione (forecast) della spesa;
- multi-tenancy limitata, con difficoltà a isolare i costi per team e progetto.

== Obiettivo

Estendere LiteLLM con due componenti originali:

- #strong[Cache semantica:] livello di cache basato su embedding e ricerca per similarità, che riconosce le query semanticamente simili e restituisce la risposta già calcolata, se presente. Prevede soglia di similarità configurabile, invalidazione con TTL e versioning, persistenza su Redis o database vettoriale, registrazione di token e latenza risparmiati.
- #strong[Dashboard FinOps:] servizio separato che aggrega i consumi per team, progetto e utente, calcola il risparmio reale generato dalla cache, gestisce budget e alert, produce il forecast mensile della spesa, con aggiornamento quasi in tempo reale, multi-tenancy e isolamento dei dati per team e progetto.
#strong[Vincoli e criteri:] LiteLLM è la base e non va reinventato; copertura dei test almeno del 70% del codice prodotto, con separazione fra test deterministici e valutazione probabilistica; PoC di fattibilità prima dell'implementazione e stand-up periodici.

#strong[Prodotti attesi:] architettura e Architecture Decision Records, requisiti di business, diagrammi UML, MVP funzionante end-to-end, test con report di copertura e documentazione.

== Tecnologie richieste

- #strong[Backend e proxy:] Python, LiteLLM, FastAPI o Flask, Docker.
- #strong[Embedding e similarità:] OpenAI text-embedding-3-small o sentence-transformers (open source); similarità del coseno (numpy, scikit-learn).
- #strong[Cache e vector store:] Redis (cache con TTL), Qdrant o pgvector, PostgreSQL per le metriche FinOps.
- #strong[Dashboard:] React con Chart.js, oppure Streamlit come alternativa rapida; API REST in JSON.
- #strong[Versionamento:] Git su GitHub o Bitbucket.

== Motivazione della scelta

Il gruppo ha scelto C6 come prima scelta per i seguenti motivi.

- #strong[Tema attuale e rilevante.] Rendere sostenibile l'AI monitorandone i costi è un problema reale, comune a molti altri progetti, e il risultato è misurabile in token e costi risparmiati, latenza e accuratezza della cache. L'MVP si può validare numericamente e dà contenuto concreto al Piano di Qualifica.
- #strong[Perimetro ben definito.] Due componenti su un proxy esistente, senza hardware e senza necessità di gestire i dati sensibili, essendo già in ambiente a basso rischio; durante l'incontro del 26/10 il perimetro è stato ulteriormente definito e sono state delineate le priorità previste.
- #strong[Criteri di qualità chiari.] La soglia di copertura (70%) è esplicita e raggiungibile, e la distinzione fra test deterministici e valutazione probabilistica è un tema formativo importante.
- #strong[Supporto strutturato.] Design thinking, formazioni mirate su LiteLLM (2 ore), Embedding e Caching (2 ore) e FinOps con dashboard (1,5 ore), revisioni e incontri ogni due settimane.
- #strong[Competenze di partenza.] Python, Docker, SQL e Git sono già noti al gruppo e alcuni componenti conoscono le API REST: le tecnologie sono in buona parte note, diversamente da altri capitolati.
- #strong[Fattibilità.] Un PoC per la RTB (cache semantica minimale e aggregazione dei costi) e un MVP validabile nei tempi del progetto sono realistici.
=== Rischi e punti aperti

- #strong[Funzioni già presenti in LiteLLM.] Le versioni recenti includono già una cache semantica di base (Redis, Qdrant) e il tracciamento della spesa con budget per team e chiave; non sono previsti forecast. Il valore originale di C6 sta quindi nel potenziare cache e valutazione, nel calcolare il risparmio e il costo complessivo di esercizio, nella storia delle appartenenze ai team, nella previsione di spesa e nella dashboard: va definito con precisione nell'analisi dei requisiti.
- #strong[Cache condivisa.] Var Group desidera una cache unica per tutti: richiede di modificare l'isolamento di default e di valutare le implicazioni sui dati riservati.
- #strong[Falsi hit.] Una risposta sbagliata a una domanda simile ma non equivalente: serve calibrare la soglia con un dataset di coppie di domande.
- #strong[Versione.] Tra la versione in produzione (1.91.2) e quella più recente c'è un divario da considerare.
- Costi API per sviluppo e test di embedding e modelli, mitigati dall'ambiente con budget fornito da Var Group.

== Conclusioni

Il gruppo si candida ufficialmente per lo sviluppo del capitolato C6: il tema è attuale, il problema reale e misurabile, il perimetro è chiaro dopo l'incontro con Var Group, le tecnologie sono in buona parte note e il supporto del proponente è strutturato. Il valore del progetto sta nel portare cache semantica e FinOps di LiteLLM al livello richiesto, partendo da ciò che LiteLLM già offre. Il gruppo è motivato e ritiene realizzabile il lavoro nei tempi e con i vincoli del progetto.

= C7 - SmartDashboard (Ergon Informatica)

== Descrizione

Ergon Informatica S.r.l. propone SmartDashboard, una piattaforma di Business Intelligence end-to-end destinata alle aziende dei settori alimentare e dei trasporti. Nel gestionale ERP queste aziende accumulano dati preziosi (ordini, vendite, magazzino, consegne, marginalità) in una forma pensata per l'operatività e non per l'analisi: ogni nuovo report passa dal reparto IT e i numeri grezzi non spiegano il perché degli andamenti. La piattaforma recupera i dati dall'ERP, li consolida in un data warehouse ottimizzato per l'analisi ed espone una web app in cui l'utente costruisce in autonomia dashboard interattive. Ciò che la distingue da un comune strumento di reportistica è un livello di intelligenza artificiale con due finalità: abbattere la barriera tecnica, generando un grafico da una richiesta in linguaggio naturale, e arricchire l'analisi con l'interpretazione automatica dei dati (anomalie, tendenze, spiegazioni).

== Obiettivo

Il capitolato prevede un'architettura a tre livelli: un #emph[Raw Data Store] con copia storicizzata dei dati grezzi, un #emph[Data Warehouse] con ETL e modello dimensionale a star schema, e una web app con backend che espone i dati tramite API (senza rendere accessibili al frontend le interrogazioni dirette) e un costruttore di dashboard.

- #strong[Requisiti funzionali:] dashboard drag and drop su griglia reattiva con configurazioni per utente; libreria di widget (barre, linee, torta, KPI, gauge, tabelle, pivot, mappe); filtri trasversali; temi chiaro e scuro; esportazione in PDF ed Excel; autenticazione.
- #strong[Layer AI, in ordine di priorità:] generazione di visualizzazioni da linguaggio naturale (capacità centrale), insight automatici, assistente designer, spiegazione di un indicatore su richiesta (estensione). L'AI opera solo su dati e metadati esposti dalla piattaforma, con controlli di coerenza delle risposte.
- #strong[Fasi consigliate:] prima la BI funzionante, poi la generazione da linguaggio naturale, poi insight e assistente, infine la spiegazione. Il capitolato non fissa soglie numeriche di test.

== Tecnologie richieste

Le tecnologie sono suggerite e non vincolanti:
- #strong[Data warehouse:] DuckDB (alternative ClickHouse, MonetDB, Apache DataFusion); sorgente dati sostituibile come requisito desiderabile.
- #strong[Raw store e configurazioni:] PostgreSQL, MySQL o MariaDB.
- #strong[ETL:] Python con Polars o Pandas, eventualmente con orchestratori (Airflow, Prefect, Dagster); connettori ODBC o middleware JSON verso l'ERP.
- #strong[AI:] LLM tramite API commerciale (OpenAI, Anthropic); LangChain o Vanna.ai per la traduzione da linguaggio naturale a dati.
- #strong[Frontend:] React, Angular o Vue con ECharts o Chart.js, AG Grid per tabelle e pivot; comunicazione con il backend via API REST.

== Pro e contro

=== Pro

- Percorso completo e formativo del dato: ETL, modellazione dimensionale, API, frontend e AI su dati reali.
- Supporto concreto: dataset di test, chiavi API con credito, dati ERP, indicazioni su whitelist e test dell'LLM, allineamento ricorrente ogni quindici giorni.
- Fasi consigliate che permettono di avere una BI funzionante prima di aggiungere l'AI.
- Stack lasciato libero e ben suggerito; database e frontend già conosciuti dal gruppo.

=== Contro

- Perimetro molto ampio, con priorità da stabilire durante l'analisi dei requisiti per non superare le ore disponibili.
- Nessuna soglia numerica per i test.
- Affidabilità del layer AI difficile da garantire (join errati, doppi conteggi, ambiguità fra valori lordi e netti), con test da rieseguire a ogni cambio di modello.
- Struttura del layer AI complessa (analisi delle tabelle e generazione delle query); tecnologie in parte poco note al gruppo.
- Dati ERP statici nella fase iniziale: l'aggiornamento periodico resta da definire.

== Conclusioni

C7 offre un percorso completo e seguito, risposte concrete e materiali di prova forniti dall'azienda: risulta quindi la seconda scelta del gruppo. Restano un perimetro dei requisiti molto ampio da circoscrivere, la mancanza di soglie numeriche di test, la difficoltà di garantire l'affidabilità del layer AI e un tema di interesse medio per il gruppo.

= C8 - Sonar (Halue)

== Descrizione

Halue S.r.l. Società Benefit propone Sonar, un'applicazione web che si collega a uno store Shopify e ne ricostruisce la mappa: cosa esiste, cosa dipende da cosa e quali componenti non sono più utilizzati. Con il tempo gli store di grandi dimensioni si stratificano accumulando app installate e dimenticate, webhook verso fornitori non più attivi, campi personalizzati mai letti, script e funzioni di cui si è persa la traccia e codice di tema non più referenziato. Questa conoscenza non è documentata e si perde al cambio di fornitore o di personale, allungando i tempi di intervento e aumentando i rischi di incidenti in produzione.

== Obiettivo

Il capitolato richiede lo sviluppo di un sistema articolato su cinque capacità chiave:

- scansione durevole e rispettosa dei limiti di utilizzo delle Admin API, con snapshot immutabili e datati;
- normalizzazione in un grafo di dipendenze in cui ogni arco riporta fonte e livello di confidenza;
- analisi statica del codice Liquid del tema e misurazione dell'uso effettivo dei metafield;
- motore di regole estensibile (almeno otto regole) per orfani e codice morto;
- interfaccia di navigazione, confronto fra snapshot ed esportazione della documentazione in Markdown o HTML.
Sono definiti 20 requisiti funzionali obbligatori, 7 di qualità e sicurezza e 7 non funzionali. Soglie di accettazione: test superati almeno al 95%, falsi positivi ad alta severità al massimo del 10%, copertura almeno del 70%.

== Tecnologie richieste

Obbligatorie:
- Next.js (App Router) su Vercel;
- Vercel Workflows;
- Vercel Cron Jobs;
- Supabase (PostgreSQL) con Row Level Security;
- Supabase Auth con solo provider Google;
- TypeScript strict;
- Shopify Admin GraphQL API tramite custom app;
- Git e GitHub con CI.

Fortemente consigliate:
- Vercel Blob, Queues, Sandbox e AI Gateway;
- Drizzle o Prisma;
- Tailwind e shadcn/ui;
- React Flow o Cytoscape.js;
- Vitest;
- Playwright;
- MSW.

== Pro e contro

=== Pro

- Documentazione precisa e accurata: requisiti, metriche di qualità e criteri di accettazione definiti in modo oggettivo e misurabile; indicazioni utili sull'ambiente di lavoro e sulla flessibilità in caso di limiti dei piani gratuiti.
- Ottimi spunti di architettura (snapshot immutabili, workflow durevoli, confidenza esplicita) e politica chiara sull'uso dell'AI nello sviluppo.

=== Contro

- Stack imposto con tecnologie molto specifiche (Workflows durevoli, Row Level Security) e limiti dei piani gratuiti.
- Lo store Shopify di test non viene fornito e deve essere costruito dal gruppo per costituire l'ambiente di prova.
- Dominio specifico (Shopify) e supporto limitato a videocall bisettimanali ed e-mail, senza incontri in presenza.

== Conclusioni

Il gruppo preferisce non procedere alla candidatura per questo capitolato: ne apprezza la chiarezza, ma lo stack vincolante ed il perimetro già fissato lo rendono poco compatibile con le ore a disposizione, e il gruppo preferisce capitolati non legati a una particolare piattaforma di hosting o a un dominio specifico. La valutazione si basa solo sulla documentazione fornita.

= C9 - SpecCheck (Zucchetti)

== Descrizione

Zucchetti S.p.A. parte da una constatazione: con i Large Language Model il collo di bottiglia non è più scrivere codice ma verificarlo. Compilatori, linter e test dicono se il codice è corretto, non se rispetta l'intento che lo ha motivato. Il capitolato richiama il «vibe coding» (sviluppare descrivendo le intenzioni in linguaggio naturale) e spiega perché oggi contano gli harness, cioè i sistemi che gestiscono contesto e scelte di progetto (Claude Code, Codex, OpenCode e altri) tramite file guida come AGENTS.md. Gli harness si estendono con skill, comandi, tool e plugin.

Zucchetti, interessata a verificare l'estendibilità di OpenCode, propone di sviluppare SpecCheck: un insieme coordinato di skill, comandi, tool e almeno un plugin che, su un progetto software esterno, verifichi la tracciabilità casi d'uso -\> requisiti -\> codice. Il sistema verifica e non realizza.

== Obiettivo

Il capitolato richiede nove compiti obbligatori:

- leggere i diagrammi dei casi d'uso e la documentazione aggiuntiva;
- leggere le specifiche dei requisiti e confrontarle con i casi d'uso, segnalando le mancate corrispondenze;
- leggere il codice, capirne il comportamento e verificare che implementi quanto richiesto;
- mostrare in una dashboard (anche testuale) casi d'uso rilevati nei requisiti e requisiti rilevati nel codice, con le discrepanze ben visibili.
Il confronto non può essere affidato in modo deterministico a un LLM: va realizzato come plugin per OpenCode o applicativo esterno richiamato da skill e comandi. Il prodotto è un pacchetto unico con script di installazione (Bash o PowerShell). Sono opzionali la dashboard grafica, la copertura inversa del codice rispetto alle specifiche e la lettura da PDF.

== Tecnologie richieste

- #strong[Harness:] OpenCode, con skill, comandi, tool (script deterministici, ad esempio JavaScript/Node) e plugin.
- #strong[Formati:] diagrammi in Mermaid o XMI, specifiche in Markdown; PDF opzionale.
- #strong[Riferimenti suggeriti:] OpenSpec, Spec-kit, BMAD, PlantUML, UMLet.
- #strong[Modelli:] LLM di grandi dimensioni con tetto di costo, modelli piccoli (ad esempio Gemma 4 26B, Qwen 27B) senza limiti.
- #strong[Distribuzione:] repository pubblico (titolo preferenziale) e script di installazione.

== Pro e contro

=== Pro

- Tema vicino al corso: la tracciabilità tra casi d'uso, requisiti e codice è un argomento centrale dell'ingegneria del software.
- Argomento attuale (sviluppo assistito da AI) con strumenti open source e nessuna dipendenza hardware.
- Dashboard testuale accettata, quindi maggior possibilità di concentrarsi sulle funzionalità.
- Modelli piccoli senza limiti di utilizzo per le prove.

=== Contro

- Progetto fortemente esplorativo: l'esito dipende dalla capacità degli LLM di comprendere codice e specifiche, e il capitolato ammette che alcune parti potrebbero non essere definite con certezza.
- Nessuna soglia di accettazione né benchmark: non è definito come valutare una «verifica corretta», e il confronto semantico è probabilistico, con falsi positivi e negativi difficili da misurare.
- Manca un progetto di prova con discrepanze note, consigliato ma non fornito.
- Competenze nuove per il gruppo (estensione di OpenCode, analisi del codice, parsing di Mermaid e XMI).

== Conclusioni

Il gruppo riconosce l'interesse del tema e la sua pertinenza con il corso, ma preferisce non procedere alla candidatura: mancano criteri di accettazione misurabili, l'esito dipende in larga parte dagli LLM, per questo dimostrare un MVP convincente sarebbe più rischioso che in C6, dove il risultato si misura in numeri (token e costi risparmiati, latenza, accuratezza). La valutazione si basa solo sulla documentazione e sulle slide di presentazione: non è stato svolto un incontro con l'azienda.

= Appendice A - Contesto e vincoli del gruppo

- #strong[Composizione:] sette persone: Matteo Arcandi, Jacopo De Donà, Jacopo Franco, Matteo Marcon, Riccardo Peresson, Paolo Prevedello Ramirez, Chiara Protopapa.
- #strong[Impegno:] ore produttive a persona entro l'intervallo 80-95 previsto dal Regolamento, come indicato nella Dichiarazione degli Impegni.
- #strong[Calendario:] circa 20 settimane dall'aggiudicazione del 3 novembre 2026, con rallentamenti per la pausa natalizia e la sessione d'esame invernale; data di consegna come indicato nella Dichiarazione degli Impegni.
- #strong[Costo:] preventivo non inferiore a 12.000 €, il minimo previsto per un gruppo di sette persone.
- #strong[Revisioni:] RTB (requisiti e proof of concept) e PB (specifica tecnica e MVP validato dal proponente).

= Appendice B - Incontri esplorativi

#table(
  columns: (1.6fr, 1.1fr, 1.1fr, 2fr, 1.2fr),
  inset: 7pt,
  align: (col, row) => if row == 0 { center + horizon } else { left + horizon },
  fill: (x, y) => if y == 0 { colore-primario } else if calc.even(y) { colore-sfondo } else { none },
  stroke: 0.5pt + colore-bordo,
  [*#text(fill: white)[Capitolato]*], [*#text(fill: white)[Proponente]*], [*#text(fill: white)[Data]*], [*#text(fill: white)[Partecipanti]*], [*#text(fill: white)[Verbale]*],
  [C7 SmartDashboard], [Ergon Informatica], [22/10/2026, 15:30-15:50], [Gianluca Carlesso (Ergon); Paolo Prevedello Ramirez, Chiara Protopapa, Jacopo Franco], [Verbale esterno nel repository documentale],
  [C1 AURA], [Vimar], [22/10/2026, 16:00-17:00], [Mariano Sciacco e Domenico Bevilacqua (Vimar); Jacopo De Donà e Matteo Marcon], [Verbale esterno nel repository documentale],
  [C6 Caching semantico e FinOps], [Var Group], [26/10/2026, 15:00-15:40], [Dindo, Ferretti, Borgheresi, Massaro (Var Group); quattro componenti del gruppo], [Verbale esterno in preparazione],
  [C5 RareCare Navigator], [Miriade], [26/10/2026, 17:00-17:30], [Emanuele Righetto (Miriade); componenti del gruppo], [Verbale esterno nel repository documentale],
)

Per ogni incontro il gruppo ha raccolto le domande in modo asincrono in un documento condiviso e ha chiesto il permesso di registrare e trascrivere la riunione. I verbali, con decisioni e attività, sono pubblicati nel repository documentale.
