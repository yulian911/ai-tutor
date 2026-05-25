# Logika orchestratora

Jak wybrać co ćwiczyć w oparciu o historię użytkownika.

## Krok 1 — Analiza bieżącego stanu

Z danych wyżej:
- Ile sesji ukończył na każdym poziomie?
- Jakie tematy mają wyniki < 7 (need powtórki)?
- Co czekało ostatnio na powtórkę w `spaced-repetition.md`?
- Które tematy ćwiczył najdawniej?

## Krok 2 — Priorytet tematu

Kolejność (zastosuj pierwszą, która pasuje):

1. **Zaległa powtórka** — jeśli w `spaced-repetition.md` data ≤ dzisiaj → ten temat
2. **Słaba oś** — jeśli w `weak-areas.md` jest temat z niedawnym wynikiem < 7 → ten temat
3. **Ćwiczony najdawniej** — jeśli brak powyższych, wybierz ostatni temat poza aktywną listą
4. **Nowy temat** — tylko jeśli inne 3 są opanowane (average ≥ 8)

Jeśli użytkownik powiedział `/session terraform` → obaj to zamiast wybierać.

## Krok 3 — Priorytet poziomu

| Ostatni wynik na bieżącym poziomie | Decyzja |
|-----------------------------------|---------|
| ≥ 8 (3× z rzędu) | **Awansuj** na wyższy poziom |
| ≥ 7 (ale < 8 z rzędu) | **Zostań** na tym poziomie, następny etap |
| < 7 (ostatni) | **Powtórka** — ten sam poziom, podobny temat |

Ścieżka awansu: `junior` → `junior+` → `mid-ready` → `project-capstone`

Nigdy nie skaczesz poziomów (junior → mid-ready jest niedozwolone).

## Krok 4 — Typ taska

Preferuj pracę — wybierz z tej listy:

- `work-ticket` — nowa funkcjonalność (domyślnie dla junior+ i wyżej)
- `bugfix` — naprawa istniejącego kodu/konfiguracji
- `incident` — diagnoza i naprawa incydentu
- `code-review` — ocena cudzego kodu
- `exercise` — nauka izolowanego konceptu (głównie dla junior)
- `interview` — przygotowanie do rozmowy
- `legacy-migration` — modernizacja starszego podejścia

Dla junior: mix `exercise` i `work-ticket` (50/50).  
Dla junior+ i wyżej: przede wszystkim `work-ticket`, `bugfix`, `incident`.

## Krok 5 — Etap projektu

Czytaj `topics/<temat>/roadmap.md`:

- Gdzie była ostatnia sesja?
- Następny etap w roadmapie?
- Czy ten etap wymaga technik z poprzednich etapów?

## Krok 6 — Uzasadnienie

Krótko wyjaśnij decyzję, np.:
- "Poprzednia sesja: 8/10. Następny etap roadmapy."
- "Zaległa powtórka — ostatnia sesja była 3 tygodnie temu, wynik 6.5/10."
- "Wynik < 7 w Best Practices — powtórka tego samego poziomu."

---

## Przykłady

### Przykład 1 — nowa sesja, awans

**Stan:**
- terraform junior: 3 sesje, wszystkie ≥ 8
- bash junior: 2 sesje, ≥ 7

**Decyzja:**
- Temat: terraform (najdawno najwyżej)
- Poziom: junior+ (3 kolejne ≥ 8)
- Typ: work-ticket
- Etap: następny w roadmapie

### Przykład 2 — powtórka

**Stan:**
- spaced-repetition.md: "terraform-security-groups | 2025-05-20"
- Dzisiaj: 2025-05-25

**Decyzja:**
- Temat: terraform (zaległa powtórka)
- Poziom: taki sam jak wtedy
- Typ: bugfix (zmiana w configu)
- Etap: ten sam

### Przykład 3 — słaba oś

**Stan:**
- weak-areas.md: "bash/exit-codes — Best Practices: 4/10 (ostatnia sesja 2 tygodnie temu)"

**Decyzja:**
- Temat: bash
- Poziom: junior (bez awansu)
- Typ: exercise (szczegółowa nauka)
- Etap: exit-codes
