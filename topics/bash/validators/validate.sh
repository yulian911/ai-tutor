#!/usr/bin/env bash
# Validator dla zadań Bash
set -euo pipefail

SCRIPT_FILE="${1:-script.sh}"
RESULT_FILE="${2:-validation-result.txt}"
: > "$RESULT_FILE"
PASS=0
FAIL=0

run_check() {
  local name="$1"
  shift
  echo "== $name ==" >> "$RESULT_FILE"
  if "$@" >> "$RESULT_FILE" 2>&1; then
    echo "PASS" >> "$RESULT_FILE"
    PASS=$((PASS + 1))
  else
    echo "FAIL" >> "$RESULT_FILE"
    FAIL=$((FAIL + 1))
  fi
  echo >> "$RESULT_FILE"
}

echo "=== Bash Validator ===" >> "$RESULT_FILE"
echo "Script: $SCRIPT_FILE" >> "$RESULT_FILE"
echo "Date: $(date -u +%Y-%m-%dT%H:%M:%SZ)" >> "$RESULT_FILE"
echo >> "$RESULT_FILE"

# Sprawdź czy plik istnieje
echo "== File exists ==" >> "$RESULT_FILE"
if [[ -f "$SCRIPT_FILE" ]]; then
  echo "PASS" >> "$RESULT_FILE"
  PASS=$((PASS + 1))
else
  echo "FAIL — $SCRIPT_FILE not found" >> "$RESULT_FILE"
  FAIL=$((FAIL + 1))
  echo >> "$RESULT_FILE"
  echo "=== Summary ===" >> "$RESULT_FILE"
  echo "PASSED: $PASS / FAILED: $FAIL" >> "$RESULT_FILE"
  cat "$RESULT_FILE"
  exit 1
fi
echo >> "$RESULT_FILE"

# Sprawdź shebang
echo "== Shebang ==" >> "$RESULT_FILE"
first_line=$(head -1 "$SCRIPT_FILE")
if [[ "$first_line" == "#!/usr/bin/env bash" || "$first_line" == "#!/bin/bash" ]]; then
  echo "PASS — $first_line" >> "$RESULT_FILE"
  PASS=$((PASS + 1))
else
  echo "FAIL — missing or incorrect shebang: '$first_line'" >> "$RESULT_FILE"
  FAIL=$((FAIL + 1))
fi
echo >> "$RESULT_FILE"

# Sprawdź set -euo pipefail
echo "== set -euo pipefail ==" >> "$RESULT_FILE"
if grep -q 'set -euo pipefail\|set -e.*-u.*-o pipefail' "$SCRIPT_FILE"; then
  echo "PASS" >> "$RESULT_FILE"
  PASS=$((PASS + 1))
else
  echo "FAIL — missing 'set -euo pipefail'" >> "$RESULT_FILE"
  FAIL=$((FAIL + 1))
fi
echo >> "$RESULT_FILE"

# Shellcheck
echo "== shellcheck ==" >> "$RESULT_FILE"
if command -v shellcheck &>/dev/null; then
  run_check "shellcheck" shellcheck "$SCRIPT_FILE"
else
  echo "SKIP — shellcheck not installed" >> "$RESULT_FILE"
  echo >> "$RESULT_FILE"
fi

# Sprawdź syntax bash
run_check "bash syntax check" bash -n "$SCRIPT_FILE"

# Sprawdź czy jest wykonywalny
echo "== Executable bit ==" >> "$RESULT_FILE"
if [[ -x "$SCRIPT_FILE" ]]; then
  echo "PASS" >> "$RESULT_FILE"
  PASS=$((PASS + 1))
else
  echo "WARN — script is not executable (chmod +x)" >> "$RESULT_FILE"
fi
echo >> "$RESULT_FILE"

echo "=== Summary ===" >> "$RESULT_FILE"
echo "PASSED: $PASS" >> "$RESULT_FILE"
echo "FAILED: $FAIL" >> "$RESULT_FILE"

cat "$RESULT_FILE"

[[ "$FAIL" -eq 0 ]]
