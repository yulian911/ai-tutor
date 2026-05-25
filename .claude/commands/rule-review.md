# /rule-review — Audyt pliku reguł AI

Uruchamia `rule-view`: analizuje plik reguł AI i zwraca scorecard z konkretnymi poprawkami.

## Użycie

```
/rule-review
/rule-review CLAUDE.md
/rule-review .claude/rules/task-standards.md
```

## Co robi

1. Czyta wskazany plik reguł (domyślnie `CLAUDE.md`).
2. Ocenia go w 5 obszarach (0–10 każdy): jasność instrukcji, kompletność, spójność, aktualność, wykonalność.
3. Zwraca konkretne, działające poprawki — nie ogólne sugestie.

Invoke skill: rule-view
