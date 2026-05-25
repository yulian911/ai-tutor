# Starter Template — Bash

## script.sh

Szablon dla skryptów bash. **WYMÓG:** `set -euo pipefail` na początku.

```bash
#!/bin/bash
set -euo pipefail

# TODO: dodaj opis skryptu (co robi, jakie parametry)

# TODO: zdefiniuj zmienne
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_FILE="$SCRIPT_DIR/script.log"

# TODO: dodaj funkcje (jeśli trzeba)
# function validate() {
#   echo "Validating..."
# }

# TODO: dodaj główną logikę
echo "TODO: Implement script logic"

# TODO: obsługa błędów — co zrobić jeśli coś pójdzie nie tak
# trap 'echo "Error on line $LINENO"; exit 1' ERR
```

## Wymagania

- `set -euo pipefail` na początku każdego skryptu
- Opisowe zmienne
- Funkcje dla logiki powtarzanej
- Error handling (`trap` lub explicit checks)
- Logging (opcjonalnie)

## Przykład pełnego skryptu

```bash
#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_FILE="$SCRIPT_DIR/deployment.log"

function log() {
  echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOG_FILE"
}

function validate_input() {
  if [[ -z "${1:-}" ]]; then
    echo "Usage: $0 <environment>"
    exit 1
  fi
}

function deploy() {
  local env="$1"
  log "Deploying to $env..."
  # TODO: implementuj deployment
}

trap 'log "Error on line $LINENO"; exit 1' ERR

validate_input "$@"
deploy "$1"
log "Deployment complete"
```
