---
name: progress-manager
description: >
  Update progress files after a session review: global-progress.md, current-state.md,
  spaced-repetition.md, weak-areas.md. Use when the user says "zaktualizuj progres",
  "progress manager [temat] [wynik]", or when invoked automatically by solution-reviewer.
  Handles failure tags, level promotion (requires 3 consecutive sessions ≥ 8), and
  scheduling the next session.
allowed-tools:
  - Read
  - Write
  - Edit
---

# Progress Manager

Update all progress files after a review, handle failure tags, check for level promotion, and schedule the next session.

## Procedure

### Step 1 — Read current state

1. Read `progress/global-progress.md`.
2. Read `progress/spaced-repetition.md`.
3. Read `progress/weak-areas.md`.
4. Read `review-report.md` from the completed session.
5. Read `topics/<temat>/current-state.md`.

### Step 2 — Update `global-progress.md`

Add an entry:

```md
## <temat> — sesja NN (<data>)
- **Typ:** work-ticket | **Poziom:** junior+ | **Etap:** networking
- **Wynik:** 8.2/10 ✅ | **Failure tags:** brak | **Kolejna sesja:** compute-layer
```

### Step 3 — Update `current-state.md` for the topic

Record: current stage, current level, recommendation for next step.

### Step 4 — Handle failure tags

If score < 7 **or** failure_tags are present:

1. Add each tag to `progress/weak-areas.md`.
2. Add a repeat entry to `progress/spaced-repetition.md`:

```yaml
- topic: terraform
  tag: security-groups
  failed_session: session-02
  repeat_after_sessions: 3
  next_repeat_before_session: session-05
  status: pending
```

Record failure tags even when the overall score is above the threshold.

### Step 5 — Check level promotion

If the last **3 consecutive sessions** on the current level all scored ≥ 8 → propose a level promotion. Do not promote automatically — present the recommendation and wait for the user to confirm.

### Step 6 — Schedule the next session

- Overdue or due repeats in `spaced-repetition.md` → schedule the repeat first.
- No due repeats → advance to the next stage in `roadmap.md`.

Write the recommendation to `current-state.md`.

## Output format

```
## Progres zaktualizowany

**Sesja:** terraform/session-02 | **Wynik:** 8.2/10 ✅
**Zaktualizowane pliki:** global-progress.md ✅, current-state.md ✅
**Kolejna sesja:** terraform/session-03 — compute layer (EC2)
**Zaplanowane powtórki:** brak
```

## Rules

- A topic is not closed after a single session — it requires a passing repeat.
- Level promotion requires a minimum of 3 sessions scored ≥ 8 on the current level.
