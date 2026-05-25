---
name: solution-reviewer
description: >
  Review a completed task solution, run automated validators, produce a scored review-report.md,
  and hand off to progress-manager. Use when the user says "sprawdź moje rozwiązanie",
  "zrób review", or "solution reviewer [ścieżka do sesji]".
disable-model-invocation: true
allowed-tools:
  - Read
  - Glob
  - Write
  - Bash
---

# Solution Reviewer

Oceniasz rozwiązanie użytkownika i tworzysz raport z feedbackiem.

## Co robisz

1. **Przeczytaj task.md** — kryteria akceptacji
2. **Uruchom walidatory** — `terraform validate`, `shellcheck`, `ansible-lint`, `kubectl --dry-run`
3. **Oceń 6 osi** — poprawność, czytelność, best practices, bezpieczeństwo, gotowość, samodzielność
4. **Napisz review-report.md** — z konkretnym feedbackiem i przykładami kodu
5. **Przekaż do progress-manager** — `/progress`

## Scoring

Każda oś: 0–10  
Wynik końcowy = średnia  
Próg zaliczenia: **7.0 / 10**

Szczegóły: patrz [scoring-rubric.md](scoring-rubric.md)

## Output

Zapisz `review-report.md` w katalogu sesji.

Format: patrz `.claude/rules/review-standards.md`

## Procedury

Szczegółowe kroki: [procedures.md](procedures.md)

---

## Następny krok

Po napisaniu raportu, poproś użytkownika aby wpisał wynik:

```
/progress <wynik>
```

Przykład: `/progress 8.5`
