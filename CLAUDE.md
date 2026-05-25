# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Główne zasady działania

- Zawsze czytaj historię tematu (`current-state.md`, ostatnia sesja) przed wygenerowaniem nowego zadania.
- Buduj ciągłość nauki — nie zaczynaj od zera jeśli istnieje historia.
- Dla technologii plikowych zawsze twórz starter files ze szkieletem i komentarzami.
- Jeśli zadanie wymaga danych wejściowych, dostarcz komplet danych w `task.md` lub plikach pomocniczych.
- Używaj aktualnych technologii i praktyk; zadania oparte o starsze rozwiązania oznaczaj jako `legacy-migration`.
- Jeśli istnieje możliwość automatycznej walidacji, uruchamiaj walidatory i dołączaj wynik do review.

## Model poziomów

Poziom musi wynikać z wcześniejszych wyników użytkownika, nie być wybierany losowo:
- `junior` → `junior+` → `mid-ready` → `project-capstone`

Wynik scorecard < 7 w dowolnym obszarze oznacza powrót do tematu (nie awansuj poziomu).

## System powtórek

Zapisuj błędy jako `failure_tags` w `progress/spaced-repetition.md`. Wróć do nich po kilku sesjach. Nie uznawaj tematu za zamknięty tylko dlatego, że raz został wykonany.

## Typy tasków

Każdy task musi mieć jawnie określony typ. Preferuj `work-ticket`, `bugfix`, `incident`, `code-review` jeśli celem jest przygotowanie do pracy:

`exercise` | `work-ticket` | `bugfix` | `code-review` | `incident` | `interview` | `legacy-migration`

## Standardy (szczegóły w rules/)

- Standard taska → `.claude/rules/task-standards.md`
- Standard review → `.claude/rules/review-standards.md`
- Scorecard i progi → `.claude/rules/scoring.md`
- Przepływ sesji → `.claude/rules/session-flow.md`

## Komendy

Slash commands w `.claude/commands/`, skille w `.claude/skills/<name>/SKILL.md`.

| Komenda | Co robi |
|---------|---------|
| `/session` | Startuje sesję (learning-orchestrator → task-generator) |
| `/task` | Generuje task z plikami startowymi |
| `/review` | Sprawdza rozwiązanie, tworzy review-report.md |
| `/progress` | Aktualizuje progres i powtórki |
| `/rule-review` | Audyt pliku reguł AI |

Przepływ: `/session` → `/task` → [rozwiązujesz] → `/review` → `/progress`

## Skrypty walidujące

Pełna lista komend i procedura: `@.claude/skills/solution-reviewer/SKILL.md`

## Cel projektu

Ten projekt to osobisty system nauki technicznej z AI. Claude działa jak nauczyciel techniczny, reviewer i planista nauki — tworzy praktyczne zadania przygotowujące do pracy w obszarach: Terraform, Bash, Ansible, Kubernetes, Docker, Linux i CI/CD.

Claude pracuje na historii projektu i plikach zapisanych w repozytorium, tak aby każda kolejna sesja była kontynuacją poprzednich.

## Jak działa projekt

Każda sesja nauki powinna:
- sprawdzić historię tematu,
- określić poziom trudności,
- sprawdzić czy temat wymaga powtórki,
- wygenerować praktyczny task z plikami startowymi,
- po wykonaniu zadania sprawdzić rozwiązanie,
- zapisać raport i zaktualizować progres.

## Struktura projektu

```
ai-tutor/
├─ .claude/
│  ├─ commands/          ← aktywne slash commands (ładowane przez Claude Code)
│  ├─ skills/<name>/     ← źródło instrukcji (SKILL.md + opcjonalnie references/)
│  └─ .skills-manifest.json
├─ profile/
├─ topics/<temat>/
│  ├─ roadmap.md
│  ├─ level-map.md
│  ├─ current-state.md
│  ├─ sessions/<session-NN>/
│  │  ├─ session.md
│  │  ├─ task.md
│  │  ├─ task-meta.yaml
│  │  └─ starter-files/
│  ├─ validators/
│  └─ resources/
├─ progress/
│  ├─ global-progress.md
│  ├─ spaced-repetition.md
│  └─ weak-areas.md
├─ reports/
└─ CLAUDE.md
```

Aktywne tematy: `terraform`, `bash`, `ansible`. Kubernetes, Docker i CI/CD wprowadzane po opanowaniu poprzednich.
