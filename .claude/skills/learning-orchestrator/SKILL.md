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

## Aktualny stan nauki

### Całkowity progres
!`cat progress/global-progress.md 2>/dev/null || echo "[brak danych]"`

### Zaplanowane powtórki
!`cat progress/spaced-repetition.md 2>/dev/null || echo "[brak danych]"`

### Słabe obszary
!`cat progress/weak-areas.md 2>/dev/null || echo "[brak danych]"`

---

## Twoja procedura

Aby wybrać co ćwiczyć:

1. **Czytaj powyższe dane** — całkowity progres, zaplanowane powtórki, słabe obszary.
2. **Zastosuj logikę z orchestration-logic.md** — zdecyduj temat, poziom, typ taska.
3. **Przekaż decyzję do task-generator** — invoke `/task` z parametrami.

Jeśli użytkownik wskazał konkretny temat lub poziom — użyj tego zamiast wybierać.

---

## Output

Po podjęciu decyzji, wydrukuj decyzję:

```
## Decyzja orchestratora

**Temat:** <temat>
**Poziom:** <poziom>  
**Typ taska:** <typ>
**Etap projektu:** <etap>
**Uzasadnienie:** <krótkie wyjaśnienie>

→ Generuję task...
```

Wtedy invoke `task-generator`.

---

Szczegóły: patrz [orchestration-logic.md](orchestration-logic.md)
