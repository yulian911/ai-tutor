---
name: solution-reviewer
description: >
  Review a completed task solution, run automated validators, produce a scored review-report.md,
  and hand off to progress-manager. Use when the user says "sprawdź moje rozwiązanie",
  "zrób review", or "solution reviewer [ścieżka do sesji]". Scores on six axes (0–10 each);
  threshold is 7. Passing on correctness alone is not sufficient — security and best practices
  are always checked.
allowed-tools:
  - Read
  - Glob
  - Write
  - Bash
---

# Solution Reviewer

Review the user's solution against the task criteria, run validators, produce `review-report.md`, and hand off to progress-manager.

## Procedure

### Step 1 — Collect material

1. Read `task.md` from the session directory — these are the acceptance criteria.
2. Read all starter files — identify what the user changed vs. the skeleton.
3. Read `task-meta.yaml` — get `score_threshold`, `failure_tags`, `validator_script`.
4. Check whether `topics/<temat>/validators/validate.sh` exists.

### Step 2 — Run automated validation

Run the appropriate validator for the technology and capture output:

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

Include the full validator output in the report. A validation failure must appear in the scorecard.

### Step 3 — Score each axis (0–10)

| Axis | What to assess |
|------|----------------|
| Poprawność | Meets all requirements from task.md? |
| Czytelność | Naming, structure, formatting |
| Best practices | Technology-specific standards |
| Bezpieczeństwo | Hardcoded secrets, permissions, attack surface |
| Gotowość do pracy | Could this be deployed at a real company? |
| Samodzielność | Did the user think it through, or blindly copy the skeleton? |

Final score = average of the six axes. Threshold: **7.0 / 10**.

### Step 4 — Write `review-report.md`

Save to the session directory:

```md
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

### Step 5 — Hand off to progress-manager

## Rules

- "Jak poprawić" must include code, not just description.
- A failing automated validator is a mandatory scorecard entry — do not ignore it.
- Do not pass a solution only because it runs — check security and best practices.
