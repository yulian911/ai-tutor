<!-- https://code.claude.com/docs/en/skills.md -->

# Struktura Projektu Claude Code

Źródło: _Sivasankar Natarajan – „Driving Smarter Outcomes with AI, Cloud & Data"_

---

## Drzewo folderów

```
Your-project/
├── CLAUDE.md
├── CLAUDE.local.md
├── .mcp.json
└── .claude/
    ├── settings.json
    ├── settings.local.json
    ├── rules/
    │   ├── code-style.md
    │   ├── testing.md
    │   └── api-conventions.md
    ├── commands/
    │   ├── review.md
    │   └── fix-issue.md
    ├── skills/
    │   └── deploy/
    │       ├── SKILL.md
    │       └── deploy-config.md
    ├── agents/
    │   ├── code-reviewer.md
    │   └── security-auditor.md
    └── hooks/
        └── validate-bash.sh
```

---

## Opis poszczególnych elementów

### CLAUDE.md

Główny plik instrukcji ładowany automatycznie na początku każdej sesji. Zawiera:

- przegląd projektu,
- opis stosu technologicznego,
- dostępne komendy,
- konwencje i zasady pracy.

### CLAUDE.local.md

Lokalna wersja pliku instrukcji — **nie jest wersjonowana** w repozytorium. Służy do przechowywania ustawień i notatek specyficznych dla konkretnego dewelopera lub środowiska.

### .mcp.json

Plik konfiguracji MCP (Model Context Protocol). Łączy Claude Code z zewnętrznymi narzędziami, takimi jak GitHub, JIRA, Slack czy bazy danych. Jest to **wspólna konfiguracja integracji** dla całego zespołu.

---

### .claude/ — katalog główny konfiguracji

#### settings.json

Centralny plik konfiguracyjny. Kontroluje:

- uprawnienia (permissions),
- wybór modeli,
- dostępne narzędzia,
- hooki.

Obsługuje mechanizm **lokalnych nadpisań** przez `settings.local.json`.

#### settings.local.json

Lokalne nadpisanie ustawień — nie trafia do repozytorium. Pozwala każdemu deweloperowi dostosować konfigurację bez wpływu na ustawienia zespołu.

---

#### rules/

Modularny zestaw plików reguł dla poszczególnych obszarów. Przykłady:

- `code-style.md` — zasady stylu kodu,
- `testing.md` — standardy testowania,
- `api-conventions.md` — konwencje API.

Reguły można stosować **wyłącznie do wybranych ścieżek plików**, dzięki czemu działają precyzyjnie tam, gdzie są potrzebne.

---

#### commands/

Niestandardowe slash commands (`/review`, `/fix-issue` itp.) dla powtarzalnych przepływów pracy. Możliwości:

- własne polecenia wywoływane przez `/nazwa-komendy`,
- obsługa wykonania skryptów shell,
- automatyzacja powtarzalnych zadań.

---

#### skills/

Automatycznie ładowane przepływy pracy dopasowywane do wykonywanego zadania. Każdy skill ma swój podkatalog z plikiem `SKILL.md` i opcjonalnymi plikami konfiguracyjnymi (np. `deploy-config.md`). Zalety:

- kontekst pozostaje lekki i trafny (ładowane tylko potrzebne skille),
- łatwa rozbudowa o nowe obszary kompetencji.

---

#### agents/

Wyspecjalizowane podagenty z izolowanymi kontekstami. Przykłady:

- `code-reviewer.md` — agent do przeglądu kodu,
- `security-auditor.md` — agent do audytu bezpieczeństwa.

Używane do **skupionych, jednorazowych zadań** wymagających odizolowanego kontekstu — agent nie „widzi" reszty rozmowy.

---

#### hooks/

Skrypty uruchamiane automatycznie **przed lub po** wywołaniu narzędzia. Przykłady zastosowań:

- walidacja danych wejściowych,
- lintowanie kodu,
- formatowanie plików,
- blokowanie niedozwolonych akcji.

Plik `validate-bash.sh` to przykład hooka walidującego polecenia bash przed ich wykonaniem.

---

## Podsumowanie — kiedy co edytować

| Element           | Kiedy edytować                                |
| ----------------- | --------------------------------------------- |
| `CLAUDE.md`       | Zmiana zasad projektu, stosu tech, konwencji  |
| `CLAUDE.local.md` | Własne, lokalne notatki i ustawienia          |
| `.mcp.json`       | Dodanie/zmiana integracji zewnętrznych        |
| `settings.json`   | Zmiana uprawnień, modeli, narzędzi            |
| `rules/`          | Nowe reguły stylu, testowania, konwencji API  |
| `commands/`       | Nowe slash commands dla zespołu               |
| `skills/`         | Nowe automatyczne przepływy pracy             |
| `agents/`         | Nowe wyspecjalizowane podagenty               |
| `hooks/`          | Automatyczna walidacja, linting, formatowanie |
