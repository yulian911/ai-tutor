#!/usr/bin/env bash
# process-inventory.sh — CSV inventory report generator
# Usage: ./process-inventory.sh <inventory.csv> [output-dir]

set -euo pipefail

# TODO: sprawdź argumenty
CSV_FILE="${1:-}"
OUTPUT_DIR="${2:-output}"

# TODO: sprawdź czy CSV_FILE podane i istnieje

# TODO: utwórz OUTPUT_DIR
SUMMARY_FILE="$OUTPUT_DIR/summary.txt"
ERRORS_FILE="$OUTPUT_DIR/errors.txt"

# Zainicjuj struktury danych
declare -A qty_by_cat
declare -A val_by_cat
error_count=0
line_num=0

# TODO: wyczyść pliki wyjściowe (: > "$SUMMARY_FILE" itd.)

# TODO: przetwarzaj CSV linia po linii
# while IFS=',' read -r id name category quantity price; do
#   line_num=$((line_num + 1))
#
#   # pomiń nagłówek (line_num == 1)
#
#   # waliduj quantity — czy to liczba całkowita > 0?
#   # waliduj price — czy to liczba > 0 (float ok)?
#   # Wskazówka: [[ "$quantity" =~ ^[0-9]+$ ]] dla integer
#   #            [[ "$price" =~ ^[0-9]+(\.[0-9]+)?$ ]] dla float
#
#   # jeśli błąd — zapisz do errors.txt, zwiększ error_count, continue
#
#   # jeśli ok — dodaj do tablic asocjacyjnych
#   # qty_by_cat["$category"]=$((${qty_by_cat["$category"]:-0} + quantity))
#   # Floaty przez awk: val_by_cat["$category"]=$(awk "BEGIN{print ${val_by_cat["$category"]:-0}+$price*$quantity}")
#
# done < "$CSV_FILE"

# TODO: wygeneruj summary.txt
# Nagłówek:
# === Inventory Summary ===
# Generated: $(date +%Y-%m-%d)
# (pusta linia)
# Category             | Total Qty | Total Value (USD)
# ---------------------+-----------+------------------
# Dane (posortowane: for cat in $(echo "${!qty_by_cat[@]}" | tr ' ' '\n' | sort); do)
# (pusta linia)
# Total items: N categories, M units, USD X.XX

# TODO: wygeneruj nagłówek errors.txt jeśli są błędy

# TODO: wypisz podsumowanie na stdout
echo "Summary: $SUMMARY_FILE"
[[ -s "$ERRORS_FILE" ]] && echo "Errors:  $ERRORS_FILE"

# TODO: zwróć exit code 1 jeśli były błędy
# [[ "$error_count" -eq 0 ]]
