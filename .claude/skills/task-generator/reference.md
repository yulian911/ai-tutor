# Task Generator — Procedury i standardy

## Procedura generowania sesji

### Krok 1 — Czytaj kontekst

1. Czytaj `topics/<temat>/roadmap.md` — gdzie jesteście?
2. Czytaj `topics/<temat>/level-map.md` — co wymaga poziom?
3. Czytaj ostatnią sesję `topics/<temat>/sessions/session-NN/task.md` — co było wcześniej?
4. Weryfikuj technologię — czy wersje są aktualne, czy best practices się nie zmieniły?

### Krok 2 — Stwórz katalog sesji

```bash
topics/<temat>/sessions/session-NN/
```

Gdzie NN to następny numer sekwencyjny (01, 02, 03, ...).

### Krok 3 — Wygeneruj cztery pliki

#### 3a. `session.md`

```markdown
# Sesja NN — <tytuł>

**Temat:** terraform  
**Poziom:** junior+  
**Typ:** work-ticket  
**Etap projektu:** networking — security groups  
**Data:** 2026-05-25  
**Oczekiwany czas:** 45 minut  

## Co ćwiczymy

Stosowanie reguł ingress/egress w AWS Security Groups. Praktyka zarządzania dostępem sieciowym.

## Połączenie z poprzednią sesją

Poprzednio nauczyłeś się tworzyć VPC i subnety. Teraz będziesz kontrolować ruch między nimi.

## Przejście

Po tej sesji będziesz gotowy do Network ACL.
```

#### 3b. `task.md`

Musi zawierać **WSZYSTKIE** te sekcje (patrz `.claude/rules/task-standards.md`):

```markdown
# Task — <tytuł>

**Typ:** work-ticket  
**Poziom:** junior+  
**Temat:** terraform  
**Etap projektu:** networking — security groups

## Kontekst

Opisz scenariusz biznesowy/techniczny.

## Cel

Co użytkownik ma osiągnąć.

## Dane wejściowe

Wszystkie dane — nie może ich brakować.

## Pliki do użycia

- main.tf
- variables.tf
- outputs.tf
- terraform.tfvars

## Lista wymagań

1. Requirement 1
2. Requirement 2
3. Requirement 3

## Ograniczenia

- Czego nie wolno robić
- Co jest zakazane

## Definition of Done

Kiedy zadanie jest ukończone.

## Najczęstsze błędy

1. Błąd 1
2. Błąd 2
3. Błąd 3

## Tip produkcyjny

Praktyczna wskazówka z realiów pracy.

## Wskazówka do rozmowy technicznej

Jak mówić o tym zagadnieniu na rekrutacji.
```

#### 3c. `task-meta.yaml`

```yaml
task_id: terraform-networking-02
task_type: work-ticket
level: junior+
topic: terraform
project: ai-tutor
project_stage: networking — security groups
uses_current_best_practices: true
validator_script: ../../validators/validate.sh
score_threshold: 7
repeat_after_sessions: 3
failure_tags: []
```

#### 3d. `starter-files/`

Zamiast tworzyć od zera, **copy ze szablonów** w `starter-templates/<technologia>/`.

Każdy plik ma `# TODO:` komentarze:

```bash
starter-files/
├── main.tf
│   # TODO: zdefiniuj security group z ingress rule dla portu 443
│   # TODO: zdefiniuj egress rule dla całej sieciów
├── variables.tf
│   # TODO: zmienna dla VPC ID
├── outputs.tf
│   # TODO: wyeksportuj ID security group
└── terraform.tfvars
    # TODO: uzupełnij wartości dla środowiska dev
```

### Krok 4 — Wydrukuj podsumowanie

```markdown
## Sesja utworzona ✓

**Katalog:** topics/terraform/sessions/session-02/

Pliki:
- session.md (nagłówek)
- task.md (zadanie + wymagania)
- task-meta.yaml (metadane)
- starter-files/ (szablony)

Przejdź do `starter-files/` i zacznij ćwiczenie.
```

---

## Starter templates

Katalog `starter-templates/` zawiera szablony per technologia. Kopiujesz je do `starter-files/` i dostosowujesz do konkretnego zadania.

### Terraform

```
starter-templates/terraform/
├── main.tf              # provider + resource
├── variables.tf         # deklaracje zmiennych
├── outputs.tf           # co exportować
└── terraform.tfvars     # wartości
```

### Bash

```
starter-templates/bash/
└── script.sh            # (musi mieć set -euo pipefail)
```

### Ansible

```
starter-templates/ansible/
├── playbook.yml
├── inventory.ini
└── group_vars/          # opcjonalnie
```

### Kubernetes

```
starter-templates/kubernetes/
├── deployment.yaml
└── service.yaml
```

---

## Zasady

- **Każdy plik musi mieć TODO** — użytkownik nie może zgadywać
- **Technologia aktualna** — sprawdź wersje, best practices, deprecated features
- **task.md kompletny** — żadna sekcja nie może być pusta
- **task-meta.yaml prawidłowy** — wszystkie pola wypełnione
- **Praktyczne scenariusze** — pracy, nie abstrakcyjne ćwiczenia
- **Continuity** — każda sesja buduje na poprzednich
