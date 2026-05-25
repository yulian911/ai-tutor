# Standardy taska

Każdy wygenerowany task musi zawierać **wszystkie** poniższe sekcje. Żadna nie może być pusta.

## Wymagane sekcje task.md

- `typ` — jeden z: `exercise` | `work-ticket` | `bugfix` | `code-review` | `incident` | `interview` | `legacy-migration`
- `poziom` — jeden z: `junior` | `junior+` | `mid-ready` | `project-capstone`
- `temat` — np. `terraform`, `bash`, `ansible`
- `etap projektu` — z `roadmap.md` danego tematu
- `kontekst` — opis sytuacji biznesowej/technicznej
- `cel` — co użytkownik ma osiągnąć
- `dane wejściowe` — wszystkie potrzebne dane (nie może ich brakować)
- `pliki do użycia` — lista plików starter
- `lista wymagań` — ponumerowane, testowalne wymagania
- `ograniczenia` — czego nie wolno robić
- `definition of done` — kiedy zadanie jest ukończone
- `najczęstsze błędy` — 3–5 typowych pomyłek
- `tip produkcyjny` — praktyczna wskazówka z realiów pracy
- `wskazówka do rozmowy technicznej` — jak mówić o tym zagadnieniu na rekrutacji

## Typy tasków — kiedy używać

Preferuj realistyczne scenariusze pracy:

| Typ | Użyj gdy |
|-----|----------|
| `work-ticket` | Nowa funkcjonalność w infrastrukturze |
| `bugfix` | Naprawa istniejącego kodu/konfiguracji |
| `incident` | Diagnoza i naprawa incydentu |
| `code-review` | Ocena cudzego kodu/konfiguracji |
| `exercise` | Nauka izolowanego konceptu |
| `interview` | Przygotowanie do rozmowy technicznej |
| `legacy-migration` | Modernizacja starszego podejścia |

## Starter files

Zawsze twórz pliki z komentarzami `# TODO:`. Użytkownik nie może zgadywać co napisać.

Minimalne zestawy per technologia:

| Technologia | Pliki |
|-------------|-------|
| Terraform | `main.tf`, `variables.tf`, `outputs.tf`, `terraform.tfvars` |
| Ansible | `playbook.yml`, `inventory.ini` |
| Bash | `script.sh` (wymaga `set -euo pipefail` na początku) |
| Kubernetes | `deployment.yaml`, `service.yaml` |
| Docker | `Dockerfile` |
| CI/CD | `.github/workflows/ci.yml` |
