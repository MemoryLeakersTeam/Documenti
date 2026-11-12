// Dati di un documento gestiti dall'automazione del registro delle modifiche
// (Scripts/registro.py), letti dal file accanto al sorgente con yaml("<nome>.yml").
// Comune a DocumentiGenerici.typ e Verbali.typ.

// Restituisce (versione, stato, verificatore, firma-responsabile, registro-modifiche),
// con il registro già nella forma delle righe della tabella:
// (Ver., Data, Descrizione, Autore, Verificatore)
#let campi-dati(dati) = (
  dati.versione,
  dati.stato,
  dati.verificatore,
  dati.firma-responsabile,
  dati.registro.map(r => (r.versione, r.data, r.descrizione, r.autore, r.verificatore)),
)
