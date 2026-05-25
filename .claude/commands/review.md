# /review — Sprawdź rozwiązanie

Uruchamia `solution-reviewer`: sprawdza rozwiązanie, uruchamia walidatory, tworzy `review-report.md`.

## Użycie

```
/review
/review topics/terraform/sessions/session-03
```

## Co robi

1. Czyta `task.md` z katalogu sesji (kryteria akceptacji).
2. Porównuje rozwiązanie ze szkieletem starter files.
3. Uruchamia walidator dla technologii (`terraform validate`, `shellcheck`, `ansible-lint` itp.).
4. Ocenia 6 osi (0–10): poprawność, czytelność, best practices, bezpieczeństwo, gotowość do pracy, samodzielność.
5. Zapisuje `review-report.md` w katalogu sesji.
6. Przekazuje wynik do `progress-manager`.

Próg zaliczenia: **7.0 / 10**

Invoke skill: solution-reviewer
