# ai-tutor

Osobisty system nauki technicznej oparty na Claude Code. Działa jak nauczyciel, reviewer i planista nauki w jednym — generuje praktyczne zadania, sprawdza rozwiązania i planuje powtórki.

## Czego uczę się tym systemem

| Technologia | Status |
|-------------|--------|
| Terraform | aktywny |
| Bash | aktywny |
| Ansible | aktywny |
| Kubernetes | planowany |
| Docker | planowany |
| CI/CD | planowany |

## Jak działa sesja

```
/learning-orchestrator  →  /task-generator  →  [rozwiązujesz]  →  /solution-reviewer  →  /progress-manager
```

1. **Orchestrator** czyta historię i decyduje co ćwiczyć (temat, poziom, typ zadania)
2. **Task generator** tworzy praktyczne zadanie z plikami startowymi i danymi wejściowymi
3. **Rozwiązujesz** zadanie w `topics/<temat>/sessions/session-NN/starter-files/`
4. **Solution reviewer** sprawdza rozwiązanie, uruchamia walidatory, wystawia ocenę
5. **Progress manager** aktualizuje progres, zapisuje błędy do powtórki

## Struktura projektu

```
ai-tutor/
├── .claude/
│   └── skills/              # instrukcje dla każdego skilla
│       ├── learning-orchestrator/
│       ├── task-generator/
│       ├── solution-reviewer/
│       ├── progress-manager/
│       ├── rule-view/
│       └── refactor/
├── profile/                 # profil uczącego się i cele
├── topics/
│   └── <temat>/
│       ├── roadmap.md       # plan etapów projektu
│       ├── level-map.md     # kryteria awansu poziomów
│       ├── current-state.md # aktualny postęp
│       ├── sessions/        # historia sesji i zadania
│       └── validators/      # skrypty walidujące rozwiązania
├── progress/
│   ├── global-progress.md   # wyniki wszystkich sesji
│   ├── spaced-repetition.md # zaplanowane powtórki
│   └── weak-areas.md        # słabe obszary
└── CLAUDE.md                # reguły systemu
```

## Model postępu

Poziomy awansują na podstawie wyników, nie czasu:

```
junior  →  junior+  →  mid-ready  →  project-capstone
```

Awans wymaga 3 kolejnych sesji z wynikiem ≥ 8/10 na bieżącym poziomie. Wynik < 7 w dowolnym obszarze blokuje awans i dodaje temat do powtórki.

## Scorecard

Każde rozwiązanie oceniane jest na 6 osiach (0–10):

| Oś | Co oceniamy |
|----|-------------|
| Poprawność | Spełnienie wszystkich wymagań z task.md |
| Czytelność | Nazewnictwo, struktura, formatowanie |
| Best practices | Standardy specyficzne dla technologii |
| Bezpieczeństwo | Sekrety, uprawnienia, attack surface |
| Gotowość do pracy | Czy to można wdrożyć w firmie |
| Samodzielność | Własne myślenie vs. ślepe kopiowanie szkieletu |

Wynik końcowy = średnia. Próg zaliczenia: **7.0 / 10**.

## Typy zadań

System preferuje zadania zbliżone do pracy zawodowej:

`work-ticket` | `bugfix` | `incident` | `code-review` | `exercise` | `interview` | `legacy-migration`

## Wymagania

- [Claude Code](https://claude.ai/code) — CLI do uruchamiania systemu
- Narzędzia walidujące per technologia: `terraform`, `shellcheck`, `ansible-lint`, `kubectl`

## Uruchomienie sesji

```bash
# Otwórz projekt w Claude Code
claude

# Zacznij sesję
/learning-orchestrator

# lub z konkretnym tematem
/learning-orchestrator terraform
```

## Skille

| Skill | Kiedy używać |
|-------|-------------|
| `/learning-orchestrator` | Start sesji, wybór tematu i poziomu |
| `/task-generator` | Ręczne wygenerowanie zadania |
| `/solution-reviewer` | Sprawdzenie gotowego rozwiązania |
| `/progress-manager` | Aktualizacja progresu po review |
| `/rule-view` | Audyt plików reguł AI |
