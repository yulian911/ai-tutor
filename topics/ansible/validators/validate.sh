#!/usr/bin/env bash
# Validator dla zadań Ansible
set -euo pipefail

PLAYBOOK="${1:-playbook.yml}"
INVENTORY="${2:-inventory.ini}"
RESULT_FILE="${3:-validation-result.txt}"
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

echo "=== Ansible Validator ===" >> "$RESULT_FILE"
echo "Playbook: $PLAYBOOK" >> "$RESULT_FILE"
echo "Inventory: $INVENTORY" >> "$RESULT_FILE"
echo "Date: $(date -u +%Y-%m-%dT%H:%M:%SZ)" >> "$RESULT_FILE"
echo >> "$RESULT_FILE"

# Sprawdź pliki
echo "== Required files ==" >> "$RESULT_FILE"
all_ok=true
for f in "$PLAYBOOK" "$INVENTORY"; do
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

# YAML syntax check
echo "== YAML syntax ==" >> "$RESULT_FILE"
if command -v python3 &>/dev/null; then
  if python3 -c "import yaml; yaml.safe_load(open('$PLAYBOOK'))" >> "$RESULT_FILE" 2>&1; then
    echo "PASS" >> "$RESULT_FILE"
    PASS=$((PASS + 1))
  else
    echo "FAIL" >> "$RESULT_FILE"
    FAIL=$((FAIL + 1))
  fi
else
  echo "SKIP — python3 not available" >> "$RESULT_FILE"
fi
echo >> "$RESULT_FILE"

# ansible syntax check
if command -v ansible-playbook &>/dev/null; then
  run_check "ansible syntax-check" ansible-playbook --syntax-check "$PLAYBOOK" -i "$INVENTORY"
else
  echo "== ansible syntax-check ==" >> "$RESULT_FILE"
  echo "SKIP — ansible not installed" >> "$RESULT_FILE"
  echo >> "$RESULT_FILE"
fi

# ansible-lint
if command -v ansible-lint &>/dev/null; then
  run_check "ansible-lint" ansible-lint "$PLAYBOOK"
else
  echo "== ansible-lint ==" >> "$RESULT_FILE"
  echo "SKIP — ansible-lint not installed" >> "$RESULT_FILE"
  echo >> "$RESULT_FILE"
fi

# Sprawdź best practices
echo "== Best practices check ==" >> "$RESULT_FILE"
issues=0

# Sprawdź czy używa pełnych nazw modułów
if grep -n '^\s*apt:\|^\s*copy:\|^\s*service:\|^\s*file:\|^\s*template:\|^\s*command:\|^\s*shell:' "$PLAYBOOK" 2>/dev/null | grep -v 'ansible\.builtin'; then
  echo "  WARN: Consider using ansible.builtin.* module names" >> "$RESULT_FILE"
  issues=$((issues + 1))
fi

# Sprawdź czy nie ma hardcode haseł
if grep -in 'password:\s*[^{]' "$PLAYBOOK" 2>/dev/null | grep -v 'vault\|{{ '; then
  echo "  WARN: Possible hardcoded password found" >> "$RESULT_FILE"
  issues=$((issues + 1))
fi

if [[ "$issues" -eq 0 ]]; then
  echo "  No obvious issues found" >> "$RESULT_FILE"
  echo "PASS" >> "$RESULT_FILE"
  PASS=$((PASS + 1))
else
  echo "WARN — $issues issue(s) found" >> "$RESULT_FILE"
fi
echo >> "$RESULT_FILE"

echo "=== Summary ===" >> "$RESULT_FILE"
echo "PASSED: $PASS" >> "$RESULT_FILE"
echo "FAILED: $FAIL" >> "$RESULT_FILE"

cat "$RESULT_FILE"

[[ "$FAIL" -eq 0 ]]
