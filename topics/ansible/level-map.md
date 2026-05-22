# Ansible — Level Map

## junior

**Wymagania wejściowe:**
- Wie czym jest inventory i playbook
- Zna podstawowe moduły: apt, copy, service, file

**Charakter zadań:**
- Jeden playbook, jeden host group
- Statyczny inventory (`inventory.ini`)
- Dane dostarczone w playbooku lub `group_vars`

**Kryteria zaliczenia:**
- `ansible-playbook --syntax-check` przechodzi
- Moduły z pełnymi nazwami (`ansible.builtin.*`)
- Brak użycia `shell:` gdy istnieje dedykowany moduł
- `become: true` tylko gdzie potrzebne

---

## junior+

**Wymagania wejściowe:**
- Zaliczone etapy `junior`
- Zna `register`, `when`, `loop`, `handlers`

**Charakter zadań:**
- Handlers dla restartów serwisów
- Szablony Jinja2 dla konfiguracji
- Zmienne w `group_vars` i `host_vars`
- Conditionals (`when`) i tagi

**Kryteria zaliczenia:**
- Handlers notyfikowane i idempotentne
- Szablony bez hardcode (zmienne z defaults)
- `ansible-lint` bez błędów
- Tags na każdym tasku

---

## mid-ready

**Wymagania wejściowe:**
- Zaliczone `junior+`
- Zna strukturę ról, Ansible Galaxy

**Charakter zadań:**
- Kod podzielony na role
- Vault dla sekretów
- `requirements.yml` z collections
- Testy idempotentności

---

## project-capstone

**Wymagania wejściowe:**
- Zaliczone `mid-ready`

**Charakter zadań:**
- Dynamic inventory (AWS EC2)
- CI/CD pipeline z Ansible
- Security hardening playbook
- Code review cudzego kodu Ansible
