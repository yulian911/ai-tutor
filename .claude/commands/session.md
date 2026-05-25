# /session — Zacznij sesję nauki

Uruchamia `learning-orchestrator`: sprawdza historię, wybiera temat i poziom, przekazuje do `task-generator`.

## Użycie

```
/session
/session terraform
/session bash junior+
```

## Co robi

1. Czyta `progress/global-progress.md` i `progress/spaced-repetition.md`.
2. Wybiera temat do ćwiczenia (ostatnio zaległy lub wskazany przez użytkownika).
3. Czyta `topics/<temat>/current-state.md` i ostatnią sesję.
4. Decyduje o poziomie, typie taska i etapie projektu.
5. Przekazuje decyzję do `task-generator`, który tworzy pełną sesję.

Invoke skill: learning-orchestrator
