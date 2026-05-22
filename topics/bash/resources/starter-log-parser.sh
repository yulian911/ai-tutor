#!/usr/bin/env bash
# Starter file — przykład: parser logów nginx
# Poziom: junior
#
# Wymagania:
# 1. Przyjmij ścieżkę do pliku logów jako $1 (obowiązkowy argument)
# 2. Sprawdź czy plik istnieje i nie jest pusty
# 3. Policz łączną liczbę requestów
# 4. Policz liczbę unikalnych adresów IP
# 5. Znajdź top 5 najczęściej odwiedzanych URL-i
# 6. Policz błędy (kody 4xx i 5xx)
# 7. Zapisz raport do pliku reports/report-YYYYMMDD.txt
# 8. Wypisz podsumowanie na stdout
# 9. Zwróć exit code 1 jeśli plik nie istnieje lub jest pusty

set -euo pipefail

# TODO: sprawdź czy podano argument
# TODO: przypisz ścieżkę logu do zmiennej
LOG_FILE="${1:-}"

# TODO: sprawdź czy plik istnieje i nie jest pusty

# TODO: utwórz katalog reports jeśli nie istnieje

REPORT_FILE="reports/report-$(date +%Y%m%d).txt"

# TODO: policz łączną liczbę linii (requestów)

# TODO: policz unikalne IP (kolumna 1 w access.log)

# TODO: wyciągnij top 5 URL-i (kolumna 7 w access.log)

# TODO: policz błędy — kody zaczynające się od 4 lub 5 (kolumna 9)

# TODO: zapisz raport do $REPORT_FILE
# Format raportu:
# === Nginx Access Log Report ===
# Date: ...
# Log file: ...
# Total requests: ...
# Unique IPs: ...
# Error requests (4xx/5xx): ...
# Top 5 URLs:
#   1. /path (N requests)
#   ...

# TODO: wypisz podsumowanie na stdout
echo "Report saved to: $REPORT_FILE"
