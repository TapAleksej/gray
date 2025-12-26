Нужно разработать и внедрить Ansible-роль для офлайн установки Graylog на сервер RedOS 7.3.4.

- Создать Ansible-роль graylog_offline_install (поставить все зависимости, можно либо при локальной установке, либо через dnf), но компоненты самого graylog , только локально!
- Безопасность сервисы, должны запускаться под сервисными пользователя, iptables необходимо закрыть все неиспользуемые порты. Grailog iptables закрываем другие порты
- Настройка параметров, через vars, должны уметь управлять: путями, паролями, пользователями, конфиги сервисов, должны лежать рядом в папке templates.
- Все логи должны быть по пути /var/log/, так же нужно настроить logrotate - не хранить логи больше 3 недель, настроить лимиты для файлов в 10мб, настроить архивацию.
- Нужно настроить проксирование UI graylog на 443 порт, сертификат выпустить самоподписанный.
Обязательно должны быть дашборны cpu,ram,disk,network остальные по желанию. Dashboards
Ожидаемый результат, запускаем ансибл роль, ждем, ждем и открываем в браузере наш graylog.



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