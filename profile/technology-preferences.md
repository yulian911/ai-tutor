# Technology Preferences

## Provider / platforma

- **Cloud:** AWS (główny), opcjonalnie GCP jako porównanie
- **Terraform provider:** hashicorp/aws, wersja >= 5.x
- **Ansible:** collections community.general, amazon.aws
- **Python:** 3.11+ (dla skryptów pomocniczych)
- **Bash:** bash 5.x, POSIX-compatible gdzie możliwe

## Środowisko docelowe

- Linux (Ubuntu 22.04 / Amazon Linux 2023)
- Kubernetes: EKS lub k3s lokalnie
- CI/CD: GitHub Actions

## Preferencje stylu kodu

### Terraform
- Używaj `terraform.required_providers` z pinowanymi wersjami
- Zmienne zawsze z `type`, `description`, opcjonalnie `default` i `validation`
- Outputy zawsze z `description`
- Nie używaj `count` — używaj `for_each` gdzie możliwe
- Jeden zasób per plik lub logiczne grupowanie

### Bash
- Zawsze `set -euo pipefail` na początku
- Funkcje zamiast powtarzającego się kodu
- Sensowne exit codes (0 = sukces, 1 = błąd użytkownika, 2 = błąd systemowy)
- Sprawdzaj czy polecenia istnieją przed użyciem (`command -v`)

### Ansible
- `become: true` tylko tam gdzie potrzebne
- Handlers dla restartu serwisów
- Używaj `ansible.builtin.*` zamiast skróconych nazw modułów
- Nie używaj `shell:` jeśli istnieje dedykowany moduł
- Tags na każdym tasku

## Wersje do zastosowania (aktualne na 2026-05)

| Technologia | Wersja |
|-------------|--------|
| Terraform | >= 1.9 |
| AWS Provider | >= 5.50 |
| Ansible | >= 2.17 (core) |
| Kubernetes | 1.30+ |
| Docker | 26.x |
