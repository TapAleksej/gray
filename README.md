# Запуск установки
/home/alrex/pro

Переменные
в defaults/main.yml могут переопределиться при запуске playbook
для установки - можно пропустить некоторые таски для отладки
`run: false`

Просто удаление установки
`uninstall: false`

Только firewall
`firewall: true `


Удалить предыдущую установку
```bash
ansible-playbook run.yml -e uninstall=true --ask-vault-pass
```

Удалить предыдущую установку и запустить
```bash
ansible-playbook run.yml -e uninstall=true -e run=true --ask-vault-pass
```

Запустить только firewall
```bash
ansible-playbook run.yml -e firewall=true --ask-vault-pass
```

```bash
ansible-playbook run.yml --tags metrica --ask-vault-pass
```


## Локальные пакеты для установки

Первоначально файлы установки в roles/rpm_files/


Создан репо /opt/graylog_repo

```bash
cat /etc/yum.repos.d/graylog-offline.repo
```


Посмотреть секрет
```bash
ansible-vault edit ./roles/graylog_offline_install/files/secrets.yml
```