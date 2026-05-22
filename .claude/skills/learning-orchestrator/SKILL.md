---
name: learning-orchestrator
description: >
  Start a learning session, decide what to practice next, and hand off to task-generator.
  Use when the user says "zacznijmy sesję", "co mam ćwiczyć dalej", "uruchom orchestratora",
  or "learning orchestrator [temat]". Reads session history and spaced-repetition schedule
  to choose topic, difficulty level, task type, and project stage — then passes the decision
  to task-generator.
allowed-tools:
  - Read
  - Glob
  - Write
---

# Learning Orchestrator

Decide what to practice next based on history, then hand off to task-generator.

## Procedure

### Step 1 — Read global state

1. Read `progress/global-progress.md`.
2. Read `progress/spaced-repetition.md`.

### Step 2 — Resolve topic

- If the user named a topic (e.g. `terraform`) — use it.
- Otherwise — pick the topic practiced least recently or the one with a due/overdue repeat.

### Step 3 — Read topic history

1. Read `topics/<temat>/current-state.md`.
2. Find and read the most recent session file in `topics/<temat>/sessions/` (highest `session-NN` number).
3. If `current-state.md` does not exist, create it with default level `junior`.

### Step 4 — Decide session parameters

Based on history, choose:

| Parameter | Options |
|-----------|---------|
| Level | `junior` → `junior+` → `mid-ready` → `project-capstone` |
| Task type | `exercise` \| `work-ticket` \| `bugfix` \| `code-review` \| `incident` \| `interview` \| `legacy-migration` |
| Project stage | next stage from `topics/<temat>/roadmap.md` |

Rules:
- If the last session score was < 7 — propose a repeat instead of advancing.
- Prefer `work-ticket`, `bugfix`, `incident` when the goal is job readiness.
- Do not jump levels (e.g. `junior` → `mid-ready` skips `junior+`).
- Check `spaced-repetition.md` for any due or overdue repeat — prioritize it.

### Step 5 — Output decision and hand off

Print the decision block below, then invoke `task-generator`.

## Output format

```
## Decyzja orchestratora

**Temat:** terraform
**Poziom:** junior+
**Typ taska:** work-ticket
**Etap projektu:** networking — security groups
**Uzasadnienie:** Poprzednia sesja zakończyła się wynikiem 8/10. Następny etap roadmapy.
**Zaplanowane powtórki:** brak

→ Przekazuję do task-generator.
```
