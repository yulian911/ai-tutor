# Task: Routing i security groups dla Inventory API

## Typ tasku
work-ticket

## Poziom
junior

## Temat
terraform

## Etap projektu
networking — routing i security groups

## Kontekst

Sieć bazowa jest gotowa (VPC, subnety, IGW). Bez routingu subnety publiczne nie mają dostępu do internetu. Bez security groups nie możemy postawić EC2 ani ALB. Teraz dodajemy warstwy routingu i firewalla, które są wymagane przed rozpoczęciem etapu compute.

Pracujesz na istniejącym kodzie z sesji 01 — dodajesz nowe pliki, nie modyfikujesz starych.

## Cel

Utwórz route tables dla subnetów publicznych, security groups dla ALB i EC2 oraz przypisz je do odpowiednich subnetów.

## Dane wejściowe

```
# Dane z sesji 01 (referencja przez terraform_remote_state lub zmienne)
vpc_id:              (z outputu sesji 01 lub zmiennej)
public_subnet_ids:   [10.0.1.0/24, 10.0.2.0/24]
igw_id:              (z outputu sesji 01 lub zmiennej)

# Route table dla subnetów publicznych
public_rt_name:      inv-api-public-rt
destination_cidr:    0.0.0.0/0
gateway:             Internet Gateway (igw_id)

# Security Group — ALB (load balancer)
alb_sg_name:         inv-api-alb-sg
ingress:
  - port 80  (HTTP)  from 0.0.0.0/0
  - port 443 (HTTPS) from 0.0.0.0/0
egress:
  - all traffic to 0.0.0.0/0

# Security Group — EC2 (aplikacja)
ec2_sg_name:         inv-api-ec2-sg
ingress:
  - port 8080 (app)  from ALB SG only (nie od 0.0.0.0/0!)
  - port 22   (SSH)  from zmienna var.admin_cidr
egress:
  - all traffic to 0.0.0.0/0

Tagi obowiązkowe: Project, Environment, ManagedBy = "terraform"
```

## Pliki do użycia

- `task.md` — to zadanie
- `starter-files/routing.tf` — route tables do uzupełnienia
- `starter-files/security-groups.tf` — security groups do uzupełnienia
- `starter-files/variables.tf` — nowe zmienne (uzupełnij)
- `starter-files/outputs.tf` — outputy (uzupełnij)
- `../../validators/validate.sh` — walidacja

## Co już istnieje

Z sesji 01: `aws_vpc`, 4 `aws_subnet`, `aws_internet_gateway`. Referencje do tych zasobów przekazujesz przez zmienne (`vpc_id`, `public_subnet_ids`, `igw_id`).

## Co trzeba zrobić

1. W `variables.tf` dodaj zmienne: `vpc_id`, `public_subnet_ids` (list(string)), `igw_id`, `admin_cidr` (z opisem i przykładem).

2. W `routing.tf`:
   - Utwórz `aws_route_table` dla subnetów publicznych (trasa 0.0.0.0/0 → IGW)
   - Przypisz tabelę do obu subnetów publicznych przez `aws_route_table_association` (użyj `for_each` lub `count`)
   - Prywatne subnety **nie mają** route table w tym etapie (NAT Gateway będzie dodany później)

3. W `security-groups.tf`:
   - Utwórz `aws_security_group` dla ALB z regułami ingress (80, 443) i egress (all)
   - Utwórz `aws_security_group` dla EC2 z ingress (8080 tylko z ALB SG, 22 tylko z `var.admin_cidr`) i egress (all)

4. W `outputs.tf` wyeksportuj: `alb_sg_id`, `ec2_sg_id`, `public_rt_id`.

## Ograniczenia

- EC2 security group musi mieć port 8080 otwarty **tylko** z ALB SG (używaj `source_security_group_id`, nie CIDR)
- Port 22 musi być ograniczony do `var.admin_cidr`, nie do `0.0.0.0/0`
- Nie otwieraj portu 22 z `0.0.0.0/0` — to błąd bezpieczeństwa
- Używaj `aws_vpc_security_group_ingress_rule` / `aws_vpc_security_group_egress_rule` (nowy styl, nie `ingress {}` inline) — lub `aws_security_group` z inline rules (oba podejścia są ok, ale bądź konsekwentny)
- Wszystkie zasoby muszą mieć wymagane tagi

## Definition of done

- [ ] `terraform fmt -check` i `terraform validate` przechodzą
- [ ] Route table publiczna ma trasę 0.0.0.0/0 → IGW
- [ ] Route table przypisana do obu subnetów publicznych
- [ ] ALB SG ma ingress 80 i 443 z 0.0.0.0/0
- [ ] EC2 SG ma ingress 8080 tylko z ALB SG (nie CIDR)
- [ ] EC2 SG ma ingress 22 z `var.admin_cidr` (nie 0.0.0.0/0)
- [ ] Outputy zwracają IDs security groups i route table

## Najczęstsze błędy

- Otwieranie portu 22 z `0.0.0.0/0` — krytyczny błąd bezpieczeństwa
- Używanie CIDR dla EC2 SG → ALB zamiast `source_security_group_id`
- Brak `aws_route_table_association` — sama route table niczego nie robi
- `count` zamiast `for_each` dla associations (trudniej potem usunąć pojedynczy subnet)
- Pomieszanie inline rules i osobnych zasobów `aws_security_group_rule`

## Tip produkcyjny

W produkcji **nigdy** nie otwieraj portu 22 z 0.0.0.0/0. Używaj bastion hosta, Session Manager (AWS SSM) lub VPN. Session Manager to preferowane rozwiązanie w 2026 — nie potrzebujesz w ogóle otwierać portu 22.

## Jak powiedzieć o tym na rozmowie

_"W projekcie skonfigurowałem routing i security groups w Terraform. EC2 jest odizolowane od internetu — port 8080 dostępny tylko z load balancera przez source_security_group_id. SSH ograniczamy do bastion CIDR lub całkowicie używamy Session Manager. To podejście defense-in-depth."_
