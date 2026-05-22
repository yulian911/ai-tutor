#!/usr/bin/env bash
# Starter file — przykład: procesor pliku CSV
# Poziom: junior+
#
# Wymagania:
# 1. Przyjmij plik CSV jako $1 i katalog wyjściowy jako $2
# 2. Plik CSV: id,name,category,quantity,price (pierwsza linia = nagłówek)
# 3. Pomiń nagłówek przy przetwarzaniu
# 4. Waliduj: sprawdź czy quantity > 0 i price > 0
# 5. Agreguj: suma quantity i wartości (quantity*price) per kategoria
# 6. Zapisz wynik do output/summary.txt (posortowane wg kategorii)
# 7. Zlicz błędne wiersze i zapisz je do output/errors.txt
# 8. Exit code 0 jeśli nie ma błędów, 1 jeśli są błędne wiersze

set -euo pipefail

# TODO: sprawdź argumenty (wymagane: $1 plik CSV, $2 katalog output)

CSV_FILE="${1:-}"
OUTPUT_DIR="${2:-output}"

# TODO: sprawdź czy plik CSV istnieje

# TODO: utwórz katalog output jeśli nie istnieje

SUMMARY_FILE="$OUTPUT_DIR/summary.txt"
ERRORS_FILE="$OUTPUT_DIR/errors.txt"

# TODO: zainicjuj liczniki i tablice asocjacyjne dla kategorii
# declare -A qty_by_category
# declare -A val_by_category
# error_count=0

# TODO: przetwarzaj plik CSV linia po linii (pomijając nagłówek)
# IFS=',' read -r id name category quantity price

# TODO: dla każdej linii:
#   - sprawdź czy quantity i price są liczbami > 0
#   - jeśli błąd: zapisz do errors.txt, zwiększ error_count
#   - jeśli ok: dodaj do tablic asocjacyjnych

# TODO: zapisz summary.txt
# Format:
# === Inventory Summary ===
# Category       | Total Qty | Total Value
# ---------------+-----------+------------
# electronics    | 150       | 45000.00
# ...

# TODO: zwróć poprawny exit code
