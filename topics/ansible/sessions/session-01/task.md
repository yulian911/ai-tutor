# Task: Wdrożenie nginx na serwerach webowych

## Typ tasku
work-ticket

## Poziom
junior

## Temat
ansible

## Etap projektu
webstack-automation — inventory i nginx

## Kontekst

Firma uruchamia nowe serwery webowe i potrzebuje automatyzacji wdrożenia nginx. Ręczna konfiguracja każdego serwera z osobna jest nieakceptowalna. Twoim zadaniem jest przygotowanie inventory z serwerami oraz playbooka, który zainstaluje i skonfiguruje nginx.

Playbook będzie uruchamiany przy każdym wdrożeniu, więc musi być **idempotentny** — wielokrotne uruchomienie nie może powodować problemów.

## Cel

Napisz playbook Ansible instalujący nginx na grupie `webservers`, uruchamiający serwis i kopiujący prostą stronę startową.

## Dane wejściowe

```
Serwery (symulowane — nie potrzebujesz ich faktycznie dostępnych):
  webserver-01  ansible_host=10.0.1.10
  webserver-02  ansible_host=10.0.1.11

Połączenie:
  ansible_user=ubuntu
  ansible_ssh_private_key_file=~/.ssh/webstack_key

Konfiguracja nginx:
  port: 80
  strona startowa: "<h1>Inventory API — webserver-{{ inventory_hostname }}</h1>"
  dest: /var/www/html/index.html
  uprawnienia: 0644, owner=www-data

Zmienne (zdefiniuj w group_vars/webservers.yml):
  nginx_port: 80
  app_name: "Inventory API"
```

## Pliki do użycia

- `task.md` — to zadanie
- `starter-files/playbook.yml` — szkielet do uzupełnienia
- `starter-files/inventory.ini` — gotowe (sprawdź czy poprawne)
- `starter-files/group_vars/webservers.yml` — zmienne do uzupełnienia
- `../../validators/validate.sh` — uruchom po zakończeniu

## Co już istnieje

`inventory.ini` i `group_vars/webservers.yml` są przygotowane. Musisz uzupełnić `playbook.yml`.

## Co trzeba zrobić

1. Uzupełnij `group_vars/webservers.yml` — dodaj zmienne `nginx_port` i `app_name`.

2. Napisz playbook `playbook.yml`:
   - `hosts: webservers`
   - `become: true`
   - Task 1: Zainstaluj nginx (`ansible.builtin.apt`, `state: present`, `update_cache: true`), tag: `install`
   - Task 2: Upewnij się że nginx jest uruchomiony i enabled (`ansible.builtin.service`), tag: `service`
   - Task 3: Skopiuj index.html (`ansible.builtin.copy`, `content` z Jinja2 używając `inventory_hostname`), `notify: Restart nginx`, tag: `config`
   - Handler: restartuj nginx po zmianie konfiguracji

3. Wszystkie taski muszą mieć `name` opisujące co robią.

4. Uruchom walidację: `bash ../../validators/validate.sh playbook.yml inventory.ini`

## Ograniczenia

- Używaj `ansible.builtin.*` — pełne nazwy modułów
- Nie używaj `shell:` — jest dedykowany moduł `ansible.builtin.service`
- `become: true` tylko na poziomie playbooka (nie per-task dla tego zadania)
- Nie hardcode adresów IP w playbooku — są w inventory
- Idempotentność: wielokrotne uruchomienie nie może powodować błędów

## Definition of done

- [ ] `ansible-playbook --syntax-check playbook.yml -i inventory.ini` przechodzi
- [ ] Playbook ma handler `Restart nginx` wywoływany przez `notify`
- [ ] Task instalacji nginx ma `update_cache: true`
- [ ] Task kopiowania używa zmiennej `inventory_hostname` w treści strony
- [ ] `group_vars/webservers.yml` zawiera `nginx_port` i `app_name`
- [ ] Każdy task ma tag (`install`, `service`, `config`)
- [ ] Moduły używają pełnych nazw `ansible.builtin.*`

## Najczęstsze błędy

- Używanie skróconych nazw modułów (`apt:` zamiast `ansible.builtin.apt:`)
- Brak `update_cache: true` przy instalacji — może zainstalować starą wersję
- Handler bez `name` lub ze złą nazwą (musi pasować do `notify`)
- `become: true` na każdym tasku osobno zamiast na poziomie playbooka
- `state: running` zamiast `state: started` (niepoprawna wartość)

## Tip produkcyjny

W produkcji `update_cache: true` spowalnia wykonanie playbooka jeśli uruchamiasz go często. Lepszy wzorzec: `update_cache: true` tylko w pierwszym tasku lub z `cache_valid_time: 3600` — Ansible nie odświeża cache jeśli był odświeżony w ciągu ostatniej godziny.

## Jak powiedzieć o tym na rozmowie

_"Zarządzam konfiguracją serwerów przez Ansible. Playbooki są idempotentne — mogę je uruchamiać wielokrotnie bez ryzyka nadpisania zmian. Stosuję handlers do restartu serwisów tylko gdy zmieni się konfiguracja, co zapobiega niepotrzebnym przestojom. Zmienne trzymam w group_vars, a nie hardcode w playbooku."_
