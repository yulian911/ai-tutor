# ai-tutor

Osobisty system nauki technicznej oparty na Claude Code. Działa jak nauczyciel, reviewer i planista nauki w jednym — generuje praktyczne zadania, sprawdza rozwiązania i planuje powtórki.

---

## Szybki start

```bash
# 1. Otwórz projekt w Claude Code
claude

# 2. Zacznij sesję — system sam wybierze co ćwiczyć
/session

# 3. Lub wskaż konkretny temat
/session terraform
/session bash junior+
```

---

## Komendy

| Komenda | Co robi |
|---------|---------|
| `/session` | Startuje sesję: sprawdza historię, wybiera temat i poziom, generuje task |
| `/task` | Samo generowanie taska (gdy już wiesz co chcesz ćwiczyć) |
| `/review` | Sprawdza Twoje rozwiązanie, uruchamia walidatory, wystawia ocenę |
| `/progress` | Aktualizuje pliki progresu po zakończeniu sesji |
| `/rule-review` | Audyt pliku reguł AI (np. `CLAUDE.md`) |
| `/code-reviewer` | Przegląd kodu w izolowanym kontekście (forked agent) |

---

## Jak wygląda pełna sesja

### Krok 1 — Zacznij sesję

```
/session
```

System przeczyta historię Twoich poprzednich sesji, sprawdzi zaległe powtórki i zdecyduje co ćwiczyć. Dostaniesz podsumowanie decyzji:

```
Temat: terraform
Poziom: junior+
Typ taska: work-ticket
Etap projektu: networking — security groups
Uzasadnienie: Poprzednia sesja: 8/10. Następny etap roadmapy.
```

Możesz też wymusić konkretny temat lub poziom:

```
/session ansible
/session bash bugfix
/session terraform mid-ready
```

---

### Krok 2 — Przeczytaj task

System tworzy katalog `topics/<temat>/sessions/session-NN/` z plikami:

```
session-NN/
├── session.md        ← nagłówek sesji (temat, poziom, czas)
├── task.md           ← pełne zadanie z wymaganiami i kryteriami
├── task-meta.yaml    ← metadane (próg, tagi, walidator)
└── starter-files/    ← pliki ze szkieletem i komentarzami TODO
```

Przeczytaj `task.md` — tam jest wszystko: kontekst, wymagania, definition of done, najczęstsze błędy i tip rekrutacyjny.

---

### Krok 3 — Rozwiązuj

Pracuj w katalogu `starter-files/`. Każdy plik ma komentarze `# TODO:` wskazujące co napisać.

Przykład dla Terraform:
```
starter-files/
├── main.tf           ← # TODO: zdefiniuj security group z regułami ingress/egress
├── variables.tf      ← # TODO: zmienna dla CIDR i nazwy środowiska
├── outputs.tf        ← # TODO: wyeksportuj ID security group
└── terraform.tfvars  ← # TODO: uzupełnij wartości dla środowiska dev
```

Nie musisz zgadywać — starter files prowadzą Cię przez zadanie.

---

### Krok 4 — Sprawdź rozwiązanie

```
/review
```

Lub ze ścieżką do konkretnej sesji:

```
/review topics/terraform/sessions/session-03
```

System:
1. Uruchamia walidatory (`terraform validate`, `shellcheck`, `ansible-lint` itp.)
2. Ocenia rozwiązanie na 6 osiach (0–10 każda)
3. Tworzy `review-report.md` z dokładnym feedbackiem i przykładami kodu

Próg zaliczenia: **7.0 / 10**

---

### Krok 5 — Zapisz progres

```
/progress
```

Lub z wynikiem (gdy review było manualne):

```
/progress terraform 8.5
/progress bash 6.0
```

System zaktualizuje:
- `progress/global-progress.md` — historia wyników
- `progress/spaced-repetition.md` — zaplanowane powtórki błędów
- `topics/<temat>/current-state.md` — aktualny poziom

---

## Scorecard — jak oceniane jest rozwiązanie

| Oś | Co sprawdzamy |
|----|---------------|
| **Poprawność** | Spełnienie wszystkich wymagań z `task.md` |
| **Czytelność** | Nazewnictwo, struktura, formatowanie |
| **Best practices** | Standardy specyficzne dla technologii |
| **Bezpieczeństwo** | Hardcoded secrets, uprawnienia, attack surface |
| **Gotowość do pracy** | Czy można to wdrożyć w prawdziwej firmie |
| **Samodzielność** | Własne myślenie vs. ślepe kopiowanie szkieletu |

Wynik końcowy = średnia z 6 osi. Każda oś < 7 blokuje zaliczenie i dodaje temat do powtórki.

---

## Model poziomów

```
junior  →  junior+  →  mid-ready  →  project-capstone
```

**Awans** wymaga 3 kolejnych sesji z wynikiem ≥ 8 na bieżącym poziomie.  
**Nie skaczemy** poziomów — `junior` → `mid-ready` jest niedozwolone.  
**Wynik < 7** = powtórka zamiast awansu.

Pełne reguły w [`.claude/rules/level-system.md`](.claude/rules/level-system.md).

---

## Typy zadań

System preferuje scenariusze zbliżone do pracy zawodowej:

| Typ | Kiedy |
|-----|-------|
| `work-ticket` | Nowa funkcjonalność w infrastrukturze |
| `bugfix` | Naprawa istniejącej konfiguracji |
| `incident` | Diagnoza i naprawa incydentu |
| `code-review` | Ocena cudzego kodu/konfiguracji |
| `exercise` | Nauka izolowanego konceptu |
| `interview` | Przygotowanie do rozmowy technicznej |
| `legacy-migration` | Modernizacja starszego podejścia |

---

## Technologie

| Technologia | Status | Walidator |
|-------------|--------|-----------|
| Terraform | aktywny | `terraform fmt -check && terraform validate` |
| Bash | aktywny | `shellcheck` + `bash -n` |
| Ansible | aktywny | `ansible-playbook --syntax-check` + `ansible-lint` |
| Kubernetes | planowany | `kubectl apply --dry-run=client` |
| Docker | planowany | — |
| CI/CD | planowany | — |

---

## Struktura projektu

```
ai-tutor/
├── .claude/
│   ├── settings.json          ← uprawnienia i hooki (walidatory auto-dozwolone)
│   ├── commands/              ← slash commands (/session, /task, /review, /progress)
│   ├── rules/
│   │   ├── task-standards.md     ← co musi zawierać każdy task
│   │   ├── review-standards.md   ← co musi zawierać każdy raport
│   │   ├── scoring.md            ← scorecard i progi zaliczenia
│   │   ├── session-flow.md       ← przepływ sesji nauki
│   │   └── level-system.md       ← ścieżka awansu poziomów
│   ├── skills/
│   │   ├── learning-orchestrator/
│   │   │   ├── SKILL.md
│   │   │   └── orchestration-logic.md
│   │   ├── task-generator/
│   │   │   ├── SKILL.md
│   │   │   ├── reference.md
│   │   │   └── starter-templates/   ← szablony per technologia
│   │   │       ├── terraform/README.md
│   │   │       ├── bash/README.md + script.sh
│   │   │       └── ansible/README.md
│   │   ├── solution-reviewer/
│   │   │   ├── SKILL.md
│   │   │   ├── procedures.md
│   │   │   └── scoring-rubric.md
│   │   ├── progress-manager/SKILL.md
│   │   ├── rule-view/SKILL.md
│   │   └── refactor/SKILL.md
│   └── agents/
│       └── code-reviewer.md      ← review w forked context
├── profile/
│   ├── learner-profile.md
│   ├── goals.md
│   └── technology-preferences.md
├── topics/
│   └── <temat>/
│       ├── roadmap.md
│       ├── level-map.md
│       ├── current-state.md
│       ├── sessions/
│       │   └── session-NN/
│       │       ├── session.md
│       │       ├── task.md
│       │       ├── task-meta.yaml
│       │       ├── review-report.md
│       │       └── starter-files/
│       └── validators/
│           └── validate.sh
├── progress/
│   ├── global-progress.md
│   ├── spaced-repetition.md
│   └── weak-areas.md
└── CLAUDE.md
```

---

## Wymagania

- [Claude Code](https://claude.ai/code) — CLI do uruchamiania systemu
- Narzędzia walidujące (instaluj tylko te, których aktywnie używasz):
  ```bash
  # Terraform
  terraform

  # Bash
  shellcheck

  # Ansible
  pip install ansible ansible-lint

  # Kubernetes
  kubectl
  ```
