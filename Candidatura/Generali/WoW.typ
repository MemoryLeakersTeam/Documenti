#import "../../Templates/DocumentiGenerici.typ": *

#show: documento.with(
  titolo: "Way of Working",
  sottotitolo: "",
  tipo-documento: "Documento Interno",
  versione: "1.0.0",
  autore: "Riccardo Peresson",
  verificatore: "Chiara Protopapa",
  stato: "Approvato",
  file-nome: "WoW.pdf",
  registro-modifiche: (
    ([1.0.0], [29/10/2026], [Firma ed approvazione del documento], [Riccardo Peresson], [Paolo Prevedello Ramirez]),
    ([0.1.1], [29/10/2026], [Rivalutazione svolgimento Sprint Retrospective e ruolo del Responsabile, correzioni minori], [Riccardo Peresson], [Chiara Protopapa]),
    ([0.1.0], [26/10/2026], [Precisazioni dei concetti e correzioni], [Riccardo Peresson], [Chiara Protopapa]),
    ([0.0.2], [25/10/2026], [Aggiunta link a glossario], [Riccardo Peresson], []),
     ([0.0.1], [24/10/2026], [Prima stesura], [Riccardo Peresson], [])
  ),
  firma-responsabile: "Paolo Prevedello Ramirez"
)

#set heading(numbering: "1.1.1")

= Scopo del documento

Il seguente documento definisce in modo chiaro e univoco l'insieme di strumenti, convenzioni e procedure (#gloss(url:"https://memoryleakersteam.github.io/glossario#way-of-working")[Way of Working]) che il team Memory Leakers adotta per lo sviluppo del #gloss(url: "https://memoryleakersteam.github.io/glossario#progetto")[progetto] assegnato.

N.B: le parole con pedice #sub[G] sono dotate di link di rimando alla relativa voce nel #gloss(url:"https://memoryleakersteam.github.io/glossario#progetto")[Glossario], disponibile sul sito web del team.

= Stack di lavoro

Di seguito le tecnologie adottate dal team.

== Comunicazione

Per le comunicazioni interne:

- _Google Meet_#footnote[#link("https://meet.google.com/home")], riunioni da remoto; piattaforma di videoconferenza utilizzata per le riunioni del team quando non è possibile incontrarsi di persona; permette di condividere lo schermo e registrare gli incontri, favorendo la collaborazione anche a distanza;
- _WhatsApp_#footnote[#link("https://www.whatsapp.com/?lang=it")], comunicazioni rapide e informali; applicazione di messaggistica istantanea per scambi veloci, promemoria e aggiornamenti che non richiedono una formalizzazione; non è il canale di riferimento per le decisioni o per la documentazione del lavoro;
- _Telegram_#footnote[#link("https://telegram.org/")], comunicazioni strutturate e formali; piattaforma di messaggistica organizzata in canali tematici, che raccoglie le comunicazioni ufficiali del team, suddivise per argomento, così da mantenere ordine e tracciabilità delle informazioni; nel dettaglio si dispone dei canali
  - Generale,
  - ToDo,
  - Sondaggi,
  - Candidatura,
  - Riunioni interne,
  - Riunioni esterne,
  - Link Utili.

Per le comunicazioni esterne:

- _Gmail_#footnote[#link("https://workspace.google.com/intl/it/gmail/")], attraverso l'indirizzo *#link("mailto:memoryleakersteam@gmail.com")[memoryleakersteam\@gmail.com]*; servizio di posta elettronica utilizzato per la corrispondenza ufficiale con soggetti esterni al team.

== Organizzazione del lavoro

- _GitHub Projects_#footnote[#link("https://docs.github.com/en/issues/planning-and-tracking-with-projects/learning-about-projects/about-projects")], task, planning (attravero l'utilizzo della view Kanban): strumento di gestione dei progetti integrato con GitHub; consente di creare e assegnare le attività, pianificarne le scadenze e seguirne l’avanzamento tramite una bacheca Kanban, suddivisa in colonne che rappresentano lo stato dei lavori
- _Google Calendar_#footnote[#link("https://workspace.google.com/intl/it/products/calendar/")], calendario condiviso tra ogni membro del team per la condivisione delle disponibilità orarie della settimana

== Repository

- _GitHub_#footnote[#link("https://github.com/")], versionamento, pipeline (GitHub Actions) e knowledge (Wiki): piattaforma di hosting per il codice e i documenti del progetto. Tiene traccia di ogni modifica tramite il controllo di versione, esegue automaticamente test e processi di build tramite GitHub Actions e ospita la Wiki, dove viene raccolta la documentazione condivisa del team.

== Altri strumenti

- _Typst_#footnote[#link("https://typst.app/home")], documentazione: linguaggio di composizione tipografica moderno e veloce, usato per redigere la documentazione tecnica e produrne una versione finale in formato PDF con un risultato curato.
- _Google Presentazioni_#footnote[#link("https://workspace.google.com/intl/it/products/slides/")], per le slide da utilizzare durante i diari di bordo: applicazione per la creazione di presentazioni.

= Repository GitHub

Sezione dedicata alla descrizione della struttura e norme da rispettare all'interno del repository.

== Convenzione Commit

Si applicano i _Conventional Commits_.

#table(
  columns: (auto, 1fr),
  inset: 7pt,
  stroke: 0.5pt + rgb("#49736a"),
  fill: (x, y) => if y == 0 { rgb("#305b57") } else if calc.even(y) { rgb("#eaf7f2") } else { none },
  table.header[*#text(fill: white)[Prefisso]*][*#text(fill: white)[Significato]*],
  [`docs`], [Modifiche alla documentazione, non al codice],
  [`feat`], [Nuova funzionalità del prodotto, non esistente precedentemente],
  [`fix`], [Correzione di un errore/bug],
  [`ci`], [Modifiche alla pipeline #gloss(url:"https://memoryleakersteam.github.io/glossario#ci-cd")[CI/CD]],
  [`build`], [Modifiche a ciò che serve per compilare o costruire il progetto],
  [`refactor`], [Ristrutturazione del codice senza cambiarne il comportamento esterno],
  [`test`], [Aggiunta o modifica di test],
  [`chore`], [Manutenzione varia, non presente nelle altre categorie],
)

=== Lingua

Per i commenti in fase di #gloss(url: "https://memoryleakersteam.github.io/glossario#commit")[commit] si deve adottare la lingua inglese, mentre in ogni altro prodotto del progetto la lingua italiana.

== Struttura e gestione

Convenzioni per la gestione dei branches.

=== I rami principali

Il team ha deciso di applicare la tecnica del #gloss(url: "https://memoryleakersteam.github.io/glossario#git-flow")[Git Flow]:
- _Main_ contiene la versione stabile del codice;
- _Develop_ è il ramo di integrazione, dedicato al codice del sistema, raccoglie i branch di lavoro prima di essere approvati al _Main_.

Inerentemente alla documentazione, non è previsto un ramo _Develop_, ma la creazione dei branch necessari come indicato in 3.2.2 .

=== Issue

Per ogni #gloss(url: "https://memoryleakersteam.github.io/glossario#issues")[issue] deve essere creato un branch dedicato a partire dal ramo _Develop_, seguendo la convenzione dei Conventional Branches (<tipo>/<descrizione-o-issue>, dove il prefisso tipo segue la tabella riportata sopra dei conventional commits). Ogni branch ha una vita massima di 3 giorni: deve essere integrato nel branch develop o eliminato entro questo termine, per evitare branch dimenticati e divergenze troppo grandi rispetto al ramo principale.

=== Pull request

Le #gloss(url:"https://memoryleakersteam.github.io/glossario#pull-request")[pull request] verso il _Main_ e _Develop_ possono essere approvate solo da un #gloss(url: "https://memoryleakersteam.github.io/glossario#verificatore")[verificatore], in seguito al soddisfacimento della #gloss(url:"https://memoryleakersteam.github.io/glossario#definition-of-done")[Definition of Done].

= Pratiche di lavoro

Questa sezione è dedicata a come il team organizza e gestisce il lavoro nel corso del tempo.

== Calendario e metodo pre-aggiudicazione

Il team riserva questo periodo alla sperimentazione e ricerca di un metodo di lavoro efficace al coordinamento e raggiungimento degli obiettivi prefissati: la cadenza degli incontri è stabilita a necessità, prediligendo ampio dialogo tra tutti i membri, garantendo coesione tra il team in merito alle decisioni perseverate.

== Calendario e metodo post-aggiudicazione

Il team adotta una metodologia #gloss(url: "https://memoryleakersteam.github.io/glossario#agile")[agile], individuando il martedì (14.00 -- 15.00) come svolgimento della #gloss(url: "https://memoryleakersteam.github.io/glossario#sprint-retrospective")[Sprint Retrospective], inizialmente a cadenza bisettimanale e successivamente (a data da destinarsi) settimanale. Bisettimanalmente, coincidente con la Sprint Retrospective, avviene la rotazione dei ruoli all'interno del team. L'incontro presenta la seguente struttura:

- 14.00 -- 14.30 discussione e recap sullo #gloss(url: "https://memoryleakersteam.github.io/glossario#sprint")[sprint] precedente;
- 14.30 -- 15.00 rotazione dei ruoli, discussione dello sprint successivo e assegnazione delle task tra i componenti.

Prima di ogni Sprint Retrospective:

- ogni membro compila il calendario indicando gli slot ore disponibili per la settimana a venire (entro il sabato precedente).

Durante ogni sprint i membri del gruppo si impegnano a riferire tempestivamente al responsabile difficoltà non previste nello svolgimento dello sprint; il responsabile si impegna a comunicare il prima possibile le contromisure da applicare al team.
