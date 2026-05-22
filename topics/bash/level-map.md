# Bash — Level Map

## junior

**Wymagania wejściowe:**
- Zna podstawy: zmienne, `if`, `for`, `while`
- Wie co robi `set -euo pipefail`
- Zna podstawowe komendy: `grep`, `awk`, `sed`, `find`

**Charakter zadań:**
- Jeden skrypt, jedno zadanie
- Dane wejściowe dostarczone (pliki, argumenty)
- Jasno opisane wymagania krok po kroku

**Kryteria zaliczenia:**
- `shellcheck` bez błędów ERROR i WARNING
- `set -euo pipefail` na początku
- Poprawny exit code (0 / 1)
- Skrypt nie crashuje na typowych błędach wejścia

---

## junior+

**Wymagania wejściowe:**
- Zaliczone etapy poziomu `junior`
- Zna funkcje, `trap`, tablice, `getopts`

**Charakter zadań:**
- Funkcje zamiast powtarzającego się kodu
- Obsługa błędów (trap, rollback)
- Logi do stderr, dane do stdout
- Walidacja argumentów wejściowych

**Kryteria zaliczenia:**
- Funkcje z lokalnymi zmiennymi (`local`)
- `trap` dla cleanup przy błędzie
- Sensowne komunikaty błędu do stderr
- Skrypt daje się używać w cron (idempotentny)

---

## mid-ready

**Wymagania wejściowe:**
- Zaliczone `junior+`
- Zna AWS CLI, `jq`, parallel execution

**Charakter zadań:**
- Skrypty wieloplikowe z sourcingiem
- Integracja z zewnętrznymi API/CLI
- Structured logging, lockfile
- Testowanie zachowania przy błędach

---

## project-capstone

**Wymagania wejściowe:**
- Zaliczone `mid-ready`

**Charakter zadań:**
- Pełny toolkit CLI z subkomendami i --help
- Dokumentacja inline i man-page style
- Test suite (BATS lub ręczny)
- Code review cudzego skryptu
