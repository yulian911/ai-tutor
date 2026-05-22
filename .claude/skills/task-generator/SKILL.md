---
name: task-generator
description: >
  Generate a complete learning session: task.md, starter files, input data, and task-meta.yaml.
  Use when the user says "wygeneruj task", "stwórz sesję", or "task generator [temat] [poziom]".
  Typically invoked after learning-orchestrator passes session parameters. Never generate a task
  with missing sections — all fields in the task standard are required.
allowed-tools:
  - Read
  - Glob
  - Write
---

# Task Generator

Generate a complete, self-contained learning session from the parameters passed by learning-orchestrator.

## Procedure

### Step 1 — Establish context

1. Read `topics/<temat>/roadmap.md` — find the current project stage.
2. Read `topics/<temat>/level-map.md` — check requirements for the chosen level.
3. Read the most recent session in `topics/<temat>/sessions/` — preserve project continuity.
4. Verify that the technology is current: check versions, active support status, current best practices. If using an older approach, mark the task explicitly as `legacy-migration`.

### Step 2 — Create session directory

Create `topics/<temat>/sessions/session-NN/` where NN is the next sequential number.

#### `session.md`

```
# Sesja NN — <krótki tytuł>

Temat, poziom, typ, etap projektu, data, co ćwiczymy, połączenie z poprzednią sesją, oczekiwany czas.
```

#### `task.md`

Complete task per the standard in CLAUDE.md. Every section is required — no section may be empty:

- typ tasku, poziom, temat, etap projektu
- kontekst, cel
- dane wejściowe, pliki do użycia
- lista wymagań, ograniczenia, definition of done
- najczęstsze błędy, tip produkcyjny, wskazówka do rozmowy technicznej

#### `task-meta.yaml`

```yaml
task_id: <temat>-<etap>-NN
task_type: <typ>
level: <poziom>
topic: <temat>
project: <nazwa projektu>
project_stage: <etap>
uses_current_best_practices: true
validator_script: ../../validators/validate.sh
score_threshold: 7
repeat_after_sessions: 3
failure_tags: []
```

#### Starter files

Create files with `# TODO:` comments guiding the user. Never leave the user to guess what to write.

| Technology | Required starter files |
|------------|------------------------|
| Terraform | `main.tf`, `variables.tf`, `outputs.tf`, `terraform.tfvars` |
| Ansible | `playbook.yml`, `inventory.ini`, optionally `group_vars/` |
| Bash | `script.sh` (must include `set -euo pipefail`) |
| Kubernetes | `deployment.yaml`, `service.yaml` |
| Docker | `Dockerfile` |
| CI/CD | `.github/workflows/ci.yml` |

#### Input data

If the task requires input data (logs, CSVs, variables), create the data files. The user must not need to invent any inputs.

### Step 3 — Summarize

Print the list of created files and brief start instructions for the user.

## Rules

- Task must be practical and based on a realistic work scenario.
- Maintain consistency: `task.md` ↔ starter files ↔ validator ↔ what solution-reviewer will check.
- Verify technology currency before generating.
