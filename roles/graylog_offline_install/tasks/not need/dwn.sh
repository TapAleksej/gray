#!/bin/bash
set -ex

# ============================================================
# Скрипт для скачивания оффлайн-пакетов Graylog на Red OS 7.3.6
# Компоненты: MongoDB 6.0, OpenSearch 2.11.0, Graylog 5.2
# Автор: ChatGPT (адаптировано под RedOS + dnf)
# ============================================================

BASE_DIR="$(pwd)"
FILES_DIR="$BASE_DIR/roles/graylog_offline_install/files"

echo "===> Создаю директорию: $FILES_DIR"
mkdir -p "$FILES_DIR"
cd "$FILES_DIR"

echo "===> Проверяю наличие dnf-plugins-core..."
sudo dnf install -y dnf-plugins-core

# ============================================================
# 1️⃣ MongoDB
# ============================================================
echo "===> Добавляю временный репозиторий MongoDB 6.0"
cat << 'EOF' | sudo tee /etc/yum.repos.d/mongodb-org-6.0.repo
[mongodb-org-6.0]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/7/mongodb-org/6.0/x86_64/
gpgcheck=0
enabled=1
EOF

echo "===> Скачиваю пакеты MongoDB..."
sudo dnf clean all
sudo dnf makecache
sudo dnf download --resolve mongodb-org-server mongodb-org-shell mongodb-org-mongos mongodb-org-tools || {
  echo "❌ Ошибка при скачивании MongoDB"
  exit 1
}

# ============================================================
# 2️⃣ OpenSearch
# ============================================================
echo "===> Скачиваю OpenSearch 2.11.0..."
wget -q --show-progress https://artifacts.opensearch.org/releases/bundle/opensearch/2.11.0/opensearch-2.11.0-linux-x64.rpm

# ============================================================
# 3️⃣ Graylog
# ============================================================
echo "===> Скачиваю репозиторий Graylog..."
wget -q --show-progress https://packages.graylog2.org/repo/packages/graylog-5.2-repository_latest.rpm

echo "===> Устанавливаю репозиторий Graylog (временно)"
sudo rpm -i graylog-5.2-repository_latest.rpm

echo "===> Скачиваю пакеты Graylog..."
sudo dnf download --resolve graylog-server graylog-integrations-plugins || {
  echo "❌ Ошибка при скачивании Graylog"
  exit 1
}

echo "===> Удаляю временный репозиторий Graylog"
sudo rm -f /etc/yum.repos.d/graylog.repo || true

# ============================================================
# 4️⃣ Проверка
# ============================================================
echo
echo "===> Список загруженных файлов:"
ls -lh "$FILES_DIR" | grep ".rpm"

echo
echo "✅ Все пакеты успешно загружены в $FILES_DIR"
echo "Теперь можно выполнять оффлайн установку через Ansible."
