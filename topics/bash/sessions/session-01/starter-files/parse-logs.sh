#!/usr/bin/env bash
# parse-logs.sh — daily nginx access log report generator
# Usage: ./parse-logs.sh <path-to-access.log>

set -euo pipefail

# TODO: sprawdź czy podano argument ($1)
# Jeśli nie — wypisz "Usage: $0 <log-file>" na stderr i wyjdź z exit code 1

LOG_FILE="${1:-}"

# TODO: sprawdź czy LOG_FILE istnieje i nie jest pusty
# Użyj: [[ -f "$LOG_FILE" ]] i [[ -s "$LOG_FILE" ]]
# Jeśli nie — wypisz komunikat na stderr i wyjdź z exit code 1

# TODO: utwórz katalog reports jeśli nie istnieje
REPORT_DIR="reports"
REPORT_FILE="$REPORT_DIR/report-$(date +%Y%m%d).txt"

# --- Obliczenia ---

# TODO: policz łączną liczbę requestów (linii w pliku)
# TOTAL_REQUESTS=

# TODO: policz unikalne IP (kolumna $1 w awk)
# UNIQUE_IPS=

# TODO: policz błędy 4xx (kolumna $9 zaczyna się od 4)
# ERRORS_4XX=

# TODO: policz błędy 5xx (kolumna $9 zaczyna się od 5)
# ERRORS_5XX=

# TODO: wyciągnij top 5 URL-i (kolumna $7), posortowane malejąco po liczbie wystąpień
# Użyj: awk '{print $7}' | sort | uniq -c | sort -rn | head -5
# Zapisz do zmiennej lub pliku tymczasowego

# --- Generowanie raportu ---

# TODO: zapisz raport do $REPORT_FILE
# Format zgodny z task.md:
# === Nginx Access Log Report ===
# Date: $(date +%Y-%m-%d)
# Log file: $LOG_FILE
# Total requests: $TOTAL_REQUESTS
# Unique IPs: $UNIQUE_IPS
# Error requests (4xx): $ERRORS_4XX
# Error requests (5xx): $ERRORS_5XX
#
# Top 5 URLs:
#   1. /path    (N requests)
#   ...

# TODO: wypisz ścieżkę do raportu na stdout
# echo "Report saved to: $REPORT_FILE"
