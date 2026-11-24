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
    nota: [Nello sprint si sono occupati della stesura dei verbali, che non è ora produttiva.],
  ),
  (
    codice: "S2", numero: 2, inizio: "2026-11-17", fine: "2026-11-30", stato: "In corso",
    file: "../../dati/ore/ore-S2.csv",
    ruoli: (
      "Matteomarcon": "Responsabile", "Ric02P": "Amministratore", "jeidi19": "Verificatore",
      "Kyara-Prot": "Analista", "JJ-jacopo24": "Analista", "ttteo": "Analista", "paolopreve": "Analista",
    ),
    bacheca: "Sprint 2",
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

Il documento descrive come il gruppo Memory Leakers pianifica e controlla il progetto del #g("capitolato", "capitolato") C6 «SCSDF» di Var Group S.p.A.: rischi, calendario, #g("preventivo", "preventivo") e, per ogni #g("sprint", "sprint"), le ore e i costi preventivati, quelli effettivi (#g("consuntivo", "consuntivo")) e il budget che resta.

Il documento si aggiorna alla fine di ogni sprint.

== Glossario

I termini con pedice #sub[G] rimandano alla voce corrispondente del glossario sul sito del gruppo.

== Riferimenti

=== Riferimenti normativi
- Regolamento del progetto didattico (PD1), Ingegneria del Software, A.A. 2026/2027;
  // TODO(dato): link e data di consultazione
- #g("norme-di-progetto", "Norme di Progetto"), Memory Leakers: `RTB/Generali/norme-di-progetto.typ`.

=== Riferimenti informativi
- Capitolato C6 «SCSDF», Var Group S.p.A.;
  // TODO(dato): link e data di consultazione
- Dichiarazione degli impegni, Memory Leakers: `Candidatura/Generali/Dichiarazione-degli-impegni.typ`;
- Verbale interno del 2026-11-17: `RTB/Verbali_interni/2026-11-17.typ`.


= Analisi dei rischi

// TODO: rivedere a ogni sprint (rischi nuovi, probabilità e impatto aggiornati)

I rischi sono divisi in tre categorie, ognuna con la sua sigla:

#let categorie = (
  (sigla: "RT", nome: "Rischi tecnologici", descrizione: [legati alle tecnologie e ai servizi usati dal prodotto]),
  (sigla: "RO", nome: "Rischi organizzativi", descrizione: [legati alla pianificazione, al modo di lavorare del gruppo e al rapporto con il #g("proponente", "proponente")]),
  (sigla: "RP", nome: "Rischi personali", descrizione: [legati alla disponibilità dei componenti del gruppo]),
)

#for c in categorie [
  - *#c.sigla* - #c.nome: #c.descrizione.
]

Per ogni rischio si indicano:
- *probabilità*: quanto è probabile che il rischio si verifichi (Bassa, Media, Alta);
- *impatto*: quanto pesa su tempi e costi se si verifica (Basso: ritardo recuperabile nello sprint; Medio: ritardo di uno sprint o più ore del previsto; Alto: mette a rischio una #g("milestone", "milestone") o il budget);
- *mitigazione*: cosa fa il gruppo per evitarlo o ridurlo;
- *contingenza*: cosa fa il gruppo se il rischio si verifica.

#let rischi = (
  (
    codice: "RT1", nome: "Tecnologie nuove per il gruppo",
    descrizione: [Il capitolato propone tecnologie sconosciute alla maggior parte del gruppo, in particolare quelle legate alla #g("cache-semantica", "cache semantica"): #g("litellm", "LiteLLM"), i #g("modelli-di-embedding", "modelli di embedding"), i #g("vector-store", "vector store") e #g("redis", "Redis"). Il tempo per impararle potrebbe rallentare progettazione e sviluppo.],
    probabilita: "Alta", impatto: "Medio",
    mitigazione: [Studio delle tecnologie fin dalle prime settimane, condivisione delle conoscenze nel gruppo e confronto con il proponente in caso di dubbi.],
    contingenza: [Il #g("responsabile", "Responsabile") sposta allo sprint successivo le attività che dipendono dalla tecnologia e il gruppo chiede a Var Group un incontro di formazione o un esempio di riferimento.],
  ),
  (
    codice: "RT2", nome: "Dipendenza da servizi esterni",
    descrizione: [Sviluppo e test dipendono da servizi che il gruppo non controlla: le chiavi fornite da Var Group per i modelli e per l'embedding, #g("aws-bedrock", "AWS Bedrock") e l'eventuale #g("classificatore", "classificatore") esterno #g("jev", "Jev"). Un ritardo nel rilascio delle chiavi, un servizio non disponibile o un limite di utilizzo potrebbero bloccare il lavoro.],
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
    mitigazione: [#g("analisi-dei-requisiti", "Analisi dei requisiti") attenta, con domande raccolte in modo asincrono e chiarite con Var Group negli incontri periodici. Ogni requisito riporta la sua fonte e il gruppo sottopone i requisiti al proponente per la validazione.],
    contingenza: [Gli #g("analista", "analisti") correggono i requisiti con una nuova #g("issues", "issue") appena il proponente segnala l'errore. Il Responsabile valuta l'impatto sulle attività e sulle ore già pianificate.],
  ),
  (
    codice: "RO3", nome: "Requisiti che cambiano",
    descrizione: [Il proponente potrebbe cambiare o precisare le richieste durante il progetto. Per esempio, le funzioni della #g("dashboard-finops", "dashboard FinOps") richieste dal capitolato (budget, avvisi, previsione della spesa) sono ancora da confermare con Var Group.],
    probabilita: "Media", impatto: "Medio",
    mitigazione: [Il gruppo porta le domande aperte agli incontri periodici con il proponente. Ogni modifica ai requisiti passa da un verbale esterno e da una nuova issue.],
    contingenza: [Il Responsabile stima le ore della modifica. Se non rientra nel budget, il gruppo concorda con il proponente cosa rimandare o rendere opzionale.],
  ),
  (
    codice: "RO4", nome: "Coordinamento insufficiente nel lavoro in parallelo",
    descrizione: [Più componenti lavorano in parallelo sugli stessi documenti e sulle stesse parti del prodotto. Senza coordinamento si rischiano lavoro doppio, conflitti tra #g("branch", "branch") e incoerenze, per esempio due analisti che usano lo stesso codice per requisiti diversi.],
    probabilita: "Media", impatto: "Medio",
    mitigazione: [Il lavoro si divide per area, ogni attività ha la sua issue con un assegnatario e il gruppo segue le procedure delle Norme di Progetto. Chi introduce un codice nuovo lo comunica prima agli altri.],
    contingenza: [Chi nota il problema lo segnala al gruppo. Gli assegnatari coinvolti concordano la correzione e la svolgono con una nuova issue.],
  ),
  (
    codice: "RO5", nome: "Rotazione dei ruoli e verifica indipendente",
    descrizione: [Il regolamento chiede che ogni componente ricopra tutti i ruoli per un tempo congruo e che ogni attività abbia una verifica indipendente. Con la rotazione ogni due settimane, un componente potrebbe ricoprire un ruolo nella fase in cui quel ruolo ha poco lavoro, oppure verificare un lavoro a cui ha partecipato.],
    probabilita: "Media", impatto: "Medio",
    mitigazione: [I ruoli ruotano secondo le regole delle Norme di Progetto. Il Responsabile controlla a ogni sprint le ore per componente e ruolo rispetto al preventivo. Il #g("verificatore", "verificatore") non verifica il proprio lavoro e non apre #g("pull-request", "pull request") nello sprint in cui verifica.],
    contingenza: [Il Responsabile assegna il ruolo mancante al componente negli sprint in cui quel ruolo ha più lavoro. Se una verifica non è indipendente, la ripete un altro componente.],
  ),
  (
    codice: "RP1", nome: "Esami e sessione",
    descrizione: [Durante la sessione invernale, dal 2027-01-18 al 2027-02-19, e nelle settimane prima degli appelli i componenti hanno meno tempo per il progetto. La sessione inizia lo stesso giorno della #g("rtb", "RTB").],
    probabilita: "Alta", impatto: "Medio",
    mitigazione: [Le milestone critiche (Analisi dei Requisiti e #g("poc", "PoC")) cadono prima della sessione. Ogni componente comunica in anticipo i propri appelli e il preventivo dello sprint tiene conto della disponibilità ridotta.],
    contingenza: [Il Responsabile ridistribuisce le attività tra i componenti disponibili e sposta agli sprint successivi quelle non urgenti.],
  ),
  (
    codice: "RP2", nome: "Periodo natalizio e impegni personali",
    descrizione: [Nel periodo natalizio, dal 2026-12-24 al 2027-01-01, e per impegni personali imprevisti, uno o più componenti potrebbero non essere disponibili.],
    probabilita: "Media", impatto: "Medio",
    mitigazione: [Chi prevede un'assenza la comunica in anticipo. Ogni attività ha un'issue con assegnatario e stato aggiornato, così un altro componente può subentrare.],
    contingenza: [Il Responsabile riassegna le attività bloccate e aggiorna il preventivo dello sprint.],
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

= Calendario

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

Per ogni sprint si riportano i ruoli, il collegamento alle attività, il preventivo, il consuntivo delle ore e il budget residuo. Le attività di ogni sprint sono le issue della bacheca del gruppo in #g("github-projects", "GitHub Projects"), filtrate per sprint. 

Le ore sono quelle produttive registrate sul sito nella pagina `/ore`. Riunioni e stesura dei verbali non sono ore produttive: le riunioni sono escluse dalle Norme di Progetto, la stesura dei verbali su indicazione del committente nel diario di bordo del 2026-11-23. Ogni membro registra le proprie ore entro la fine dello sprint: per uno sprint in corso il consuntivo è parziale.

// TODO(gruppo): preventivo delle ore per sprint. La domanda è rinviata alla riunione
// del 2026-11-24 (verbale del 2026-11-17, issue #62).

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

    === Attività
      Le attività dello sprint sono le issue con il campo Sprint «#s.bacheca» sulla #link(bacheca(s.bacheca))[bacheca del gruppo].

    === Preventivo
    // TODO(gruppo): ore preventivate nello sprint, per ruolo
    Da definire.

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

    === Rischi occorsi e retrospettiva
    // TODO(Responsabile): rischi che si sono verificati e cosa migliorare
    Da compilare a fine sprint.
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