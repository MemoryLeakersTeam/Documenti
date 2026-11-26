#import "../../Templates/DocumentiGenerici.typ": *

// BOZZA (issue #106). Le parti segnate TODO sono da completare o da decidere.
// Le tabelle delle ore si calcolano dai CSV in dati/ore/ (radice del repo), scaricati dalla pagina /ore del sito:
// a ogni sprint si aggiunge il suo CSV e una voce in `sprint`.

#show: documento.with(
  titolo: "Piano di Progetto",
  sottotitolo: "Capitolato C6 - SCSDF",
  tipo-documento: "Documento Esterno",
  autore: "Jacopo Franco",
  file-nome: "piano-di-progetto.pdf",
  dati: yaml("piano-di-progetto.yml"),
)

#set heading(numbering: "1.1.1")

#let colore-primario = rgb("#305b57")
#let colore-sfondo = rgb("#eaf7f2")
#let colore-bordo = rgb("#49736a")

// Collegamento a una voce del glossario sul sito
#let g(id, termine) = gloss(url: "https://memoryleakersteam.github.io/glossario#" + id)[#termine]

// Tabella con intestazione colorata
#let tabella(colonne, intestazione, ..celle) = table(
  columns: colonne,
  inset: 7pt,
  stroke: 0.5pt + colore-bordo,
  align: (x, y) => if x == 0 { left + horizon } else { center + horizon },
  fill: (x, y) => if y == 0 { colore-primario } else if calc.even(y) { colore-sfondo } else { none },
  table.header(..intestazione.map(t => [*#text(fill: white)[#t]*])),
  ..celle,
)

// Scheda di un rischio: titolo con codice e nome, poi la tabella
#let scheda-rischio(r) = block(breakable: false)[
  === #r.codice - #r.nome
  #table(
    columns: (1fr, 3.5fr),
    inset: 7pt,
    fill: (x, y) => if x == 0 { colore-sfondo } else { none },
    stroke: 0.5pt + colore-bordo,
    [*Descrizione*], r.descrizione,
    [*Probabilità*], r.probabilita,
    [*Impatto*], r.impatto,
    [*Mitigazione*], r.mitigazione,
    [*Contingenza*], r.contingenza,
  )
]

// ---------------------------------------------------------------------------
// Dichiarazione degli impegni
// ---------------------------------------------------------------------------

// Ruoli con costo orario, nell'ordine usato in tutte le tabelle
#let ruoli = (
  (id: "responsabile", nome: "Responsabile", sigla: "Resp", tariffa: 30),
  (id: "amministratore", nome: "Amministratore", sigla: "Amm", tariffa: 20),
  (id: "analista", nome: "Analista", sigla: "Anal", tariffa: 25),
  (id: "progettista", nome: "Progettista", sigla: "Prog", tariffa: 25),
  (id: "programmatore", nome: "Programmatore", sigla: "Prgm", tariffa: 15),
  (id: "verificatore", nome: "Verificatore", sigla: "Verif", tariffa: 15),
)

// Ore preventivate per persona e ruolo, nello stesso ordine di `ruoli`
#let membri = (
  (login: "ttteo", nome: "Matteo Arcandi", preventivo: (9, 8, 11, 16, 26, 23)),
  (login: "jeidi19", nome: "Jacopo De Donà", preventivo: (8, 8, 12, 16, 26, 23)),
  (login: "JJ-jacopo24", nome: "Jacopo Franco", preventivo: (8, 8, 12, 16, 26, 23)),
  (login: "Matteomarcon", nome: "Matteo Marcon", preventivo: (9, 8, 11, 16, 26, 23)),
  (login: "Ric02P", nome: "Riccardo Peresson", preventivo: (8, 8, 12, 16, 26, 23)),
  (login: "paolopreve", nome: "Paolo Prevedello Ramirez", preventivo: (9, 8, 11, 16, 26, 23)),
  (login: "Kyara-Prot", nome: "Chiara Protopapa", preventivo: (9, 8, 11, 16, 26, 23)),
)

// Vista della bacheca del gruppo (GitHub Projects) filtrata per sprint
#let bacheca(nome) = "https://github.com/orgs/MemoryLeakersTeam/projects/2/views/1?filterQuery=sprint%3A%22" + nome.replace(" ", "+") + "%22"


// Ore di verifica preventivate per ogni ora stimata nelle issue (le issue non stimano la verifica)
#let rapporto-verifica = 0.6

// Ore di gestione dell'Amministratore per ogni issue dello sprint (apertura con la descrizione)
#let ore-per-issue = 0.3

// Ore di gestione del Responsabile per sprint (proponente, email, coordinamento del gruppo)
#let gestione-responsabile = 2

// Arrotonda alla mezz'ora più vicina, perché le ore si registrano solo a mezz'ore: 3.3 -> 3.5, 7.2 -> 7
#let mezz-ora(x) = calc.round(x * 2) / 2

// Collegamento a una issue: issue(62) -> "#62" (repository Documenti);
// issue(4, repo: "MemoryLeakersTeam.github.io") -> "sito #4" (repository del sito)
#let issue(n, repo: "Documenti") = link(
  "https://github.com/MemoryLeakersTeam/" + repo + "/issues/" + str(n),
  (if repo == "Documenti" { "" } else { "sito " }) + "#" + str(n),
)

// ---------------------------------------------------------------------------
// Sprint: una voce per sprint, con il CSV delle ore scaricato da /ore
// ---------------------------------------------------------------------------
#let sprint = (
  (
    codice: "S1", numero: 1, inizio: "2026-11-03", fine: "2026-11-16", stato: "Concluso",
    file: "../../dati/ore/ore-S1.csv",
    ruoli: (
      "Kyara-Prot": "Responsabile", "jeidi19": "Amministratore", "JJ-jacopo24": "Verificatore",
      "ttteo": "Analista", "Matteomarcon": "Analista", "Ric02P": "Analista", "paolopreve": "Analista",
    ),
    bacheca: "Sprint 1",
    obiettivo: [Organizzare il modo di lavorare del gruppo (Norme di Progetto, template, modelli delle issue, automazioni del registro delle modifiche), fissare le milestone fino alla RTB e avviare i contatti con il proponente.],
    attivita: (
      (issue: 53, titolo: [Verbale interno del 2026-11-03], stato: "Svolta"),
      (issue: 54, titolo: [Modifica dei template], stato: "Svolta"),
      (issue: 55, titolo: [Diario di bordo del 2026-11-09], stato: "Svolta"),
      (issue: 60, titolo: [Moduli delle issue per classe di attività, con campi obbligatori e checklist di verifica], stato: "Svolta", ruolo: "amministratore", ore: 1),
      (issue: 62, titolo: [Data della RTB e milestone intermedie, create su GitHub], stato: "Svolta", ruolo: "responsabile", ore: 2),
      (issue: 63, titolo: [Verbale interno del 2026-11-10], stato: "Svolta"),
      (issue: 64, titolo: [Diario di bordo del 2026-11-16], stato: "Svolta"),
      (issue: 65, titolo: [Versionamento automatico al merge: versione, stato, verificatore e registro delle modifiche nei file YAML], stato: "Svolta", ruolo: "amministratore", ore: 4),
      (issue: 66, titolo: [Rilascio avviato dal Responsabile: versione definitiva, stato «Approvato» e firma], stato: "Svolta", ruolo: "amministratore", ore: 2),
      (issue: 67, titolo: [Prima stesura delle Norme di Progetto, organizzate per processi], stato: "Svolta", ruolo: "amministratore", ore: 2),
      (issue: 73, titolo: [Migrazione del verbale interno del 2026-11-03 e correzione delle date], stato: "Svolta"),
      (issue: 1, repo: "MemoryLeakersTeam.github.io", titolo: [Sincronizzazione automatica dei documenti approvati dal repository Documenti], stato: "Svolta"),
      (issue: 4, repo: "MemoryLeakersTeam.github.io", titolo: [Registrazione delle ore produttive, con riepilogo per persona e per ruolo], stato: "Svolta", ruolo: "analista", ore: 1),
      (issue: 5, repo: "MemoryLeakersTeam.github.io", titolo: [Date nel formato AAAA-MM-GG], stato: "Svolta", ruolo: "analista", ore: 1),
      (issue: 7, repo: "MemoryLeakersTeam.github.io", titolo: [Documenti in revisione mantenuti all'ultima versione approvata], stato: "Svolta", ruolo: "amministratore", ore: 1),    
    ),
    rischi-attesi: ("RT1", "RO1", "RO2"),
    // TODO(gruppo): retrospettiva da confermare alla riunione del 2026-12-01
    retrospettiva: (
      bene: (
        [In un solo sprint il gruppo ha definito e automatizzato il proprio modo di lavorare: moduli delle issue, versionamento e rilascio automatici dei documenti, prima stesura delle Norme di Progetto (#issue(60), #issue(65), #issue(66), #issue(67)).],
        [La rendicontazione delle ore produttive è attiva dal primo sprint (#issue(4, repo: "MemoryLeakersTeam.github.io")), quindi preventivo e consuntivo si possono confrontare da subito.],
        [Le domande preparate in anticipo hanno reso utile l'incontro del 2026-11-13 con Var Group.],
      ),
      migliorare: (
        [*Stima delle ore.* Le issue aperte prima dei moduli non hanno una stima e le ore di verifica e di gestione non erano stimate, quindi il preventivo dello sprint è stato ricostruito a posteriori. Dallo sprint 2 ogni issue ha la sua stima all'inizio dello sprint.],
        [*Ore registrate senza issue.* 8,5 delle 11,5 ore registrate nello sprint non indicano l'issue a cui si riferiscono, quindi è servito ricostruire a mano su quali attività sono state spese. Chi registra le ore indica sempre l'issue.],
        [*Definition of Done e checklist di verifica.* Alcune issue sono state chiuse con la Definition of Done o la checklist di verifica non compilate (#issue(65), #issue(66)). Ogni issue si chiude solo con entrambe compilate e l'esito spuntato; se la verifica richiede 
        prima il merge della pull request, si compilano subito dopo il merge.],
        [*Divisione del lavoro.* Alcuni componenti non hanno ore produttive nello sprint, mentre le ore si sono concentrate su pochi ruoli. Il Responsabile distribuisce le attività in modo più equilibrato tra i componenti.],
        [*Template dei documenti.* Non usano ancora il formato AAAA-MM-GG e la tabella «Controllo Documentale» ridotta, decisi il 2026-11-10: l'Amministratore li aggiorna nello sprint 2.],
      ),
    ),
    rischi-occorsi: (
      (
        codice: "RO6",
        descrizione: [La risposta di Var Group alla prima mail del gruppo dopo l'aggiudicazione (verbale interno del 2026-11-03, A1) è arrivata in ritardo per un problema nell'invio programmato della loro email (diario di bordo del 2026-11-09). Con la risposta Var Group 
        ha proposto l'incontro conoscitivo del 2026-11-13, in cui si è fissata la sessione di #g("design-thinking", "design thinking") al 2026-11-18, poi confermata dal gruppo per email.],
        efficacia: [Il rischio non era ancora tra quelli individuati. Le domande preparate in anticipo hanno reso utile l'incontro del 2026-11-13; da questa esperienza nasce RO6, con il canale Microsoft Teams per le comunicazioni rapide.],
      ),
    ),
    nota: [Nello sprint si sono occupati della stesura dei verbali, che non è ora produttiva. Per l'Amministratore il gruppo ha riconosciuto 5 ore produttive, tenendo conto di tutto il lavoro svolto nello sprint.],
  ),
  (
    codice: "S2", numero: 2, inizio: "2026-11-17", fine: "2026-11-30", stato: "In corso",
    file: "../../dati/ore/ore-S2.csv",
    ruoli: (
      "Matteomarcon": "Responsabile", "Ric02P": "Amministratore", "jeidi19": "Verificatore",
      "Kyara-Prot": "Analista", "JJ-jacopo24": "Analista", "ttteo": "Analista", "paolopreve": "Analista",
    ),
    bacheca: "Sprint 2",
    rischi-attesi: ("RT1", "RO2", "RO3", "RO4", "RO6"),
    rischi-occorsi: (
      (
        codice: "RP2",
        descrizione: [Un componente non ha potuto partecipare alla sessione di #g("design-thinking", "design thinking") con Var Group del 2026-11-18 per impegni di lavoro (diario di bordo del 2026-11-23).],
        efficacia: [Il rischio non era tra quelli attesi per lo sprint. Gli appunti della sessione sono stati condivisi con tutto il gruppo, così chi era assente ha potuto recuperarne i contenuti.],
      ),
    ),
  ),
)

// ---------------------------------------------------------------------------
// Calcoli
// ---------------------------------------------------------------------------

// Righe del CSV di uno sprint, senza righe vuote
#let ore-di(s) = csv(s.file, row-type: dictionary).filter(r => r.at("ore", default: "") != "")

#let somma(righe) = righe.map(r => float(r.ore)).sum(default: 0.0)
#let ore-persona-ruolo(righe, login, ruolo) = somma(righe.filter(r => r.persona == login and lower(r.ruolo) == ruolo))
#let ore-ruolo(righe, ruolo) = somma(righe.filter(r => lower(r.ruolo) == ruolo))
#let ore-persona(righe, login) = somma(righe.filter(r => r.persona == login))
#let costo-ruolo(righe, r) = ore-ruolo(righe, r.id) * r.tariffa
#let costo(righe) = ruoli.map(r => costo-ruolo(righe, r)).sum()

// Tutte le ore registrate finora
#let tutte = sprint.map(ore-di).flatten()

#let preventivo-ruolo(i) = membri.map(m => m.preventivo.at(i)).sum()
#let preventivo-ore = membri.map(m => m.preventivo.sum()).sum()
#let preventivo-costo = ruoli.enumerate().map(((i, r)) => preventivo-ruolo(i) * r.tariffa).sum()

// Formati: 3.5 -> "3,5"; 12865 -> "12.865 €"; 7.5 -> "7,50 €"
#let num(x) = {
  let v = calc.round(x, digits: 1)
  if v == calc.trunc(v) { str(int(v)) } else { str(v).replace(".", ",") }
}
#let migliaia(n) = {
  let cifre = str(n).clusters()
  let out = ""
  for (i, c) in cifre.enumerate() {
    if i > 0 and calc.rem(cifre.len() - i, 3) == 0 { out += "." }
    out += c
  }
  out
}
#let euro(x) = {
  let centesimi = int(calc.round(x * 100))
  let segno = if centesimi < 0 { "-" } else { "" }
  let c = calc.abs(centesimi)
  let intero = migliaia(int(c / 100))
  let resto = calc.rem(c, 100)
  if resto == 0 { segno + intero + " €" } else {
    segno + intero + "," + (if resto < 10 { "0" } else { "" }) + str(resto) + " €"
  }
}

// Tabella delle ore per persona e ruolo di un insieme di righe
#let tabella-ore(righe) = tabella(
  (2.4fr,) + ruoli.map(_ => 1fr) + (1fr,),
  ("Componente",) + ruoli.map(r => r.sigla) + ("Totale",),
  ..membri.map(m => (
    m.nome,
    ..ruoli.map(r => num(ore-persona-ruolo(righe, m.login, r.id))),
    [*#num(ore-persona(righe, m.login))*],
  )).flatten(),
  [*Totale ore*], ..ruoli.map(r => [*#num(ore-ruolo(righe, r.id))*]), [*#num(somma(righe))*],
  [*Costo*], ..ruoli.map(r => euro(costo-ruolo(righe, r))), [*#euro(costo(righe))*],
)

= Introduzione

== Scopo del documento

Il documento descrive come il gruppo Memory Leakers pianifica e controlla il progetto del #g("capitolato", "capitolato") C6 «SCSDF» di Var Group S.p.A.: rischi, calendario, #g("preventivo", "preventivo") e, 
per ogni #g("sprint", "sprint"), le ore e i costi preventivati, quelli effettivi (#g("consuntivo", "consuntivo")) e il budget che resta.

Il documento si aggiorna alla fine di ogni sprint (@redazione).

== Redazione del documento <redazione>

// TODO(gruppo): chi aggiorna il Piano a fine sprint (Amministratore, analisti o Responsabile). Va scritto anche nelle Norme di Progetto (issue #107).
Il Piano si aggiorna alla fine di ogni sprint, con questa procedura:
+ ogni componente registra le proprie ore produttive sul sito, nella pagina `/ore`, entro la fine dello sprint;
+ chi aggiorna il Piano scarica il CSV delle ore dello sprint dalla pagina `/ore` e lo salva in `dati/ore/` con il nome `ore-Sn.csv`, dove `n` è il numero dello sprint;
+ nella voce dello sprint concluso imposta lo stato «Concluso» e inserisce rischi occorsi e retrospettiva, discussi nella riunione di fine sprint a partire dalle difficoltà riportate nei diari di bordo dello sprint;
+ aggiunge la voce dello sprint nuovo: date, ruoli, file delle ore, nome dello sprint sulla bacheca, rischi attesi e preventivo;
+ rivede l'analisi dei rischi (rischi nuovi, probabilità e impatto) e il calendario;
+ segue la procedura dei documenti delle Norme di Progetto (issue, branch, pull request e verifica); dopo la verifica, il Responsabile approva il rilascio.

Consuntivo e budget residuo si calcolano dai file delle ore, quindi non si scrivono a mano.

== Scopo del prodotto

Var Group S.p.A., #g("proponente", "proponente") del capitolato, usa #g("litellm", "LiteLLM"), un #g("proxy", "proxy") che smista le richieste verso diversi modelli di intelligenza artificiale. 
Oggi LiteLLM riconosce solo le richieste identiche a una già servita, non mostra i costi divisi per team e progetto e non prevede la spesa futura.

Il prodotto estende LiteLLM con due componenti:
- una #g("cache-semantica", "cache semantica"), che riconosce le richieste con lo stesso significato di una già servita e restituisce la risposta salvata, risparmiando costi e tempo;
- una #g("dashboard-finops", "dashboard FinOps"), che mostra consumi e costi per team, progetto e utente, il risparmio ottenuto con la cache, i budget con i relativi avvisi e la previsione della spesa mensile.

Il capitolato chiede di partire da LiteLLM senza reimplementarlo e di coprire con i test almeno il 70% del codice prodotto. Il gruppo si è impegnato a completare il progetto entro il 2027-03-23 (Dichiarazione degli impegni).

== Glossario

I termini con pedice #sub[G] rimandano alla voce corrispondente del glossario sul sito del gruppo.

== Riferimenti

=== Riferimenti normativi
- Regolamento del progetto didattico, Ingegneria del Software, A.A. 2026/2027 (consultato dal 2026-10-06 al 2026-11-26);
- #g("norme-di-progetto", "Norme di Progetto"), Memory Leakers: `RTB/Generali/norme-di-progetto.typ`.

=== Riferimenti informativi
- Capitolato C6 «SCSDF», Var Group S.p.A. (consultato dal 2026-10-13 al 2026-11-26);
- Gestione di progetto (T4), Ingegneria del Software, A.A. 2026/2027 (consultato dal 2026-10-19 al 2026-11-26);
- Dichiarazione degli impegni, Memory Leakers: `Candidatura/Generali/Dichiarazione-degli-impegni.typ`;
- Verbale interno del 2026-11-17: `RTB/Verbali_interni/2026-11-17.typ`;
- Diari di bordo, Memory Leakers: `RTB/Diario_di_bordo/`.

= Modello di sviluppo

Il gruppo segue un modello #g("agile", "agile"), a sprint di due settimane. A ogni sprint i ruoli ruotano secondo le Norme di Progetto e il gruppo:
- all'inizio fissa le attività come #g("issues", "issue") sulla bacheca e ne stima le ore, da cui nasce il preventivo dello sprint;
- durante lo sprint si coordina nella riunione interna del martedì e negli stand-up del venerdì con Var Group;
- alla fine registra le ore produttive, confronta preventivo e consuntivo, riporta i rischi occorsi e svolge la #g("sprint-retrospective", "retrospettiva").

Il progetto ha due revisioni di avanzamento, che sono le #g("milestone", "milestone") principali:
- #g("rtb", "RTB") (Requirements and Technology Baseline), il 2027-01-18: #g("analisi-dei-requisiti", "Analisi dei Requisiti") validata dal proponente e #g("poc", "PoC") che dimostra 
  la fattibilità delle tecnologie scelte;
- #g("pb", "PB") (Product Baseline): Specifica Tecnica e #g("mvp", "MVP") validato dal proponente, con data ancora da fissare.

Le milestone intermedie sono nel calendario (@calendario).

= Risorse e ruoli

Il gruppo è composto da sette componenti. Ognuno ricopre un solo ruolo alla volta e i ruoli ruotano a ogni sprint secondo le Norme di Progetto, così che ogni componente li ricopra tutti (Regolamento del progetto didattico).

#let compiti = (
  responsabile: [Coordina il gruppo e le sue attività, elabora piani e scadenze, rappresenta il gruppo verso proponente e committente e approva il rilascio dei prodotti.],
  amministratore: [Assicura l'efficienza di procedure, strumenti e tecnologie del modo di lavorare del gruppo (repository, automazioni, sito) e ne descrive l'uso nelle Norme di Progetto.],
  analista: [Svolge l'analisi dei requisiti: studia il problema e il dominio e ne ricava i requisiti del prodotto.],
  progettista: [Svolge la progettazione: definisce l'architettura del prodotto a partire dai requisiti.],
  programmatore: [Svolge la codifica: realizza il prodotto secondo la progettazione, con il codice e i test.],
  verificatore: [Svolge la verifica: controlla che documenti e codice rispettino le Norme di Progetto e i requisiti.],
)

#tabella(
  (auto, 1fr, auto),
  ("Ruolo", "Compiti", "Costo orario"),
  ..ruoli.map(r => (r.nome, align(left, compiti.at(r.id)), [#r.tariffa €/h])).flatten(),
)

Le ore preventivate e rendicontate sono #g("ore-produttive", "ore produttive"): ore di lavoro su un'attività del progetto, svolte nel ruolo assegnato nello sprint e registrate sul sito (@sprint-sez). Per regolamento ogni 
componente ne dedica tra 80 e 95, contate solo dopo l'aggiudicazione del 2026-11-03; il gruppo ne ha dichiarate 93 a testa.

La ripartizione delle ore tra ruoli e componenti del preventivo iniziale è un obiettivo verso cui tendere, non un vincolo: il Responsabile la rivede a ogni sprint in base al consuntivo. Il costo totale accettato 
all'aggiudicazione, #euro(preventivo-costo), è invece un limite che non si può superare: se il costo sostenuto si avvicina a quel limite, il gruppo rinegozia al ribasso i requisiti con il proponente (Regolamento del progetto didattico).

= Analisi dei rischi

// TODO: rivedere a ogni sprint (rischi nuovi, probabilità e impatto aggiornati)

I rischi sono divisi in tre categorie, ognuna con la sua sigla:

#let categorie = (
  (sigla: "RT", nome: "Rischi tecnologici", descrizione: [legati alle tecnologie e ai servizi usati dal prodotto]),
  (sigla: "RO", nome: "Rischi organizzativi", descrizione: [legati alla pianificazione, al modo di lavorare del gruppo e al rapporto con il proponente]),
  (sigla: "RP", nome: "Rischi personali", descrizione: [legati alla disponibilità dei componenti del gruppo]),
)

#for c in categorie [
  - *#c.sigla* - #c.nome: #c.descrizione.
]

Per ogni rischio si indicano:
- *probabilità*: quanto è probabile che il rischio si verifichi (Bassa, Media, Alta);
- *impatto*: quanto pesa su tempi e costi se si verifica (Basso: ritardo recuperabile nello sprint; Medio: ritardo di uno sprint o più ore del previsto; Alto: mette a rischio una milestone o il budget);
- *mitigazione*: cosa fa il gruppo per evitarlo o ridurlo;
- *contingenza*: cosa fa il gruppo se il rischio si verifica.

#let rischi = (
  (
    codice: "RT1", nome: "Tecnologie nuove per il gruppo",
    descrizione: [Il capitolato propone tecnologie sconosciute alla maggior parte del gruppo, in particolare quelle legate alla cache semantica: LiteLLM, i #g("modelli-di-embedding", "modelli di embedding"), 
    i #g("vector-store", "vector store") e #g("redis", "Redis"). Il tempo per impararle potrebbe rallentare progettazione e sviluppo.],
    probabilita: "Alta", impatto: "Medio",
    mitigazione: [Studio delle tecnologie fin dalle prime settimane, condivisione delle conoscenze nel gruppo e confronto con il proponente in caso di dubbi.],
    contingenza: [Il #g("responsabile", "Responsabile") sposta allo sprint successivo le attività che dipendono dalla tecnologia e il gruppo chiede a Var Group un incontro di formazione o un esempio di riferimento.],
  ),
  (
    codice: "RT2", nome: "Dipendenza da servizi esterni",
    descrizione: [Sviluppo e test dipendono da servizi che il gruppo non controlla: le chiavi fornite da Var Group per i modelli e per l'embedding, #g("aws-bedrock", "AWS Bedrock") e l'eventuale 
    #g("classificatore", "classificatore") esterno #g("jev", "Jev"). Un ritardo nel rilascio delle chiavi, un servizio non disponibile o un limite di utilizzo potrebbero bloccare il lavoro.],
    probabilita: "Media", impatto: "Alto",
    mitigazione: [Il gruppo chiede le chiavi con anticipo rispetto alle attività che le usano e tiene sotto controllo il consumo dei servizi.],
    contingenza: [Il Responsabile segnala subito il problema al proponente. Nel frattempo il gruppo prosegue con risposte simulate o con modelli #g("open-source", "open source") in locale.],
  ),
  (
    codice: "RO1", nome: "Stima errata delle risorse",
    descrizione: [La ripartizione delle ore tra i ruoli e nel tempo potrebbe rivelarsi errata, per l'inesperienza del gruppo nella pianificazione di progetti di queste dimensioni, causando carenza di risorse su alcune attività.],
    probabilita: "Alta", impatto: "Alto",
    mitigazione: [Il Responsabile confronta a ogni sprint le ore svolte con quelle preventivate (@sprint-sez). Gli scostamenti si discutono nella riunione successiva, per ridistribuire le attività o pianificare un riallineamento.],
    contingenza: [Il Responsabile ridistribuisce le ore tra ruoli e sprint e aggiorna il preventivo a finire. Se il budget complessivo è a rischio, il gruppo concorda con il proponente quali requisiti desiderabili e opzionali rimandare.],
  ),
  (
    codice: "RO2", nome: "Incomprensione dei requisiti",
    descrizione: [Un'analisi superficiale o una comunicazione insufficiente con il proponente potrebbero portare a requisiti incompleti o fraintesi, con modifiche costose nelle fasi avanzate.],
    probabilita: "Media", impatto: "Alto",
    mitigazione: [#g("analisi-dei-requisiti", "Analisi dei requisiti") attenta, con domande raccolte in modo asincrono e chiarite con Var Group negli incontri periodici. Ogni requisito riporta la sua fonte e il gruppo sottopone 
    i requisiti al proponente per la validazione.],
    contingenza: [Gli #g("analista", "analisti") correggono i requisiti con una nuova #g("issues", "issue") appena il proponente segnala l'errore. Il Responsabile valuta l'impatto sulle attività e sulle ore già pianificate.],
  ),
  (
    codice: "RO3", nome: "Requisiti che cambiano",
    descrizione: [Il proponente potrebbe cambiare o precisare le richieste durante il progetto. Per esempio, le funzioni della #g("dashboard-finops", "dashboard FinOps") richieste dal capitolato (budget, avvisi, previsione della spesa) 
    sono ancora da confermare con Var Group.],
    probabilita: "Media", impatto: "Medio",
    mitigazione: [Il gruppo porta le domande aperte agli incontri periodici con il proponente. Ogni modifica ai requisiti passa da un #g("verbale", "verbale") esterno o da una riunione con il proponente, e da una nuova issue.],
    contingenza: [Il Responsabile stima le ore della modifica. Se non rientra nel budget, il gruppo concorda con il proponente cosa rimandare o rendere opzionale.],
  ),
  (
    codice: "RO4", nome: "Coordinamento insufficiente nel lavoro in parallelo",
    descrizione: [Più componenti lavorano in parallelo sugli stessi documenti e sulle stesse parti del prodotto. Senza coordinamento si rischiano lavoro doppio, conflitti tra #g("branch", "branch") e incoerenze, per esempio due 
    analisti che usano lo stesso codice per requisiti diversi.],
    probabilita: "Media", impatto: "Medio",
    mitigazione: [Il lavoro si divide per area, ogni attività ha la sua issue con un assegnatario e il gruppo segue le procedure delle Norme di Progetto. Chi introduce un codice nuovo lo comunica prima agli altri.],
    contingenza: [Chi nota il problema lo segnala al gruppo. Gli assegnatari coinvolti concordano la correzione e la svolgono con una nuova issue.],
  ),
  (
    codice: "RO5", nome: "Rotazione dei ruoli e verifica indipendente",
    descrizione: [Il regolamento chiede che ogni componente ricopra tutti i ruoli per un tempo congruo e che ogni attività abbia una verifica indipendente. Con la rotazione ogni due settimane, un componente potrebbe ricoprire un ruolo nella 
    fase in cui quel ruolo ha poco lavoro, oppure verificare un lavoro a cui ha partecipato.],
    probabilita: "Media", impatto: "Medio",
    mitigazione: [I ruoli ruotano secondo le regole delle Norme di Progetto. Il Responsabile controlla a ogni sprint le ore per componente e ruolo rispetto al preventivo. Il #g("verificatore", "verificatore") non verifica il proprio lavoro 
    e non apre #g("pull-request", "pull request") nello sprint in cui verifica.],
    contingenza: [Il Responsabile assegna il ruolo mancante al componente negli sprint in cui quel ruolo ha più lavoro. Se una verifica non è indipendente, la ripete un altro componente.],
  ),
  (
    codice: "RO6", nome: "Difficoltà di comunicazione con il proponente",
    descrizione: [Le risposte del proponente potrebbero arrivare in ritardo e gli incontri, fissati in orari concordati con l'azienda, potrebbero non essere accessibili a tutto il gruppo. Domande senza risposta e componenti assenti agli incontri rallentano 
    l'analisi e le decisioni.],
    probabilita: "Media", impatto: "Medio",
    mitigazione: [Il gruppo raccoglie le domande in anticipo in un documento condiviso e usa il canale #g("microsoft-teams", "Microsoft Teams") concordato con Var Group per le comunicazioni rapide. Chi partecipa a un incontro ne riporta l'esito agli assenti.],
    contingenza: [Se una risposta tarda, il Responsabile sollecita il proponente. Nel frattempo il gruppo prosegue sulle parti che non dipendono dalla risposta e segna come da confermare i requisiti coinvolti.],
  ),
  (
    codice: "RP1", nome: "Esami e sessione",
    descrizione: [Durante la sessione invernale, dal 2027-01-18 al 2027-02-19, e nelle settimane prima degli appelli i componenti hanno meno tempo per il progetto. La sessione inizia lo stesso giorno della #g("rtb", "RTB").],
    probabilita: "Alta", impatto: "Medio",
    mitigazione: [Le milestone critiche (Analisi dei Requisiti e #g("poc", "PoC")) cadono prima della sessione. Ogni componente comunica in anticipo i propri appelli e il preventivo dello sprint tiene conto della disponibilità ridotta.],
    contingenza: [Il Responsabile ridistribuisce le attività tra i componenti disponibili e sposta agli sprint successivi quelle non urgenti.],
  ),
  (
    codice: "RP2", nome: "Impegni personali e lavorativi",
    descrizione: [Alcuni componenti sono studenti lavoratori e tutti hanno impegni personali: trovare orari adatti a tutto il gruppo e al proponente è difficile, quindi a riunioni e incontri potrebbe mancare qualcuno.],
    probabilita: "Alta", impatto: "Basso",
    mitigazione: [Chi prevede un'assenza la comunica in anticipo. Gli appunti degli incontri si condividono con tutto il gruppo. Ogni attività ha un'issue con assegnatario e stato aggiornato, così un altro componente può subentrare.],
    contingenza: [Il Responsabile riassegna le attività bloccate e aggiorna il preventivo dello sprint.],
  ),
  (
    codice: "RP3", nome: "Periodo natalizio",
    descrizione: [Nel periodo natalizio, dal 2026-12-24 al 2027-01-01, la disponibilità dei componenti si riduce. Il periodo cade negli sprint 4 e 5, tra la validazione dell'Analisi dei Requisiti (2026-12-18) e il PoC (2027-01-12).],
    probabilita: "Alta", impatto: "Medio",
    mitigazione: [La validazione dell'Analisi dei Requisiti è fissata prima del periodo. Ogni componente comunica in anticipo i giorni in cui non è disponibile e il preventivo degli sprint 4 e 5 tiene conto della disponibilità ridotta.],
    contingenza: [Il Responsabile ridistribuisce le attività tra i componenti disponibili e sposta agli sprint successivi quelle non urgenti, dando la precedenza a quelle necessarie per il PoC.],
  ),
)

== Riepilogo

#tabella(
  (auto, 1fr, auto, auto),
  ("Codice", "Rischio", "Probabilità", "Impatto"),
  ..rischi.map(r => (r.codice, r.nome, r.probabilita, r.impatto)).flatten(),
)

#for c in categorie [
  == #c.nome
  #for r in rischi.filter(r => r.codice.starts-with(c.sigla)) {
    scheda-rischio(r)
  }
]

= Calendario <calendario>

Il gruppo lavora a sprint di due settimane, dal martedì al lunedì di due settimane dopo, con le date della pagina `/ore` del sito. La tabella riporta per ogni sprint le milestone e i periodi di disponibilità ridotta. La consegna finale è prevista entro il 2027-03-23 (Dichiarazione degli impegni).

#tabella(
  (auto, auto, auto, 1fr),
  ("Sprint", "Inizio", "Fine", "Milestone e note"),
  [S1], [2026-11-03], [2026-11-16], [],
  [S2], [2026-11-17], [2026-11-30], [2026-11-30: base di analisi e conoscenza delle tecnologie],
  [S3], [2026-12-01], [2026-12-14], [2026-12-11: chiusura dell'Analisi dei Requisiti (obiettivo)],
  [S4], [2026-12-15], [2026-12-28], [2026-12-18: validazione dell'Analisi dei Requisiti; dal 2026-12-24 periodo natalizio],
  [S5], [2026-12-29], [2027-01-11], [fino al 2027-01-01 periodo natalizio],
  [S6], [2027-01-12], [2027-01-25], [2027-01-12: PoC; 2027-01-18: RTB; dal 2027-01-18 sessione d'esame],
  [S7], [2027-01-26], [2027-02-08], [sessione d'esame],
  [S8], [2027-02-09], [2027-02-22], [sessione d'esame fino al 2027-02-19],
  [S9], [2027-02-23], [2027-03-08], [],
  [S10], [2027-03-09], [2027-03-22], [consegna finale entro il 2027-03-23],
)

Milestone dal verbale interno del 2026-11-17; periodi di rallentamento dalla Dichiarazione degli impegni.
// TODO(gruppo): le milestone dopo la RTB (PB, MVP) sono ancora da fissare

= Pianificazione della RTB <pianificazione-rtb>

Per la RTB servono l'Analisi dei Requisiti, validata dal proponente, e il PoC (@calendario).
// TODO: sottosezione sul PoC

== Analisi dei Requisiti

L'Analisi dei Requisiti stabilisce che cosa deve fare il prodotto, in accordo con il proponente: attori, casi d'uso e requisiti, ognuno con la sua fonte e il tracciamento. È la base della progettazione e della verifica del prodotto. Le regole per scriverla sono nelle Norme di Progetto.

Il gruppo la redige con queste attività:
+ raccolta delle informazioni dal capitolato e dagli incontri con Var Group (verbali esterni, sessione di design thinking del 2026-11-18, stand-up settimanali);
+ prima stesura dei requisiti in un documento condiviso, divisi per area del prodotto e per importanza (obbligatori, desiderabili, opzionali), con le domande aperte da portare a Var Group;
+ individuazione degli attori e dei casi d'uso, con i diagrammi UML;
+ stesura del documento in Typst, con codice, fonte e tracciamento di ogni requisito;
+ verifica interna;
+ validazione con Var Group.

// TODO: citare il verbale interno del 2026-11-24 quando è nel repository
Gli analisti si dividono il lavoro per area del prodotto, cache semantica e dashboard FinOps (riunione interna del 2026-11-24). Con la rotazione dei ruoli del 2026-12-01 cambiano gli analisti: chi prosegue l'analisi nello sprint 3 è da decidere all'inizio dello sprint.
// TODO(gruppo): decidere chi prosegue l'Analisi dei Requisiti dopo la rotazione

#tabella(
  (auto, auto, 1fr),
  ("Sprint", "Periodo", "Attività"),
  [S2], [2026-11-17 → 2026-11-30], [Design thinking, prima stesura dei requisiti nel documento condiviso, domande allo stand-up del 2026-11-27],
  [S3], [2026-12-01 → 2026-12-14], [Casi d'uso, stesura in Typst e verifica; chiusura entro il 2026-12-11],
  [S4], [2026-12-15 → 2026-12-28], [Validazione con Var Group entro il 2026-12-18],
)

Milestone e avvio dell'analisi dopo il design thinking: verbale interno del 2026-11-17. La stesura in Typst comincia dopo che le Norme di Progetto contengono la sezione sull'analisi dei requisiti (issue \#107).

= Preventivo iniziale

Il preventivo presentato in candidatura prevede #num(preventivo-ore) #g("ore-produttive", "ore produttive"), 93 per componente, per un costo di #euro(preventivo-costo).

#tabella(
  (1fr, auto, auto, auto),
  ("Ruolo", "Ore", "Costo orario", "Costo"),
  ..ruoli.enumerate().map(((i, r)) => (
    r.nome, str(preventivo-ruolo(i)), [#r.tariffa €/h], euro(preventivo-ruolo(i) * r.tariffa),
  )).flatten(),
  [*Totale*], [*#num(preventivo-ore)*], [-], [*#euro(preventivo-costo)*],
)

Ore preventivate per componente e ruolo:

#tabella(
  (2.4fr,) + ruoli.map(_ => 1fr) + (1fr,),
  ("Componente",) + ruoli.map(r => r.sigla) + ("Totale",),
  ..membri.map(m => (m.nome, ..m.preventivo.map(str), [*#m.preventivo.sum()*])).flatten(),
)

= Sprint <sprint-sez>

Per ogni sprint si riportano i ruoli, l'obiettivo, le attività con la loro stima, i rischi attesi, il preventivo confrontato con le ore effettive, il consuntivo per componente, i rischi occorsi e la retrospettiva. 
Le attività di ogni sprint sono le issue della bacheca del gruppo in #g("github-projects", "GitHub Projects"), filtrate per sprint.

Le ore sono quelle produttive registrate sul sito nella pagina `/ore`. Riunioni e stesura dei verbali non sono ore produttive: le riunioni sono escluse dalle Norme di Progetto, la stesura dei verbali su indicazione del 
#g("committente", "committente") nel #g("diario-di-bordo", "diario di bordo") del 2026-11-23. Ogni membro registra le proprie ore entro la fine dello sprint: per uno sprint in corso il consuntivo è parziale.

// TODO(gruppo): metodo del preventivo da confermare alla riunione del 2026-12-01
// (stime delle issue, verifica al 60%, 0,3 ore per issue all'Amministratore, 2 ore per sprint al Responsabile).

// Nome di un rischio a partire dal suo codice, per esempio "RT1"
#let nome-rischio(codice) = {
  let r = rischi.find(r => r.codice == codice)
  assert(r != none, message: "Rischio sconosciuto: " + codice)
  r.nome
}

#for s in sprint {
  let righe = ore-di(s)
  [
    == Sprint #s.numero (#s.inizio → #s.fine)

    *Stato:* #s.stato

    === Ruoli
    #tabella(
      (1fr, 1fr),
      ("Componente", "Ruolo"),
      ..membri.map(m => (m.nome, s.ruoli.at(m.login, default: "-"))).flatten(),
    )

    === Obiettivo
    #s.at("obiettivo", default: [Da definire all'inizio dello sprint.])

    === Attività
    #let attivita = s.at("attivita", default: ())
    #if attivita.len() == 0 [
      Da compilare.
    ] else [
      #tabella(
        (auto, 1fr, auto, auto),
        ("Issue", "Attività", "Stima (ore)", "Stato"),
        ..attivita.map(a => (issue(a.issue, repo: a.at("repo", default: "Documenti")), align(left, a.titolo), if "ore" in a { num(a.ore) } else { "-" }, a.stato)).flatten(),
      )
    ]
    Le attività previste sono le issue con il campo Sprint «#s.bacheca» sulla #link(bacheca(s.bacheca))[bacheca del gruppo]; quelle svolte hanno stato «Svolta».

    === Rischi attesi
    #let attesi = s.at("rischi-attesi", default: ())
    #if attesi.len() == 0 [
      Da definire all'inizio dello sprint.
    ] else [
      #tabella(
        (auto, 1fr),
        ("Codice", "Rischio"),
        ..attesi.map(c => (c, nome-rischio(c))).flatten(),
      )
    ]

    === Preventivo
    #let stimate = attivita.filter(a => "ore" in a)
    #if stimate.len() == 0 [
      Da definire.
    ] else [
      #let stima-issue(r) = stimate.filter(a => a.ruolo == r.id).map(a => a.ore).sum(default: 0)
      #let ore-da-verificare = stimate.map(a => a.ore).sum()
      #let gestione(r) = if r.id == "amministratore" { attivita.len() * ore-per-issue } else if r.id == "responsabile" { gestione-responsabile } else { 0 }
      #let verifica(r) = if r.id == "verificatore" { ore-da-verificare * rapporto-verifica } else { 0 }
      #let prev(r) = mezz-ora(stima-issue(r) + gestione(r) + verifica(r))
      #let usati = ruoli.filter(r => prev(r) > 0 or ore-ruolo(righe, r.id) > 0)
      #tabella(
        (1.4fr, 1fr, 1fr, 1fr, 1fr),
        ("Ruolo", "Ore preventivate", "Ore effettive", "Costo preventivato", "Costo effettivo"),
        ..usati.map(r => (
          r.nome, num(prev(r)), num(ore-ruolo(righe, r.id)),
          euro(prev(r) * r.tariffa), euro(costo-ruolo(righe, r)),
        )).flatten(),
        [*Totale*],
        [*#num(usati.map(prev).sum())*],
        [*#num(somma(righe))*],
        [*#euro(usati.map(r => prev(r) * r.tariffa).sum())*],
        [*#euro(costo(righe))*],
      )
      Il preventivo è la somma delle stime scritte nelle issue dello sprint. Le issue senza stima non entrano nel preventivo: verbali e diari di bordo non sono ore produttive e le attività più piccole non sono state stimate. 
      Le issue non stimano la verifica: le ore del Verificatore sono stimate a posteriori come il #num(rapporto-verifica * 100)% delle ore stimate per le attività da verificare. 
      All'Amministratore si aggiungono #num(ore-per-issue) ore per ogni issue dello sprint, per aprirla con la sua descrizione: queste ore non passano dalla verifica.
      Al Responsabile si aggiungono #num(gestione-responsabile) ore per sprint per i rapporti con il proponente, le email e il coordinamento del gruppo, anche queste senza verifica.
      Le ore preventivate di ogni ruolo sono arrotondate alla mezz'ora più vicina, come quelle registrate.
    ]

    === Consuntivo
    #if righe.len() == 0 [
      Nessuna ora registrata finora.
    ] else [
      #tabella-ore(righe)
    ]
    #let senza-ore = membri.filter(m => ore-persona(righe, m.login) == 0).map(m => m.nome)
    #if s.stato == "Concluso" and senza-ore.len() > 0 [
      Non hanno ore produttive registrate nello sprint: #senza-ore.join(", ", last: " e ").
    ]
    #if s.at("nota", default: none) != none [ #s.nota ]

    === Rischi occorsi
    #let occorsi = s.at("rischi-occorsi", default: none)
    #if occorsi == none [
      Da compilare a fine sprint.
    ] else if occorsi.len() == 0 [
      Nessun rischio si è verificato nello sprint.
    ] else [
      #tabella(
        (auto, 1fr, 1.5fr, 1.5fr),
        ("Codice", "Rischio", "Cosa è successo", "Efficacia della mitigazione"),
        ..occorsi.map(o => (
          o.codice, nome-rischio(o.codice), align(left, o.descrizione), align(left, o.efficacia),
        )).flatten(),
      )
    ]

    === Retrospettiva
    #let retro = s.at("retrospettiva", default: none)
    #if retro == none [
      Da compilare a fine sprint.
    ] else [
      *Cosa è andato bene*
      #for p in retro.bene [- #p]

      *Cosa migliorare*
      #for p in retro.migliorare [- #p]
    ]
  ]
}

= Budget residuo

Ore e costi svolti dall'inizio del progetto, confrontati con il preventivo iniziale.

== Per ruolo

#tabella(
  (1.4fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
  ("Ruolo", "Ore prev.", "Ore svolte", "Ore residue", "Costo prev.", "Costo sostenuto", "Costo residuo"),
  ..ruoli.enumerate().map(((i, r)) => {
    let prev = preventivo-ruolo(i)
    let svolte = ore-ruolo(tutte, r.id)
    (r.nome, str(prev), num(svolte), num(prev - svolte),
     euro(prev * r.tariffa), euro(svolte * r.tariffa), euro((prev - svolte) * r.tariffa))
  }).flatten(),
  [*Totale*], [*#num(preventivo-ore)*], [*#num(somma(tutte))*], [*#num(preventivo-ore - somma(tutte))*],
  [*#euro(preventivo-costo)*], [*#euro(costo(tutte))*], [*#euro(preventivo-costo - costo(tutte))*],
)

== Per componente e ruolo

Ore residue di ciascun componente per ogni ruolo.

#tabella(
  (2.4fr,) + ruoli.map(_ => 1fr) + (1fr,),
  ("Componente",) + ruoli.map(r => r.sigla) + ("Totale",),
  ..membri.map(m => (
    m.nome,
    ..ruoli.enumerate().map(((i, r)) => num(m.preventivo.at(i) - ore-persona-ruolo(tutte, m.login, r.id))),
    [*#num(m.preventivo.sum() - ore-persona(tutte, m.login))*],
  )).flatten(),
)