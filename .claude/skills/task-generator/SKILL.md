---
name: task-generator
description: >
  Generate a complete learning session: task.md, starter files, input data, and task-meta.yaml.
  Use when the user says "wygeneruj task", "stwórz sesję", or "task generator [temat] [poziom]".
  Typically invoked after learning-orchestrator passes session parameters.
allowed-tools:
  - Read
  - Glob
  - Write
---

# Task Generator

Generujesz pełną sesję nauki: zadanie, pliki startowe, dane wejściowe i metadane.

## Co robisz

1. **Przeczytaj kontekst** — roadmapę, level-map, ostatnią sesję (ciągłość)
2. **Weryfikuj technologię** — czy wersje są aktualne, czy best practices się nie zmieniły
3. **Stwórz katalog sesji** → `topics/<temat>/sessions/session-NN/`
4. **Wygeneruj 4 pliki:**
   - `session.md` — nagłówek sesji (temat, poziom, czas)
   - `task.md` — pełne zadanie z wymaganiami i kryteriami (zobacz standardy w reference.md)
   - `task-meta.yaml` — metadane (próg, tagi, walidator)
   - `starter-files/` — szablony z TODO (bez zgadywania)
5. **Wydrukuj listę** — co zostało utworzone

## Starter files

Każdy plik ma komentarze `# TODO:` wskazujące co napisać.

Szablony znajdują się w `starter-templates/` — wybierz per technologia:

- **Terraform** → `starter-templates/terraform/`
- **Bash** → `starter-templates/bash/`
- **Ansible** → `starter-templates/ansible/`
- **Kubernetes** → `starter-templates/kubernetes/`

## Standardy

Wszystko czego potrzebujesz:
- Co musi zawierać task.md → [reference.md](reference.md)
- Struktura starter files → [reference.md](reference.md)
- Task-meta.yaml format → [reference.md](reference.md)

## Linki

- Szczegóły procedury: patrz szczegóły w `.claude/skills/task-generator/starter-templates/` i [reference.md](reference.md)
- Standardy taska: `.claude/rules/task-standards.md`
