# Terraform — Roadmap projektowa

## Projekt: inventory-api-infra

Infrastruktura AWS dla aplikacji Inventory API. Budowana etapami, każdy etap rozszerza poprzedni.

## Etapy projektu

| Etap | Nazwa | Poziom | Status |
|------|-------|--------|--------|
| 1 | VPC i subnets | junior | ⏳ aktualny |
| 2 | Routing i security groups | junior | — |
| 3 | Compute layer (EC2) | junior+ | — |
| 4 | Load balancer (ALB) | junior+ | — |
| 5 | Monitoring i outputs | junior+ | — |
| 6 | Podział na moduły | mid-ready | — |
| 7 | Środowiska dev/staging/prod | mid-ready | — |
| 8 | Review architektury i hardening | project-capstone | — |

## Szczegóły etapów

### Etap 1 — VPC i subnets
**Cel:** Utwórz sieć bazową dla projektu.
**Zasoby:** `aws_vpc`, `aws_subnet` (public x2, private x2), `aws_internet_gateway`
**Region:** eu-west-1
**CIDR:** 10.0.0.0/16

### Etap 2 — Routing i security groups
**Cel:** Skonfiguruj routing i firewall.
**Zasoby:** `aws_route_table`, `aws_route_table_association`, `aws_security_group`
**Zależności:** etap 1 (VPC, subnets)

### Etap 3 — Compute layer
**Cel:** Utwórz instancje EC2 z user-data.
**Zasoby:** `aws_instance`, `aws_key_pair`, `aws_iam_role`, `aws_iam_instance_profile`
**Zależności:** etap 2 (security groups)

### Etap 4 — Load balancer
**Cel:** Dodaj ALB z target group i health check.
**Zasoby:** `aws_lb`, `aws_lb_listener`, `aws_lb_target_group`, `aws_lb_target_group_attachment`
**Zależności:** etap 3 (EC2)

### Etap 5 — Monitoring i outputs
**Cel:** Dodaj CloudWatch alarms i kompletne outputs.
**Zasoby:** `aws_cloudwatch_metric_alarm`, `aws_sns_topic`
**Zależności:** etap 4 (ALB)

### Etap 6 — Podział na moduły
**Cel:** Refaktoryzacja — wydziel `modules/networking`, `modules/compute`, `modules/lb`.
**Zmiany:** Brak nowych zasobów, refaktoring struktury kodu.
**Zależności:** etap 5 (pełna infrastruktura)

### Etap 7 — Środowiska
**Cel:** Utwórz konfiguracje dla `dev`, `staging`, `prod`.
**Podejście:** Terraform workspaces lub osobne `tfvars`.
**Zależności:** etap 6 (moduły)

### Etap 8 — Hardening i review
**Cel:** Security hardening, compliance check, finalne review architektury.
**Zmiany:** VPC Flow Logs, S3 backend encryption, MFA delete, least-privilege IAM.
**Zależności:** etap 7 (środowiska)

## Konwencje projektu

- Prefiks zasobów: `inv-api-`
- Tagi obowiązkowe: `Project`, `Environment`, `ManagedBy = terraform`
- Backend: S3 + DynamoDB lock (od etapu 6)
- Provider version: `~> 5.50`
