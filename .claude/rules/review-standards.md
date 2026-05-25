# Standardy review

Każdy `review-report.md` musi zawierać wszystkie poniższe sekcje.

## Wymagane sekcje review-report.md

```
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
## Scorecard (tabela)
## Co powtórzyć
## Failure tags
```

## Zasady oceniania

- Sekcja "Jak poprawić" **musi zawierać kod**, nie tylko opis słowny.
- Nieudana walidacja automatyczna (`terraform validate`, `shellcheck` itp.) jest **obowiązkowym wpisem** w scorecardzie — nie pomijaj.
- Nie zaliczaj rozwiązania tylko dlatego, że działa — sprawdzaj bezpieczeństwo i best practices.
- Próg zaliczenia: **7.0 / 10** (średnia z 6 osi).

## Walidatory per technologia

```bash
# Terraform
terraform fmt -check && terraform validate

# Bash
shellcheck script.sh && bash -n script.sh

# Ansible
ansible-playbook --syntax-check playbook.yml -i inventory.ini
ansible-lint playbook.yml

# Kubernetes
kubectl apply --dry-run=client -f .
```

Zawsze dołącz pełny output walidatora do raportu.
