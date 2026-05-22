# Ansible — Roadmap projektowa

## Projekt: webstack-automation

Automatyzacja wdrożenia i konfiguracji stacku webowego (nginx + app + db) na serwerach Linux.

## Etapy projektu

| Etap | Nazwa | Poziom | Status |
|------|-------|--------|--------|
| 1 | Inventory i wdrożenie nginx | junior | ⏳ aktualny |
| 2 | Zmienne, szablony Jinja2 i nginx config | junior | — |
| 3 | Handlers, conditionals i tags | junior+ | — |
| 4 | Struktura ról (roles/) | junior+ | — |
| 5 | Ansible Galaxy i collections | junior+ | — |
| 6 | Vault — zarządzanie sekretami | mid-ready | — |
| 7 | Dynamic inventory (AWS EC2) | mid-ready | — |
| 8 | CI/CD integration (GitHub Actions) | project-capstone | — |

## Szczegóły etapów

### Etap 1 — Inventory i wdrożenie nginx
**Cel:** Skonfiguruj inventory i wdróż nginx na webservers.
**Pliki:** `playbook.yml`, `inventory.ini`
**Zasoby:** ansible.builtin.apt, ansible.builtin.service
**Umiejętności:** podstawowe moduły, become, hosts pattern

### Etap 2 — Zmienne i szablony
**Cel:** Dynamiczna konfiguracja nginx przez zmienne i szablony Jinja2.
**Pliki:** `group_vars/webservers.yml`, `templates/nginx.conf.j2`
**Umiejętności:** `vars`, `group_vars`, `host_vars`, template moduł, filtry Jinja2

### Etap 3 — Handlers, conditionals, tags
**Cel:** Obsługa eventów (handlers), warunkowe taski, tagowanie.
**Umiejętności:** `notify`, `handlers`, `when`, `tags`, `register`+`when`

### Etap 4 — Struktura ról
**Cel:** Refaktoryzacja playbooka do struktury ról.
**Struktura:** `roles/nginx/tasks`, `roles/nginx/handlers`, `roles/nginx/templates`, `roles/nginx/defaults`
**Umiejętności:** `ansible-galaxy init`, role dependencies, `meta/main.yml`

### Etap 5 — Galaxy i collections
**Cel:** Użyj collections z Ansible Galaxy (community.general, community.mysql).
**Pliki:** `requirements.yml`, `ansible.cfg`
**Umiejętności:** `ansible-galaxy collection install`, requirements.yml, namespace

### Etap 6 — Vault
**Cel:** Bezpieczne zarządzanie sekretami — hasła DB, klucze API.
**Pliki:** `group_vars/all/vault.yml` (zaszyfrowany)
**Umiejętności:** `ansible-vault create/encrypt/decrypt`, `vault_password_file`

### Etap 7 — Dynamic inventory
**Cel:** Pobieraj inventory dynamicznie z AWS EC2.
**Pliki:** `inventory/aws_ec2.yml`
**Umiejętności:** `amazon.aws.aws_ec2` plugin, filtry, grupy dynamiczne

### Etap 8 — CI/CD
**Cel:** Uruchom playbook w GitHub Actions z secrets i matrix.
**Pliki:** `.github/workflows/deploy.yml`
**Umiejętności:** GitHub Actions + Ansible, SSH keys w secrets, dry-run w PR

## Konwencje projektu

- Używaj `ansible.builtin.*` (pełne nazwy modułów)
- Tags na każdym tasku
- Nie używaj `shell:` jeśli istnieje moduł
- `become: true` tylko gdzie niezbędne
- `ansible-lint` musi przechodzić bez błędów
- Ansible >= 2.17 (core)
