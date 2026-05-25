---
name: level-system
description: System poziomów i ścieżka awansu w ai-tutor
---

# System poziomów — Ścieżka awansu

Poziomy awansują na podstawie **wyników, nie czasu**.

```
junior  →  junior+  →  mid-ready  →  project-capstone
```

---

## Definicje poziomów

### junior — Fundamenty

**Cel:** Nauczyć się podstawowych pojęć i konwencji technologii.

**Charakterystyka:**

- Proste zadania z Clear wymaganiami
- Mostly exercises, some work-tickets
- Starter files z dokładnymi wskazówkami
- Fokus na: syntax, best practices, tool usage

**Awans:** 3 kolejne sesje ≥ 8/10

**Typowe zadania:**

- `exercise` — nauka syntax
- `work-ticket` — prosta nowa funkcja

---

### junior+ — Właściwa praca

**Cel:** Pracować nad rzeczywistymi zadaniami z minimalną pomocą.

**Charakterystyka:**

- Work-tickets, bugfixes, code-review
- Mniej podpowiedzi w starter files
- Fokus na: design decisions, safety, optimization
- Wymaga zrozumienia kontekstu biznesowego

**Awans:** 3 kolejne sesje ≥ 8/10

**Typowe zadania:**

- `work-ticket` — feature w infrastrukturze
- `bugfix` — diagnoza i naprawa
- `code-review` — ocena cudzego kodu

---

### mid-ready — Gotowość do pracy

**Cel:** Być gotowym do pracy w zespole.

**Charakterystyka:**

- Złożone zadania bez starter files
- incidents, legacy migrations
- Fokus na: collaboration, documentation, incident response
- Real-world scenarios

**Awans:** 3 kolejne sesje ≥ 8/10

**Typowe zadania:**

- `incident` — diagnoza i naprawa incydentu
- `interview` — przygotowanie do rozmowy
- `legacy-migration` — modernizacja

---

### project-capstone — Projekt końcowy

**Cel:** Wykazać pełne opanowanie technologii.

**Charakterystyka:**

- Projekt end-to-end (planning, implementation, review)
- Brak wsparcia — pełna autonomia
- Integracja ze sobą poprzednich umiejętności
- Gotowe do wdrożenia

**Brak awansu dalej** — projekt końcowy zamyka temat.

**Typowe zadanie:**

- Projekt od zera: architektura → kod → testy → dokumentacja

---

## Jak awansować

### Warunek: 3 kolejne sesje ≥ 8/10

**Nie** 3 sesje z ostatnich 10. **Dokładnie 3 z rzędu** na bieżącym poziomie.

Przykład:

```
Sesja 1 (junior): 7.5 ← nie liczy się (< 8)
Sesja 2 (junior): 8.2 ← liczba się (1/3)
Sesja 3 (junior): 8.0 ← liczba się (2/3)
Sesja 4 (junior): 8.5 ← liczba się (3/3) ✅ AWANS DO junior+

Ale jeśli:
Sesja 4 (junior): 6.5 ← RESETUJE licznik
Sesja 5 (junior): 8.5 ← liczba się ponownie (1/3)
...
```

### Przypadek: Score < 7

**Nie awansuj.** Zamiast tego zaplanuj **powtórkę** tego samego poziomu:

```
Sesja 1 (junior): 8.5 ✅
Sesja 2 (junior): 8.2 ✅
Sesja 3 (junior): 6.5 ❌ POWTÓRKA

Sesja 4 (junior): [podobne zadanie] — próba 2

Licznik resetuje się. Musisz znowu zdobyć 3×8.
```

### Przypadek: Słaba oś (< 7 w jednym obszarze)

**Nawet jeśli średnia ≥ 7**, słaba oś blokuje awans:

| Oś             | Punkty | Efekt                |
| -------------- | ------ | -------------------- |
| Poprawność     | 9      | ✅                   |
| Czytelność     | 9      | ✅                   |
| Best practices | 9      | ✅                   |
| Bezpieczeństwo | 5      | ❌ **Blokuje awans** |
| Gotowość       | 8      | ✅                   |
| Samodzielność  | 8      | ✅                   |

**Średnia:** 7.3/10 (teoretycznie zaliczone), ale **Bezpieczeństwo: 5 → POWTÓRKA**.

---

## Ścieżka uczenia się per temat

Każdy temat ma swoją ścieżkę:

```
Terraform (roadmap.md):
  junior:
    1. Basics (resources, state)
    2. Networking (VPC, subnets)
    3. Security groups

  junior+:
    4. Modules
    5. Variables & outputs
    6. Workspaces

  mid-ready:
    7. State management (remote, locking)
    8. CI/CD integration

  project-capstone:
    Projekt: Stwórz całą infrastrukturę z TF
```

Awans na `junior+` nie znaczy, że kończy się `junior` roadmapa. Można wrócić do wcześniejszych etapów po powtórkach.

---

## Failure tags — powtórki

Jeśli w dowolnej osi wynik < 7, temat trafia do `weak-areas.md` i `spaced-repetition.md`:

```yaml
# spaced-repetition.md
- topic: terraform
  tag: security-groups
  failed_session: session-03
  repeat_after_sessions: 3
  next_repeat_before_session: session-07
  status: pending
```

**Logika:**

- Powtórka po 3 sesjach innego tematu (nie z rzędu)
- Jeśli znowu < 7 → odkłada się dalej (exponential backoff)

---

## Podsumowanie

| Poziom           | Status   | Awans       | Typowe zadania                   |
| ---------------- | -------- | ----------- | -------------------------------- |
| junior           | Uczy się | 3×8 z rzędu | exercise, prosta work-ticket     |
| junior+          | Pracuje  | 3×8 z rzędu | work-ticket, bugfix, code-review |
| mid-ready        | Gotowy   | 3×8 z rzędu | incident, legacy-migration       |
| project-capstone | Koniec   | —           | projekt end-to-end               |

**Zasada:** Wyniki mówią wszystko. Brak skrótów, brak czasowych limitów — tylko umiejętności.
