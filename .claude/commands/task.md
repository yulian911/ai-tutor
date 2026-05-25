# /task — Wygeneruj task

Uruchamia `task-generator`: tworzy `task.md`, starter files, dane wejściowe i `task-meta.yaml`.

## Użycie

```
/task
/task terraform mid-ready
/task bash bugfix
```

## Co robi

1. Czyta roadmapę i level-map dla tematu.
2. Tworzy katalog `topics/<temat>/sessions/session-NN/`.
3. Generuje:
   - `session.md` — nagłówek sesji
   - `task.md` — pełne zadanie ze wszystkimi sekcjami
   - `task-meta.yaml` — metadane (próg, tagi, walidator)
   - `starter-files/` — pliki z szkieletem i komentarzami TODO

Invoke skill: task-generator
