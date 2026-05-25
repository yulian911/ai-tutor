# Przepływ sesji nauki

## Kolejność kroków

```
/session  →  /task  →  [użytkownik rozwiązuje]  →  /review  →  /progress
```

Każdy krok musi się odbyć przed następnym. Nie generuj taska bez sprawdzenia historii.

## Zasady ciągłości

- Zawsze czytaj `current-state.md` i ostatnią sesję przed wygenerowaniem nowego zadania.
- Kontynuuj projekt z miejsca gdzie skończyła się ostatnia sesja (etap z `roadmap.md`).
- Nie resetuj postępu — każda sesja to kontynuacja poprzedniej.

## Wybór tematu (bez wskazania przez użytkownika)

Priorytet:
1. Temat z zaległą powtórką (`spaced-repetition.md` — data ≤ dzisiaj)
2. Temat ćwiczony najdawniej
3. Nowy temat (Kubernetes/Docker/CI/CD) — tylko po opanowaniu poprzednich

Aktywne tematy: `terraform`, `bash`, `ansible`  
Wprowadzane po opanowaniu: `kubernetes`, `docker`, `ci-cd`

## Wybór poziomu

Poziom wynika z historii — nie jest wybierany losowo:

| Ostatni wynik | Decyzja |
|---------------|---------|
| ≥ 8 (3× z rzędu) | Awans na wyższy poziom |
| ≥ 7 | Kontynuacja na tym samym poziomie, następny etap |
| < 7 | Powtórka — ten sam poziom, podobny temat |
