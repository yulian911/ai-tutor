# Terraform — Level Map

## junior

**Wymagania wejściowe:**
- Zna składnię HCL (resource, variable, output)
- Potrafi uruchomić `terraform init`, `plan`, `apply`

**Charakter zadań:**
- Jeden plik `main.tf` lub mała grupa plików
- Jeden rodzaj zasobu na raz
- Dane wejściowe dostarczone w `terraform.tfvars`
- Jeden provider, jeden region

**Kryteria zaliczenia:**
- `terraform validate` przechodzi
- `terraform fmt -check` przechodzi
- Zasoby mają poprawne argumenty wymagane
- Zmienne mają `type` i `description`

**Przykładowe zadania:**
- Utwórz VPC z dwoma subnetami
- Utwórz security group z regułami ingress/egress
- Utwórz bucket S3 z podstawową konfiguracją

---

## junior+

**Wymagania wejściowe:**
- Zaliczone wszystkie etapy poziomu `junior`
- Zna `depends_on`, `data sources`, `locals`

**Charakter zadań:**
- Kilka powiązanych plików (`main.tf`, `variables.tf`, `outputs.tf`)
- Zasoby z zależnościami między sobą
- Lekkie decyzje architektoniczne (np. ile subnetów, jakie CIDR)
- `count` lub `for_each` dla powtarzalnych zasobów

**Kryteria zaliczenia:**
- Poprawne `depends_on` i data sources
- `outputs.tf` z sensownymi wartościami
- Brak hardcode (wszystko jako zmienne)
- Tagi na wszystkich zasobach

**Przykładowe zadania:**
- EC2 z security group, key pair i IAM role
- ALB z target group i health check
- Multi-subnet routing z NAT gateway

---

## mid-ready

**Wymagania wejściowe:**
- Zaliczone wszystkie etapy poziomu `junior+`
- Zna `modules`, `remote state`, `workspaces`

**Charakter zadań:**
- Kod podzielony na moduły
- Wieloetapowe projekty z refactoringiem
- Zarządzanie środowiskami (`dev`/`staging`/`prod`)
- Review jakości i maintainability

**Kryteria zaliczenia:**
- Moduły z własnym `variables.tf` i `outputs.tf`
- Remote backend (S3 + DynamoDB)
- Brak duplikacji kodu
- Konfiguracja per-środowisko

---

## project-capstone

**Wymagania wejściowe:**
- Zaliczone `mid-ready`
- Rozumie security hardening i compliance

**Charakter zadań:**
- Duży projekt wielosesyjny
- Bugfixy, refactoring, security hardening
- Finalne review architektury
- Dokumentacja i uzasadnienie decyzji
