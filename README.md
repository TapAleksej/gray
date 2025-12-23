# Запуск установки
/home/alrex/pro

Удалить предыдущую установку
```bash
ansible-playbook run.yml -e uninstall=true
```

Удалить предыдущую установку и запустить
```bash
ansible-playbook run.yml -e uninstall=true -e run=true
```

Запустить только firewall
```bash
ansible-playbook run.yml -e firewall=true
```


переменные в defaults/main.yml могут переопределиться при запуске playbook
для установки - можно пропустить некоторые таски для отладки
`run: false`

Просто удаление установки
`uninstall: false`

Только firewall
`firewall: true `

## Локальные пакеты для установки

Первоначально файлы установки в roles/graylog_offline_install/files/


Создан репо /opt/graylog_repo

```bash
cat /etc/yum.repos.d/graylog-offline.repo
```


## Вход на сервер
Логин: alrex
пароль входа: `Qwadro4x4`