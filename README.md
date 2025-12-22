## Запуск
в /home/alrex/pro
```bash
ansible-playbook -i hosts run.yml --diff
```
переменные
/vars/main.yml

для отладки - пропускает некоторые таски
`run: true`

Просто удаление установки
`uninstall: true`


## Локальные пакеты для установки

roles/graylog_offline_install/files/

## Вход на сервер
Логин: alrex
пароль после первоначального входа: `Qwadro4x4`



sudo tail -n 50 /var/log/graylog-server/server.log