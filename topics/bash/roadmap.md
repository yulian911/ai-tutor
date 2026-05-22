# Bash — Roadmap projektowa

## Projekt: ops-toolkit

Zestaw skryptów operacyjnych dla środowiska Linux/AWS. Każdy etap dodaje nowe narzędzie do toolkitu.

## Etapy projektu

| Etap | Nazwa | Poziom | Status |
|------|-------|--------|--------|
| 1 | Log parser i raport | junior | ⏳ aktualny |
| 2 | CSV data processor | junior | — |
| 3 | System health check | junior+ | — |
| 4 | Backup i archiwizacja | junior+ | — |
| 5 | Deploy script z rollbackiem | junior+ | — |
| 6 | AWS resource audit | mid-ready | — |
| 7 | Monitoring alerter (cron-ready) | mid-ready | — |
| 8 | Toolkit CLI z menu i helpem | project-capstone | — |

## Szczegóły etapów

### Etap 1 — Log parser i raport
**Cel:** Parsuj logi nginx, generuj raport tekstowy.
**Input:** `logs/access.log` (format Combined Log Format)
**Output:** `reports/report-YYYYMMDD.txt`
**Umiejętności:** `awk`, `grep`, `sort`, `uniq`, `wc`, exit codes

### Etap 2 — CSV data processor
**Cel:** Przetworz plik CSV z danymi, filtruj i agreguj.
**Input:** `data/inventory.csv`
**Output:** `output/summary.txt`, exit code 0/1
**Umiejętności:** `awk`, `IFS`, tablice asocjacyjne, walidacja wejścia

### Etap 3 — System health check
**Cel:** Sprawdź CPU, pamięć, dysk, procesy i wyślij raport.
**Checks:** disk > 80%, memory > 90%, CPU load avg, kluczowe procesy
**Umiejętności:** `/proc`, `df`, `free`, `top`, `pgrep`, funkcje

### Etap 4 — Backup i archiwizacja
**Cel:** Backup katalogu z rotacją (zachowaj 7 dni).
**Input:** ścieżka katalogu jako argument
**Output:** `backups/backup-YYYYMMDD.tar.gz`
**Umiejętności:** `tar`, `find -mtime`, rotacja plików, locking (flock)

### Etap 5 — Deploy script z rollbackiem
**Cel:** Deploy aplikacji z możliwością rollbacku przy błędzie.
**Etapy:** stop → backup → deploy → verify → rollback jeśli fail
**Umiejętności:** trap, rollback pattern, funkcje, timeouty

### Etap 6 — AWS resource audit
**Cel:** Skrypt audytu zasobów AWS (EC2, S3, Security Groups).
**Wymagania:** AWS CLI, jq, output CSV lub JSON
**Umiejętności:** `aws cli`, `jq`, parsowanie JSON, parallel execution

### Etap 7 — Monitoring alerter
**Cel:** Skrypt do uruchamiania z crona — sprawdza metryki i wysyła alerty.
**Output:** log do pliku + opcjonalne powiadomienie
**Umiejętności:** idempotentność, lockfile, cron-safe, structured logging

### Etap 8 — Toolkit CLI
**Cel:** Ujednolicony interfejs CLI z menu, --help, subkomendami.
**Umiejętności:** getopts/getopt, sourcing, modularność, dokumentacja

## Konwencje projektu

- Zawsze `set -euo pipefail`
- Logi do stderr, dane do stdout
- Exit codes: 0 sukces, 1 błąd użytkownika, 2 błąd systemu
- Pliki wykonywalne: `chmod +x`, shebang `#!/usr/bin/env bash`
- Testy: `shellcheck` musi przechodzić bez błędów
