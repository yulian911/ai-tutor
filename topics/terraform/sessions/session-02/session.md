# Sesja 02 — Routing i Security Groups

**Temat:** terraform
**Poziom:** junior
**Typ:** work-ticket
**Etap projektu:** networking — routing i security groups
**Data:** 2026-05-22

## Co ćwiczymy w tej sesji

Rozbudowa infrastruktury sieciowej o routing (route tables, route table associations) i firewall (security groups z regułami ingress/egress). To etap 2 projektu inventory-api-infra — bazuje na VPC i subnetach z sesji 01.

## Połączenie z poprzednią sesją

Sesja 01 stworzyła VPC (`inv-api-vpc`), 4 subnety i Internet Gateway. Ta sesja dodaje routing dla subnetów publicznych i security groups dla warstwy compute (EC2) i load balancera (ALB).

## Oczekiwany czas

~ 50–65 minut
