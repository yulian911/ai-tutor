# Task: Sieć bazowa dla Inventory API — VPC i subnety

## Typ tasku
work-ticket

## Poziom
junior

## Temat
terraform

## Etap projektu
networking — VPC i subnets

## Kontekst

Zespół DevOps zaczyna budować infrastrukturę AWS dla aplikacji Inventory API. Twoje pierwsze zadanie to przygotowanie warstwy sieciowej — VPC z subnetami publicznymi i prywatnymi. Bez tej bazy nie można postawić żadnych instancji ani load balancera.

Infrastruktura będzie rozbudowywana w kolejnych sesjach (routing, security groups, EC2, ALB), więc nazewnictwo i tagi muszą być spójne z konwencją projektu.

## Cel

Utwórz VPC z dwoma subnetami publicznymi i dwoma subnetami prywatnymi w regionie eu-west-1. Dodaj Internet Gateway.

## Dane wejściowe

```
Region: eu-west-1
VPC CIDR: 10.0.0.0/16
VPC name: inv-api-vpc

Subnety publiczne:
  - inv-api-public-1a  →  10.0.1.0/24  →  eu-west-1a
  - inv-api-public-1b  →  10.0.2.0/24  →  eu-west-1b

Subnety prywatne:
  - inv-api-private-1a →  10.0.10.0/24 →  eu-west-1a
  - inv-api-private-1b →  10.0.11.0/24 →  eu-west-1b

Internet Gateway name: inv-api-igw

Tagi obowiązkowe dla wszystkich zasobów:
  Project     = "inventory-api"
  Environment = "dev"
  ManagedBy   = "terraform"
```

## Pliki do użycia

- `task.md` — to zadanie
- `starter-files/main.tf` — szkielet do uzupełnienia
- `starter-files/variables.tf` — zmienne do uzupełnienia
- `starter-files/outputs.tf` — outputy do uzupełnienia
- `starter-files/terraform.tfvars` — wartości zmiennych
- `../../validators/validate.sh` — walidacja po zakończeniu

## Co już istnieje

Nic — to pierwszy etap projektu.

## Co trzeba zrobić

1. Uzupełnij `variables.tf`: zdefiniuj zmienne `aws_region`, `vpc_cidr`, `public_subnet_cidrs` (list), `private_subnet_cidrs` (list), `project_name`, `environment`. Każda zmienna musi mieć `type` i `description`.

2. Uzupełnij `main.tf`:
   - Blok `terraform` z `required_version >= 1.9` i providerem `hashicorp/aws ~> 5.50`
   - Provider `aws` z regionem z zmiennej
   - Zasób `aws_vpc` z `enable_dns_support` i `enable_dns_hostnames`
   - 2 zasoby `aws_subnet` publiczne z `map_public_ip_on_launch = true`
   - 2 zasoby `aws_subnet` prywatne z `map_public_ip_on_launch = false`
   - Zasób `aws_internet_gateway` przypisany do VPC

3. Uzupełnij `outputs.tf`: wyeksportuj `vpc_id`, `public_subnet_ids`, `private_subnet_ids`, `igw_id`. Każdy output z `description`.

4. Uzupełnij `terraform.tfvars` wartościami z sekcji "Dane wejściowe".

## Ograniczenia

- Nie używaj hardcode wartości w `main.tf` — wszystko przez zmienne.
- Każdy zasób musi mieć tagi: `Name`, `Project`, `Environment`, `ManagedBy`.
- Użyj `count` lub `for_each` dla subnetów (nie kopiuj zasobu 4 razy).
- Provider version musi być spięty: `~> 5.50`.

## Definition of done

- [ ] `terraform fmt -check` przechodzi bez błędów
- [ ] `terraform validate` przechodzi bez błędów
- [ ] Wszystkie 4 subnety mają unikalne CIDR i AZ
- [ ] Subnety publiczne mają `map_public_ip_on_launch = true`
- [ ] Internet Gateway jest przypisany do VPC
- [ ] Outputy zwracają VPC ID, listy subnet IDs i IGW ID
- [ ] Żadna zmienna nie ma hardcode wartości w `main.tf`

## Najczęstsze błędy

- Kopiowanie zasobu `aws_subnet` 4 razy zamiast użycia `count`/`for_each`
- Brak `enable_dns_hostnames = true` (powoduje problemy z EC2 i RDS)
- Hardcode CIDR lub nazw AZ bezpośrednio w `main.tf`
- Brak outputów lub outputy bez `description`
- Pominięcie tagu `ManagedBy` lub złe formatowanie tagów

## Tip produkcyjny

W projektach produkcyjnych subnety prywatne **nie mają** dostępu do internetu przez IGW — do tego służy NAT Gateway. Będziemy go dodawać w etapie 2. Teraz tworzymy tylko fundamenty — IGW obsługuje tylko ruch publiczny (do subnetów publicznych przez route table).

## Jak powiedzieć o tym na rozmowie

_"W projekcie odpowiadałem za warstwę sieciową w AWS. Stworzyłem VPC z subnetami publicznymi i prywatnymi w dwóch strefach dostępności, co zapewnia high availability. Subnety prywatne są izolowane od internetu — dostęp zapewniam przez NAT Gateway. Całość jest zarządzana Terraformem z osobnymi zmiennymi per środowisko."_
