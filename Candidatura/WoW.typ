#import "DocumentiGenerici.typ": *

#show: documento.with(
  titolo: "Way of Working",
  sottotitolo: "",
  tipo-documento: "Documento Interno",
  versione: "1.0.0",
  autore: "Riccardo Peresson",
  verificatore: "Chiara Protopapa",
  stato: "In revisione",
  file-nome: "Way_Of_Working.pdf",
  registro-modifiche: (
    ([0.0.1], [24/10/2026], [Prima stesura], [Riccardo Peresson], [Chiara Protopapa]),
    ([1.0.0], [25/10/2026], [Aggiunta link a glossario], [Riccardo Peresson], [Chiara Protopapa])
  ),
)

#set heading(numbering: "1.1.1")

= Scopo del documento

Il seguente documento definisce in modo chiaro e univoco l'insieme di strumenti, convenzioni e procedure (#gloss(url:"https://memoryleakersteam.github.io/glossario#way-of-working")[Way of Working]) che il team Memory Leakers adotta per lo sviluppo del #gloss(url: "https://memoryleakersteam.github.io/glossario#progetto")[progetto] assegnato.

N.B: le parole con pedice #sub[G] sono dotate di link di rimando alla relativa voce nel #gloss(url:"https://memoryleakersteam.github.io/glossario#progetto")[Glossario], disponibile sul sito web del team.

= Stack di lavoro

Di seguito le tecnologie adottate dal team.

== Comunicazione

Per le comunicazioni interne:

- _Google Meet_#footnote[#link("https://meet.google.com/home")], riunioni da remoto;
- _WhatsApp_#footnote[#link("https://www.whatsapp.com/?lang=it")], comunicazioni rapide e informali;
- _Telegram_#footnote[#link("https://telegram.org/")], comunicazioni strutturate e formali; nel dettaglio si dispone dei canali:
  - Riunioni interne,
  - Riunioni esterne,
  - Candidatura,
  - Link Utili.

Per le comunicazioni esterne:

- _Gmail_#footnote[#link("https://workspace.google.com/intl/it/gmail/")], attraverso l'indirizzo *#link("mailto:memoryleakersteam@gmail.com")[memoryleakersteam\@gmail.com]*.

== Organizzazione del lavoro

- _GitHub Projects_#footnote[#link("https://docs.github.com/en/issues/planning-and-tracking-with-projects/learning-about-projects/about-projects")], task, planning, calendario e timesheet;

== Repository

- _GitHub_#footnote[#link("https://github.com/")], versionamento, pipeline (GitHub Actions) e knowledge (Wiki).

== Altri strumenti

- _Typst_#footnote[#link("https://typst.app/home")], documentazione;
- Da definire, diagrammi UML;
- _Google Presentazioni_#footnote[#link("https://docs.google.com/presentation/u/0/")], per le slide da utilizzare durante i diari di bordo.

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

- _Main_ contiene la versione stabile del codice;
- _Develop_ è il ramo di integrazione, raccoglie i branch di lavoro prima di essere approvati al _Main_.

=== Issue

Ogni #gloss(url: "https://memoryleakersteam.github.io/glossario#issues")[issue] va lavorata in un branch dedicato dal ramo _Develop_, e il nome indica il tipo di modifica (lo stesso prefisso dei commit): _fix/_, _docs/_ e così via. Il branch ha una vita massima di 3 giorni: deve essere chiuso o eliminato entro questo termine, per evitare branch dimenticati e divergenze troppo grandi rispetto al ramo principale.

=== Pull request

Le #gloss(url:"https://memoryleakersteam.github.io/glossario#pull-request")[pull request] verso il _Main_ possono essere approvate solo da un #gloss(url: "https://memoryleakersteam.github.io/glossario#verificatore")[verificatore], e devono provenire da _Develop_ (e non da un suo sotto-branch), in seguito al soddisfacimento della #gloss(url:"https://memoryleakersteam.github.io/glossario#definition-of-done")[Definition of Done].

= Pratiche di lavoro

Questa sezione è dedicata a come il team organizza e gestisce il lavoro nel corso del tempo.

== Calendario e metodo pre-aggiudicazione

Il team riserva questo periodo alla sperimentazione e ricerca di un metodo di lavoro efficace al coordinamento e raggiungimento degli obiettivi prefissati: la cadenza degli incontri è stabilita a necessità, prediligendo ampio dialogo tra tutti i membri, garantendo coesione tra il team in merito alle decisioni perseverate.

== Calendario e metodo post-aggiudicazione

Il team adotta una metodologia #gloss(url: "https://memoryleakersteam.github.io/glossario#agile")[agile], individuando il martedì (14.00 -- 15.00) come svolgimento della #gloss(url: "https://memoryleakersteam.github.io/glossario#sprint-retrospective")[Sprint Retrospective], inizialmente a cadenza bisettimanale e successivamente (a data da destinarsi) settimanale. Bisettimanalmente, coincidente con la #gloss(url: "https://memoryleakersteam.github.io/glossario#sprint-retrospective")[Sprint Retrospective], avviene la rotazione dei ruoli all'interno del team, predeterminata e nota in anticipo a tutti i membri. L'incontro presenta la seguente struttura:

- 14.00 -- 14.45 discussione e recap sullo #gloss(url: "https://memoryleakersteam.github.io/glossario#sprint")[sprint] precedente, guidata dal responsabile (uscente se rotazione avvenuta);
- 14.45 -- 15.00 discussione e commento sullo sprint successivo, guidata dal responsabile (entrante se rotazione avvenuta).

Prima di ogni #gloss(url: "https://memoryleakersteam.github.io/glossario#sprint-retrospective")[Sprint Retrospective]:

- ogni membro compila il calendario indicando gli slot ore disponibili per la settimana a venire (entro il sabato precedente);
- il responsabile (entrante se immediatamente precedente alla rotazione dei ruoli) assegna le task al team per lo sprint successivo (entro la #gloss(url: "https://memoryleakersteam.github.io/glossario#sprint-retrospective")[Sprint Retrospective]).

Durante ogni #gloss(url: "https://memoryleakersteam.github.io/glossario#sprint")[sprint] i membri del gruppo si impegnano a riferire tempestivamente al responsabile difficoltà non previste nello svolgimento dello #gloss(url: "https://memoryleakersteam.github.io/glossario#sprint")[sprint]; il responsabile si impegna a comunicare il prima possibile le contromisure da applicare al team.
