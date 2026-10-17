#!/usr/bin/env bash
# ---------------------------------------------------------------------
#  Compila tutti i documenti .typ del repository in PDF.
#  - Esclude la cartella Templates/
#  - I PDF finiscono in pdf/ mantenendo la stessa struttura di cartelle:
#      Candidatura/Verbali_interni/2026-10-13.typ
#        → pdf/Candidatura/Verbali_interni/2026-10-13.pdf
#  - Genera pdf/elenco.json con la lista dei PDF (utile al sito)
#
# ---------------------------------------------------------------------
set -euo pipefail

OUT="pdf"
rm -rf "$OUT"
mkdir -p "$OUT"

errori=0
while IFS= read -r -d '' file; do
  rel="${file#./}"
  dest="$OUT/${rel%.typ}.pdf"
  mkdir -p "$(dirname "$dest")"
  echo "▶ $rel"
  # Data del PDF = data dell'ultimo commit del file: così un PDF
  # cambia (e viene ripubblicato) solo se il suo sorgente è cambiato
  ts="$(git log -1 --format=%ct -- "$rel" 2>/dev/null || true)"
  if ! SOURCE_DATE_EPOCH="${ts:-$(date +%s)}" typst compile --root . "${FONT_ARGS[@]}" "$rel" "$dest"; then
    echo "✖ Errore nella compilazione di $rel"
    errori=$((errori + 1))
  fi
done < <(find . -name '*.typ' -not -path './Templates/*' -not -path "./$OUT/*" -not -path './.git/*' -print0 | sort -z)

# Elenco dei PDF in formato JSON: [{ "percorso": ..., "cartella": ..., "nome": ... }]
(
  cd "$OUT"
  echo "["
  first=1
  while IFS= read -r -d '' pdf; do
    p="${pdf#./}"
    [ $first -eq 1 ] && first=0 || echo ","
    printf '  {"percorso": "%s", "cartella": "%s", "nome": "%s"}' \
      "$p" "$(dirname "$p")" "$(basename "$p" .pdf)"
  done < <(find . -name '*.pdf' -print0 | sort -z)
  echo
  echo "]"
) > "$OUT/elenco.json"

if [ "$errori" -gt 0 ]; then
  echo "✖ $errori documento/i non compilato/i"
  exit 1
fi
echo "✔ Tutti i documenti compilati in $OUT/"