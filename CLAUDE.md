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

## Standard taska

Każdy task musi zawierać: typ, poziom, temat, etap projektu, kontekst, cel, dane wejściowe, pliki do użycia, listę wymagań, ograniczenia, definition of done, najczęstsze błędy, tip produkcyjny, wskazówkę do rozmowy technicznej.

## Standard review

Każdy review report musi zawierać: wynik końcowy, co zrobione dobrze, błędy i braki, jak poprawić, best practices, tip produkcyjny, częsty błąd juniorów, jak powiedzieć o tym na rozmowie, ocenę aktualności rozwiązania, scorecard, lista tematów do powtórki.

## Scorecard

Oceniaj każdy obszar w skali `0–10`:
- poprawność, czytelność, best practices, bezpieczeństwo, gotowość do pracy, samodzielność rozwiązania

## Skille systemu

Skille są zarejestrowane jako slash commands w `.claude/commands/` i ładowane automatycznie przez Claude Code. Wywoływać przez `/skill-name` lub naturalnym językiem.

| Skill | Slash command | Kiedy używać |
|-------|---------------|--------------|
| `learning-orchestrator` | `/learning-orchestrator` | Startowanie sesji, wybór tematu i poziomu |
| `task-generator` | `/task-generator` | Generowanie taska, starter files, danych |
| `solution-reviewer` | `/solution-reviewer` | Sprawdzenie rozwiązania, raport review |
| `progress-manager` | `/progress-manager` | Aktualizacja progresu i powtórek |
| `rule-view` | `/rule-view` | Audyt pliku reguł AI (CLAUDE.md, AGENTS.md itp.) |

Typowy przepływ sesji:
```
/learning-orchestrator → /task-generator → [użytkownik rozwiązuje] → /solution-reviewer → /progress-manager
```

Pełne instrukcje każdego skilla: `.claude/skills/<name>/SKILL.md`

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
