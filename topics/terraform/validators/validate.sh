#!/usr/bin/env bash
# Validator dla zadań Terraform
set -euo pipefail

RESULT_FILE="${1:-validation-result.txt}"
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

check_required_files() {
  local name="$1"
  shift
  echo "== $name ==" >> "$RESULT_FILE"
  local all_ok=true
  for f in "$@"; do
    if [[ -f "$f" ]]; then
      echo "  OK: $f" >> "$RESULT_FILE"
    else
      echo "  MISSING: $f" >> "$RESULT_FILE"
      all_ok=false
    fi
  done
  if $all_ok; then
    echo "PASS" >> "$RESULT_FILE"
    PASS=$((PASS + 1))
  else
    echo "FAIL" >> "$RESULT_FILE"
    FAIL=$((FAIL + 1))
  fi
  echo >> "$RESULT_FILE"
}

echo "=== Terraform Validator ===" >> "$RESULT_FILE"
echo "Date: $(date -u +%Y-%m-%dT%H:%M:%SZ)" >> "$RESULT_FILE"
echo >> "$RESULT_FILE"

# Sprawdź wymagane pliki
check_required_files "Required files" main.tf variables.tf outputs.tf

# Sprawdź formatowanie
if command -v terraform &>/dev/null; then
  run_check "terraform fmt" terraform fmt -check -diff
  run_check "terraform validate" terraform validate
else
  echo "== terraform fmt ==" >> "$RESULT_FILE"
  echo "SKIP — terraform not installed" >> "$RESULT_FILE"
  echo >> "$RESULT_FILE"
fi

# Sprawdź czy nie ma hardcode wartości (prymitywna heurystyka)
echo "== Hardcode check ==" >> "$RESULT_FILE"
if grep -rn 'ami-[0-9a-f]\{8,\}\|"10\.\|"172\.\|"192\.168' main.tf 2>/dev/null; then
  echo "WARNING: Possible hardcoded values found — consider using variables" >> "$RESULT_FILE"
else
  echo "OK: No obvious hardcoded values found" >> "$RESULT_FILE"
fi
echo >> "$RESULT_FILE"

# Sprawdź czy zmienne mają type i description
echo "== Variables quality check ==" >> "$RESULT_FILE"
if [[ -f variables.tf ]]; then
  missing_type=$(grep -c 'variable "' variables.tf 2>/dev/null || true)
  has_type=$(grep -c 'type\s*=' variables.tf 2>/dev/null || true)
  has_desc=$(grep -c 'description\s*=' variables.tf 2>/dev/null || true)
  echo "  Variables declared: $missing_type" >> "$RESULT_FILE"
  echo "  With type: $has_type" >> "$RESULT_FILE"
  echo "  With description: $has_desc" >> "$RESULT_FILE"
  if [[ "$has_type" -ge "$missing_type" && "$has_desc" -ge "$missing_type" ]]; then
    echo "PASS" >> "$RESULT_FILE"
    PASS=$((PASS + 1))
  else
    echo "WARN — some variables missing type or description" >> "$RESULT_FILE"
  fi
else
  echo "SKIP — variables.tf not found" >> "$RESULT_FILE"
fi
echo >> "$RESULT_FILE"

echo "=== Summary ===" >> "$RESULT_FILE"
echo "PASSED: $PASS" >> "$RESULT_FILE"
echo "FAILED: $FAIL" >> "$RESULT_FILE"

cat "$RESULT_FILE"

[[ "$FAIL" -eq 0 ]]
