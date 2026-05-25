# Starter Template — Ansible

## playbook.yml

```yaml
---
- name: TODO - Add playbook name
  hosts: TODO # Np. webservers, all, localhost
  become: false # TODO: Ustaw na true jeśli potrzebne sudo
  gather_facts: yes

  vars:
    # TODO: Zdefiniuj zmienne lokalne dla playbooka
    app_user: appuser
    app_home: /opt/app

  pre_tasks:
    # TODO: Dodaj zadania przygotowujące (walidacja, install deps)
    - name: Validate prerequisites
      debug:
        msg: "TODO: Validate input parameters"

  tasks:
    # TODO: Zdefiniuj główne zadania
    - name: Example task
      debug:
        msg: "TODO: Implement main logic"

  post_tasks:
    # TODO: Dodaj zadania czyszczące/finalizujące
    - name: Verify deployment
      debug:
        msg: "TODO: Verify that deployment succeeded"

  handlers:
    # TODO: Zdefiniuj handlery (restart services itp.)
    - name: Restart service
      systemd:
        name: "{{ service_name }}"
        state: restarted
```

## inventory.ini

```ini
# TODO: Zdefiniuj hosty i grupy

[all:vars]
ansible_user=ubuntu
ansible_ssh_private_key_file=~/.ssh/id_rsa

[webservers]
# TODO: Dodaj web servers
# web01.example.com
# web02.example.com

[databases]
# TODO: Dodaj database servers
# db01.example.com

[localhost]
127.0.0.1 ansible_connection=local
```

## group_vars/all.yml (opcjonalnie)

```yaml
# TODO: Zdefiniuj zmienne dla wszystkich hostów
---
environment: dev
region: us-east-1
```
