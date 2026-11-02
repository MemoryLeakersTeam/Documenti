[![Compila PDF](https://github.com/MemoryLeakersTeam/Documenti/actions/workflows/compila-pdf.yml/badge.svg)](https://github.com/MemoryLeakersTeam/Documenti/actions/workflows/compila-pdf.yml)
# Memory Leakers
Siamo il gruppo 3 del progetto di Ingegneria del Software del corso di laurea in Informatica dell'Università degli Studi di Padova per l'anno accademico 2026/27.

## Documenti
Questa repository raccoglie e organizza i documenti prodotti dal gruppo durante le fasi dello sviluppo del progetto didattico.

### Formato
Il gruppo ha deciso di utilizzare ***Typst*** come formato per il codice sorgente dei documenti (`.typ`).

### PDF più recenti
I documenti approvati vengono pubblicati da soli sul [sito del gruppo](https://memoryleakersteam.github.io) a ogni push su `main`:
- solo i documenti con `stato: "Approvato"`;
- i verbali esterni solo quando c'è la versione firmata (`*-signed.pdf`, committata accanto al sorgente);
- un PDF già pubblicato viene sostituito solo quando cambia la sua `versione`.

Tutti i PDF, anche quelli non ancora approvati, sono nell'artifact `pdf` dell'[ultima compilazione riuscita](https://github.com/MemoryLeakersTeam/Documenti/actions/workflows/compila-pdf.yml?query=branch%3Amain+is%3Asuccess).

### Struttura
I documenti stanno in `<Tappa>/<Cartella>/` (per esempio `Candidatura/Verbali_interni/2026-10-13.typ`). Le cartelle riconosciute dal sito sono `Verbali_interni`, `Verbali_esterni`, `Generali` e `Diario_di_bordo` (PDF committati delle presentazioni). Nei verbali esterni va indicata l'`azienda`, usata per il nome sul sito.
