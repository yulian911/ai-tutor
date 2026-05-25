# Solution Reviewer — Procedury

## Krok 1 — Zbierz materiały

1. Czytaj `task.md` z katalogu sesji — to kryteria akceptacji
2. Czytaj starter files — co użytkownik zmienił vs. szkielet
3. Czytaj `task-meta.yaml` — próg oceny, tagi, walidator
4. Sprawdź czy istnieje `topics/<temat>/validators/validate.sh`

## Krok 2 — Uruchom walidatory

Uruchom dla technologii:

### Terraform
```bash
terraform fmt -check && terraform validate
```

### Bash
```bash
shellcheck script.sh && bash -n script.sh
```

### Ansible
```bash
ansible-playbook --syntax-check playbook.yml -i inventory.ini
ansible-lint playbook.yml
```

### Kubernetes
```bash
kubectl apply --dry-run=client -f .
```

**Uwaga:** Nieudana walidacja to **obowiązkowy wpis** w scorecardzie — nie pomijaj.

## Krok 3 — Oceń 6 osi

Każda: 0–10 punktów. Szczegóły: [scoring-rubric.md](scoring-rubric.md)

| Oś | Co |
|----|-----|
| **Poprawność** | Spełnianie wszystkich wymagań z task.md |
| **Czytelność** | Nazewnictwo, struktura, formatowanie |
| **Best practices** | Standardy specyficzne dla technologii |
| **Bezpieczeństwo** | Sekrety, uprawnienia, attack surface |
| **Gotowość do pracy** | Czy można to wdrożyć w firmie |
| **Samodzielność** | Własne myślenie vs. ślepe kopiowanie |

## Krok 4 — Napisz review-report.md

Zapisz do katalogu sesji. Musi zawierać:

```markdown
# Review report — <tytuł>

**Wynik końcowy:** X.X/10 — [zaliczone / nie zaliczone / do powtórki]

## Co zrobiono dobrze

## Błędy i braki

## Jak poprawić (z przykładami kodu)

## Best practices

## Tip produkcyjny

## Częsty błąd juniorów

## Jak powiedzieć o tym na rozmowie

## Czy technologia jest aktualna

## Wynik walidacji automatycznej

## Scorecard

| Oś | Punkty | Uwagi |
|----|--------|-------|
| Poprawność | X/10 | |
| Czytelność | X/10 | |
| Best practices | X/10 | |
| Bezpieczeństwo | X/10 | |
| Gotowość do pracy | X/10 | |
| Samodzielność | X/10 | |
| **Średnia** | **X.X/10** | |

## Co powtórzyć

Jeśli wynik < 7 w jakiejkolwiek osi — wymień te tematy.

## Failure tags

Tagi błędów do zaplanowania powtórek.
```

**Ważne:** Sekcja "Jak poprawić" **musi zawierać kod**, nie tylko opis.

## Krok 5 — Zgłoś wynik

Wydrukuj:

```
Raport zapisany: review-report.md

Wynik: X.X/10 — [zaliczone / nie zaliczone]

Następnie wpisz:
/progress <wynik>
```

---

## Zasady

- ✅ Nie zaliczaj rozwiązania tylko dlatego że działa — sprawdzaj bezpieczeństwo i best practices
- ✅ Nieudana walidacja = obowiązkowy wpis w scorecardzie
- ✅ "Jak poprawić" musi mieć kod, nie słowa
- ❌ Nie pomijaj żadnej osi
- ❌ Nie ulegaj naciskowi — próg to 7.0, nie 6.5
