---
name: refactor
description: 'Surgical code refactoring to improve maintainability without changing behavior. Covers extracting functions, renaming variables, breaking down god functions, improving type safety, eliminating code smells, and applying design patterns. Less drastic than repo-rebuilder; use for gradual improvements.'
license: MIT
---

# Refactor

Improve structure without changing behavior. One smell at a time — validate after each step.

## When to refactor

Trigger on concrete thresholds, not on "hard to read":

| Technology | Threshold |
|------------|-----------|
| Terraform | Moduł > 200 linii resource/data bloków; duplikaty resource bez `for_each`; hardcoded values zamiast variables |
| Ansible | Playbook > 50 tasków w jednym pliku; brak roles; duplikaty task bloków; restart inline zamiast handler |
| Bash | Skrypt > 100 linii bez podziału na funkcje; brak `set -euo pipefail`; `$1 $2` zamiast nazwanych zmiennych |
| Python | Funkcja > 50 linii; brak type hints w publicznym API; `except:` bez typu; global mutable state |
| JavaScript/TypeScript | Funkcja > 40 linii; callback hell zamiast async/await; `any` bez komentarza uzasadnienia |
| Go | Funkcja > 50 linii; zignorowany `error` (`_ =`); globalny stan; interface w tym samym pakiecie co implementacja |

## When NOT to refactor

- Kod który nie zmieni się ponownie — nie refaktoruj dla samego refaktoringu.
- Kod bez testu/walidatora — najpierw dodaj walidację, potem refaktoruj.
- W trakcie sesji z innym celem (work-ticket, bugfix) — oddziel commity.

---

## Terraform

**Smells i fix:**

- `count = N` z prawie identycznymi blokami → `for_each` z mapą
- Hardcoded region/account/AMI → variable lub `locals`
- Plik `main.tf` > 200 linii → wyciągnij moduł do `modules/<name>/`
- Zasoby przeniesione bez `moved {}` → ryzyko zniszczenia i re-create
- Brak `description` w `variable` i `output` → dodaj dla każdego

**Walidacja po refaktorze:**
```
terraform fmt -recursive
terraform validate
terraform plan   # diff powinien być pusty lub tylko metadata
```

---

## Ansible

**Smells i fix:**

- > 50 tasków w `playbook.yml` → wyciągnij `roles/<name>/tasks/main.yml`
- Hardcoded `vars` inline → przenieś do `group_vars/` lub `host_vars/`
- `service` restart jako oddzielny task → zamień na handler + `notify`
- Moduł bez FQCN (`copy:` zamiast `ansible.builtin.copy:`) → użyj FQCN
- Duplikat bloków tasków w kilku playbookach → wyciągnij do roli

**Walidacja po refaktorze:**
```
ansible-playbook --syntax-check playbook.yml -i inventory.ini
ansible-lint playbook.yml
ansible-playbook --check playbook.yml -i inventory.ini  # dry-run
```

---

## Bash

**Smells i fix:**

- Brak `set -euo pipefail` na górze → dodaj jako pierwszą linię (po shebang)
- `$1`, `$2` w ciele skryptu → nazwane zmienne: `local input_file="$1"`
- Skrypt > 100 linii bez funkcji → wyciągnij `function do_thing() { ... }`
- `if [ ]` zamiast `[[ ]]` → użyj `[[ ]]` (bash-specific, bezpieczniejsze)
- Brak obsługi błędów przy wywołaniach zewnętrznych → dodaj `|| { echo "..."; exit 1; }`

**Walidacja po refaktorze:**
```
shellcheck script.sh
bash -n script.sh
bash script.sh   # test z przykładowymi danymi
```

---

## Python

**Smells i fix:**

- Funkcja > 50 linii → wyciągnij pomocnicze funkcje z opisowymi nazwami
- Brak type hints w publicznym API → dodaj `def fn(x: int) -> str:`
- `except:` lub `except Exception:` bez logu → `except SomeError as e: logger.error(...)`
- Globalny stan mutowalny → przekaż przez parametry lub użyj klasy
- Długi `if/elif` chain na typie → rozważ `match` (Python 3.10+) lub dict dispatch

**Walidacja po refaktorze:**
```
python -m py_compile script.py
mypy script.py --strict       # jeśli projekt używa mypy
ruff check script.py          # lub pylint/flake8
pytest                        # jeśli istnieją testy
```

---

## JavaScript / TypeScript

**Smells i fix:**

- Funkcja > 40 linii → wyciągnij pomocnicze funkcje
- Callback hell → async/await z try/catch
- `any` bez komentarza → zastąp typem lub dodaj `// eslint-disable-next-line` z uzasadnieniem
- Duplikat logiki w wielu komponentach → wyciągnij hook lub utility
- Magic numbers (`* 0.15`) → nazwane stałe (`const VAT_RATE = 0.15`)

**Walidacja po refaktorze:**
```
tsc --noEmit          # TypeScript
eslint src/           # lint
npm test              # unit testy
```

---

## Go

**Smells i fix:**

- Zignorowany error (`_ = fn()`) → zawsze obsłuż lub zaloguj
- Funkcja > 50 linii → wyciągnij pomocnicze funkcje
- Interface zdefiniowany w tym samym pakiecie co jedyna implementacja → przenieś do pakietu konsumenta
- Globalny stan (`var db *sql.DB`) → przekaż przez struct
- Panic w bibliotece zamiast zwróconego error → zamień na `return nil, err`

**Walidacja po refaktorze:**
```
go vet ./...
go build ./...
go test ./...
staticcheck ./...   # jeśli zainstalowany
```

---

## Proces

1. Zidentyfikuj jeden konkretny smell (threshold z tabeli powyżej).
2. Zrób zmianę.
3. Uruchom walidator — musi przejść.
4. Zatwierdź lub zanotuj wynik zanim przejdziesz do kolejnego smella.

Nie mieszaj refaktoru z nową funkcjonalnością w tym samym kroku.
