# Blueprint v1 — osobisty system nauki z Claude Skills

Ten system ma działać jak osobisty nauczyciel techniczny: planuje sesje, tworzy praktyczne zadania, przygotowuje pliki startowe, sprawdza wykonanie, zapisuje progres i pilnuje aktualności technologii [cite:25][cite:34][cite:57].

## Założenia

System ma przygotowywać do realnej pracy technicznej, więc zadania powinny być praktyczne, projektowe i oparte o rzeczywiste artefakty, takie jak `playbook.yml`, `script.sh`, `main.tf`, `deployment.yaml` czy workflow CI [cite:25][cite:34].

Każde zadanie powinno mieć pełny kontekst: dane wejściowe, nazwy zasobów, pliki pomocnicze, wymagania, kryteria zaliczenia i sposób sprawdzenia, żeby użytkownik nie musiał sam wymyślać brakujących danych [cite:57][cite:34].

Skills są najskuteczniejsze, gdy są modularne i wyspecjalizowane, dlatego system powinien być podzielony na kilka ról zamiast jednego dużego skilla do wszystkiego [cite:57][cite:25].

## Architektura systemu

Proponowany podział na 4 skille:

| Skill | Odpowiedzialność |
|---|---|
| `learning-orchestrator` | Wybiera temat, poziom, typ tasku, etap projektu i decyduje, co ćwiczyć dalej [cite:34][cite:57] |
| `task-generator` | Tworzy sesję, task, starter files, dane wejściowe oraz opcjonalne skrypty walidujące [cite:25][cite:74] |
| `solution-reviewer` | Sprawdza rozwiązanie według checklisty, uruchamia walidację i tworzy raport feedbackowy [cite:57][cite:74] |
| `progress-manager` | Aktualizuje progres, zapisuje słabe punkty, planuje powtórki i kolejne kroki [cite:34][cite:73] |

## Struktura katalogów

```txt
ai-tutor/
├─ profile/
│  ├─ learner-profile.md
│  ├─ goals.md
│  └─ technology-preferences.md
├─ shared/
│  ├─ task-template.md
│  ├─ review-template.md
│  ├─ scorecard-template.md
│  └─ validator-guidelines.md
├─ topics/
│  ├─ terraform/
│  │  ├─ roadmap.md
│  │  ├─ level-map.md
│  │  ├─ current-state.md
│  │  ├─ sessions/
│  │  ├─ projects/
│  │  ├─ validators/
│  │  └─ resources/
│  ├─ ansible/
│  ├─ bash/
│  ├─ kubernetes/
│  ├─ docker/
│  └─ cicd/
├─ progress/
│  ├─ global-progress.md
│  ├─ spaced-repetition.md
│  ├─ weak-areas.md
│  └─ mastered-topics.md
├─ reports/
│  └─ monthly-review.md
└─ CLAUDE.md
```

## Poziomy trudności

Poziomy powinny rosnąć logicznie i być przypisane do stylu zadań, a nie tylko do ogólnej etykiety trudności [cite:57][cite:34].

| Poziom | Charakter zadań |
|---|---|
| `junior` | pojedyncze, dobrze opisane taski na jednym pliku lub jednym problemie |
| `junior+` | kilka powiązanych elementów, więcej danych wejściowych, lekkie decyzje architektoniczne |
| `mid-ready` | zadania projektowe, modułowe, wieloetapowe, z review jakości i utrzymania |
| `project-capstone` | większy projekt z wieloma sesjami, refactorem, bugfixami i finalnym review |

## Typy tasków

Task powinien mieć zawsze określony typ, żeby system uczył różnych trybów pracy spotykanych w firmie [cite:34][cite:57].

- `exercise` — klasyczne ćwiczenie praktyczne.
- `work-ticket` — zadanie opisane jak ticket z firmy.
- `bugfix` — naprawa istniejącego rozwiązania.
- `code-review` — analiza i poprawa cudzego kodu.
- `incident` — rozwiązanie problemu operacyjnego lub awarii.
- `interview` — zadanie rekrutacyjne lub pytanie praktyczne.
- `legacy-migration` — praca na starszym rozwiązaniu z oznaczeniem, że to ćwiczenie utrzymaniowe [cite:34][cite:57].

## Model nauki projektowej

Najlepszy model dla technologii typu Terraform, Kubernetes czy Ansible to ścieżka projektowa rozwijana przez wiele sesji, a nie oderwane zadania [cite:34].

Przykład dla Terraform:
- etap 1 — VPC i subnets,
- etap 2 — routing i security groups,
- etap 3 — compute layer,
- etap 4 — load balancer,
- etap 5 — monitoring i outputs,
- etap 6 — podział na moduły,
- etap 7 — środowiska `dev/staging/prod`,
- etap 8 — review architektury i hardening.

To podejście lepiej odzwierciedla realną pracę i rozwija myślenie projektowe zamiast tylko składni [cite:34].

## Standard zadania

Każdy task powinien mieć taki układ:

```md
# Task: [nazwa]

## Typ tasku
work-ticket

## Poziom
junior+

## Temat
terraform

## Etap projektu
networking

## Kontekst
Opis sytuacji jak w pracy.

## Cel
Co dokładnie trzeba osiągnąć.

## Dane wejściowe
Wszystkie potrzebne nazwy, IP, ścieżki, środowiska, wymagania.

## Pliki do użycia
- task.md
- starter-files/main.tf
- starter-files/variables.tf
- validators/validate.sh

## Co już istnieje
Opis poprzednich etapów.

## Co trzeba zrobić
Lista konkretnych wymagań.

## Ograniczenia
Np. nie używaj hardcode, stosuj moduły, trzymaj się aktualnych wersji.

## Definition of done
Jasne kryteria zaliczenia.

## Najczęstsze błędy
Lista rzeczy, na które uważać.

## Tip produkcyjny
Praktyczna rada z pracy.

## Jak powiedzieć o tym na rozmowie
Krótka wskazówka komunikacyjna.
```

## Starter files

Jeśli zadanie dotyczy technologii plikowej, skill ma utworzyć plik startowy ze szkieletem i komentarzami [cite:25][cite:74].

Mapowanie technologii:
- Ansible → `playbook.yml`, `inventory.ini`, czasem `group_vars/*.yml`
- Bash → `script.sh`, dane wejściowe np. `input/*.txt` lub `input/*.csv`
- Terraform → `main.tf`, `variables.tf`, `outputs.tf`, czasem `terraform.tfvars`
- Kubernetes → `deployment.yaml`, `service.yaml`, `configmap.yaml`
- Docker → `Dockerfile`, `.dockerignore`, opcjonalnie `docker-compose.yml`
- CI/CD → `.github/workflows/ci.yml`

Przykład startera dla Ansible:

```yaml
---
# Task: przygotuj playbook wdrażający nginx na staging
# Wymagania:
# 1. become: true
# 2. instalacja nginx
# 3. service enabled + started
# 4. handler restartu po zmianie konfiguracji
# 5. użyj inventory.ini i group_vars/webservers.yml

- name: TODO
  hosts: webservers
  become: TODO

  tasks:
    # TODO: instalacja nginx
    # TODO: wdrożenie konfiguracji
    # TODO: zapewnienie startu usługi

  handlers:
    # TODO: restart nginx
```

Przykład startera dla Bash:

```bash
#!/usr/bin/env bash

# Task:
# 1. sprawdź czy katalog wejściowy istnieje
# 2. policz pliki .log
# 3. wygeneruj report.txt
# 4. zwróć sensowny exit code

set -euo pipefail

# TODO: sprawdzenie katalogu
# TODO: policzenie logów
# TODO: zapis raportu
```

## Dane wejściowe

Jeśli task wymaga danych, wszystkie dane powinny być dostarczone w `task.md` lub plikach pomocniczych, żeby użytkownik mógł skupić się na rozwiązaniu, a nie wymyślaniu założeń [cite:57][cite:34].

Przykładowe pliki pomocnicze:
- `inventory.ini`
- `dataset.csv`
- `config.env`
- `terraform.tfvars`
- `logs/app.log`
- `architecture.md`

## Aktualność technologii

Przed wygenerowaniem tasku system powinien sprawdzić aktualne wersje i współczesne praktyki, żeby nie uczyć rozwiązań przestarzałych, chyba że zadanie jest jawnie oznaczone jako `legacy-migration` [cite:25][cite:34].

Reguły:
- sprawdź aktualne wersje i status wsparcia,
- nie używaj EOL jako domyślnego standardu,
- preferuj obecnie stosowane wzorce,
- jeśli używasz starszego rozwiązania, oznacz to jasno jako ćwiczenie legacy.

## System powtórek

Jeśli wynik zadania jest słaby albo określone obszary wracają jako błędne, system powinien zapisać to do powtórek i wrócić do tematu po kilku sesjach [cite:34][cite:73].

Przykładowe pola:

```yaml
repeat_if_score_below: 7
repeat_after_sessions: 3
failure_tags:
  - variables
  - loops
  - idempotency
  - yaml-structure
```

## Checklisty oceny

Reviewer powinien oceniać według stałej listy kryteriów, żeby wynik był spójny [cite:57][cite:73].

### Scorecard

| Obszar | Skala |
|---|---|
| Poprawność | 0–10 |
| Czytelność | 0–10 |
| Best practices | 0–10 |
| Bezpieczeństwo | 0–10 |
| Gotowość do pracy | 0–10 |
| Samodzielność rozwiązania | 0–10 |

### Próg
- `8–10` — zaliczone bardzo dobrze
- `7` — zaliczone, ale temat do lekkiej powtórki
- `<7` — wróć do tematu w systemie powtórek

## Raport review

Każdy raport powinien mieć stały układ:

```md
# Review report

## Wynik
Ocena końcowa.

## Co zrobiono dobrze
Mocne strony rozwiązania.

## Błędy i braki
Co jest niepoprawne lub niepełne.

## Jak poprawić
Konkretne poprawki.

## Best practices
Lepszy sposób wykonania.

## Tip produkcyjny
Na co zwrócić uwagę w pracy.

## Częsty błąd juniorów
Typowy problem.

## Jak powiedzieć o tym na rozmowie
Jak uzasadnić decyzje techniczne.

## Czy technologia i podejście są aktualne
Ocena aktualności rozwiązania.

## Scorecard
Tabela punktowa.

## Co powtórzyć
Tematy do kolejnych sesji.
```

## Skrypty walidujące

Tam, gdzie to możliwe, reviewer powinien uruchamiać walidację automatyczną, bo skrypty i zasoby mogą zwiększyć jednoznaczność oceny [cite:74][cite:57].

Przykłady:
- Bash → `shellcheck`, test działania skryptu
- Terraform → `terraform fmt -check`, `terraform validate`
- Kubernetes → `kubectl apply --dry-run=client -f ...`
- Ansible → `ansible-playbook --syntax-check`, `ansible-lint`
- GitHub Actions → walidacja składni YAML i logiki kroków [cite:74].

### Szablon `validate.sh`

```bash
#!/usr/bin/env bash
set -euo pipefail

RESULT_FILE="validation-result.txt"
: > "$RESULT_FILE"

run_check() {
  local name="$1"
  shift
  echo "== $name ==" >> "$RESULT_FILE"
  if "$@" >> "$RESULT_FILE" 2>&1; then
    echo "PASS" >> "$RESULT_FILE"
  else
    echo "FAIL" >> "$RESULT_FILE"
  fi
  echo >> "$RESULT_FILE"
}

# Przykłady — odkomentuj zależnie od technologii
# run_check "terraform fmt" terraform fmt -check
# run_check "terraform validate" terraform validate
# run_check "shellcheck" shellcheck script.sh
# run_check "ansible syntax" ansible-playbook --syntax-check playbook.yml -i inventory.ini
```

## Przykład meta pliku zadania

Każda sesja może mieć dodatkowy plik `task-meta.yaml`:

```yaml
task_id: terraform-staging-network-03
task_type: work-ticket
level: junior+
topic: terraform
project: inventory-api-infra
project_stage: compute-layer
uses_current_best_practices: true
validator_script: validators/validate.sh
score_threshold: 7
repeat_after_sessions: 3
failure_tags:
  - networking
  - ec2
  - variables
```

## Rola poszczególnych skilli

### 1. `learning-orchestrator`
- wybiera temat,
- sprawdza historię,
- pilnuje poziomu,
- decyduje czy iść dalej, wrócić do powtórki czy wejść w większy projekt [cite:34][cite:57].

### 2. `task-generator`
- tworzy `session.md`, `task.md`, `task-meta.yaml`, starter files i dane wejściowe,
- dba o to, aby task był praktyczny, kompletny i dobrze rozpisany [cite:25][cite:74].

### 3. `solution-reviewer`
- analizuje rozwiązanie,
- uruchamia walidację,
- tworzy raport review,
- dodaje tipy i wskazówki do rozmowy technicznej [cite:57][cite:74].

### 4. `progress-manager`
- aktualizuje `global-progress.md`,
- dopisuje słabe punkty,
- planuje powtórki,
- pilnuje logiki ścieżki nauki [cite:34][cite:73].

## Co jeszcze warto wdrożyć

- `roadmap.md` dla każdego tematu,
- `level-map.md` z opisem wymagań na każdy poziom,
- `golden-solution-outline.md` dla spójniejszego review,
- `common-mistakes.md` dla każdego tematu,
- `tech-watch.md` z notatkami o aktualnych zmianach technologicznych.

## Wdrożenie v1

Najprostsza wersja startowa:
1. przygotuj folder `ai-tutor/`,
2. utwórz 4 skille,
3. zdefiniuj 3 pierwsze technologie: Terraform, Bash, Ansible,
4. dla każdej technologii przygotuj roadmapę projektu,
5. dodaj po 2 przykładowe starter files,
6. dodaj po 1 validatorze,
7. uruchom pierwsze 5 sesji i dopiero potem poprawiaj system [cite:34][cite:57].

To już wystarczy, żeby zbudować sensowny, powtarzalny i praktyczny system nauki pod pracę techniczną [cite:25][cite:34][cite:57].
