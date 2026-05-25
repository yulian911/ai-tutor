# /progress — Zaktualizuj progres

Uruchamia `progress-manager`: aktualizuje pliki progresu po zakończeniu sesji.

## Użycie

```
/progress
/progress terraform 8.5
/progress bash 6.0 failed
```

## Co robi

1. Aktualizuje `progress/global-progress.md` — dodaje wynik sesji.
2. Aktualizuje `progress/spaced-repetition.md` — planuje powtórki dla błędów.
3. Aktualizuje `topics/<temat>/current-state.md` — aktualny poziom.
4. Aktualizuje `progress/weak-areas.md` — zapisuje failure_tags.
5. Awansuje poziom jeśli 3 kolejne sesje ≥ 8 (junior → junior+ → mid-ready → project-capstone).

Invoke skill: progress-manager
