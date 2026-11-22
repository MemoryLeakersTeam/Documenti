#import "../../Templates/Verbali.typ": verbale

#let g(id, termine) = {
  show underline: it => it.body
  link("https://memoryleakersteam.github.io/glossario#" + id)[
    #set text(fill: black)
    #termine#sub[G]
  ]
}

#show: verbale.with(
  dati: yaml("2026-11-18-vargroup.yml"),
  titolo: "Verbale riunione esterna con Var Group del 2026-11-18",
  tipo-documento: "Verbale Esterno",
  azienda: "Var Group",
  data: datetime(year: 2026, month: 11, day: 18),
  ora: "14:00 - 17:00",
  luogo: "Sede Var Group (Via Salboro, Padova)",
  file-nome: "2026-11-18-vargroup.pdf",
  gruppo: "Memory Leakers",
  ordine-del-giorno: (
    [Design thinking],
  ),
  partecipanti: (
    "Laura Ferretti (Var Group)",
    "Alessio Borgheresi (Var Group)",
    "Michele Massaro (Var Group)",
    "Federico Pivetta (Var Group)",
    "Jacopo De Donà",
    "Jacopo Franco",
    "Matteo Marcon",
    "Riccardo Peresson",
    "Paolo Prevedello Ramirez",
    "Chiara Protopapa",
  ),
  distribuzione: (
    "Memory Leakers",
    "Var Group",
    "Prof. Riccardo Cardin",
    "Prof. Tullio Vardanega"
  ),
  ora-fine-riunione: "17:00",
  data-prossima-riunione: "2026-11-27",
  mostra-conclusioni-automatiche: true,
  firma-esterna: "",

  decisioni: (
    (
      [DE4],
      [Adottare una durata massima di permanenza in cache pari a 1 settimana per evitare risposte obsolete]
    ),
    (
      [DE5],
      [Contenere l'extra-latenza della cache semantica sotto i 500 ms rispetto al caching già presente, privilegiando il risparmio di costo]
    ),
    (
      [DE6],
      [Utilizzare un classificatore per individuare e filtrare le domande con dati sensibili]
    ),
    (
      [DE7],
      [Definire la riformulazione delle domande per le chat multi-turno perché l'ultima domanda può dipendere dal contesto precedente]
    ),
    (
      [DE8],
      [Definizione dei diagrammi di flusso per chat singole e multi-turno]
    ),
    (
      [DE9],
      [Organizzare incontri dedicati all'approfondimento delle tecnologie scelte]
    )
  ),
  attivita-todo: (
    (
      [AE2],
      [Diagramma di flusso],
      [Finalizzare i diagrammi di flusso e valutare le soluzioni di similarità per chat multi-turno],
      [Chiara Protopapa],
      [2026-11-25],
      [DE6, DE7, DE8],
      [#link("https://github.com/MemoryLeakersTeam/Documenti/issues/97")[\#97]],
    ),
    (
      [AE3],
      [Invio diagramma su Teams],
      [Condividere su Microsoft Teams il diagramma di flusso con Var Group],
      [Matteo Marcon],
      [2026-11-26],
      [DE8],
      [#link("https://github.com/MemoryLeakersTeam/Documenti/issues/98")[\#98]],
    ),
    (
      [AE4],
      [Scelta tecnologie],
      [Valutare le tecnologie da approfondire con la proponente],
      [Matteo Arcandi, Jacopo Franco, Paolo Prevedello Ramirez, Chiara Protopapa],
      [2026-11-24],
      [DE9],
      [#link("https://github.com/MemoryLeakersTeam/Documenti/issues/99")[\#99]],
    ),
  ),
)

= Introduzione
Il presente documento riporta quanto abbiamo discusso durante la sessione di design thinking in presenza con la proponente *Var Group S.p.A.*, tenutasi in data *2026-11-18* dalle ore *14:00* alle ore *17:00* presso la sede di Var Group a Padova.
L'incontro ha avuto l'obiettivo di comprendere al meglio i requisiti di progetto definendo le regole e il funzionamento della *#g("cache-semantica")[cache semantica]*, il perimetro di *#g("poc")[PoC]* ed *#g("mvp")[MVP]*.

= Resoconto

== Contesto e architettura base (LiteLLM)
Abbiamo analizzato il ruolo di *#g("litellm")[LiteLLM]* come orchestratore che espone un'API unificata per diversi modelli e provider.
L'azienda ci ha mostrato la dashboard già parzialmente disponibile, che espone i dati provenienti dai log, diversi raggruppamenti e filtri (per modello, utente, team o intervallo temporale) e le metriche di *#g("prompt-caching")[prompt caching]* non semantico.
Abbiamo inoltre concordato che lavoreremo in locale avviando il progetto recuperato da GitHub ed eseguendo i test tramite le API e le chiavi fornite da Var Group.

== Funzionamento della cache semantica e similarità
Abbiamo definito lo scopo della cache semantica, ovvero intercettare domande semanticamente equivalenti per ridurre i costi e misurare il miglioramento rispetto al caching già presente, mantenendo il legame tra domanda e risposta (o elemento salvato in cache).
Abbiamo stabilito che l'extra-latenza introdotta dalla cache semantica dovrà rimanere sotto i *500 ms* rispetto alla cache attuale, privilegiando il risparmio di costo rispetto al risparmio di tempo (pur rispettando il vincolo di latenza) e valutando il salvataggio in modo asincrono e non bloccante.
Per valutare la similarità tra domande abbiamo individuato l'uso di #g("modelli-di-embedding")[modelli di embedding] veloci ed economici.
Abbiamo infine fissato una permanenza massima in cache pari a *1 settimana* per evitare che le risposte diventino obsolete.

== Classificazione, sicurezza e permessi
Abbiamo condiviso il criterio generale di salvare in cache quanto più possibile compatibilmente con i vincoli di sicurezza e coerenza, escludendo le richieste che non è opportuno memorizzare.
In particolare, abbiamo stabilito di non salvare in cache domande legate a informazioni riservate o sensibili (ad esempio ambiti HR o documenti riservati) né richieste che prevedono l'uso di connettori o servizi esterni con login o autenticazione.
Abbiamo quindi deciso di adottare un #g("classificatore")[classificatore] (valutando soluzioni esistenti menzionate durante l'incontro, come il classificatore jev per filtrare le domande da inserire in cache, tenendo conto anche della relativa risposta.

== Conversazioni multi-turno e system prompt
Poiché nelle #g("conversazioni-multi-turno")[conversazioni multi-turno] l'ultima domanda può dipendere dal contesto precedente senza esplicitare l'argomento, abbiamo discusso la riformulazione dell'ultima domanda rispetto al contesto della conversazione. Questa rielaborazione dovrà dare enfasi all'ultima domanda e includere solo il contesto necessario, entro un numero di turni da calibrare verificando anche la lunghezza media delle chat su LiteLLM (indicativamente intorno a 10 turni come punto di partenza).
Abbiamo inoltre stabilito di escludere il *#g("system-prompt")[system prompt]* dalla domanda salvata in cache.

== Dashboard, perimetro PoC / MVP e funzionalità opzionali
Abbiamo suddiviso lo sviluppo del progetto tra *PoC* ed *MVP*:
Per la *PoC* abbiamo definito l'obiettivo di dimostrare che le funzionalità principali operano correttamente e che la cache semantica porta utilità (hit/miss, confronto con il caching esistente, classificatore, multi-turno), corredata da una visualizzazione iniziale dei dati.
Per l'*MVP* abbiamo previsto una dashboard più completa rivolta all'amministratore, dotata di filtri (modello, data, ecc.), grafici (hit/miss, consumi/token, confronto con la cache attuale e metriche aggiuntive) e della possibilità per l'admin di rimuovere elementi dalla cache.
Come funzionalità opzionali abbiamo individuato il *caching del #g("reasoning")[reasoning]* e l'aggiunta di *#g("guardrail")[guardrail]* di sicurezza o affinamenti sui filtri.

== Comunicazione e formazione
Abbiamo creato il gruppo su #g("microsoft-teams")[Microsoft Teams] per gestire le comunicazioni rapide. Infine, la proponente ci ha invitato a individuare le tecnologie che vorremmo approfondire così da organizzare incontri formativi dedicati.

= Decisioni e attività
Di seguito riportiamo le decisioni prese durante l'incontro e le relative attività individuate per darne seguito.