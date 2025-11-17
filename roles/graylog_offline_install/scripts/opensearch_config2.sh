#!/usr/bin/bash
set -x

filecnfg="/etc/opensearch/opensearch.yml"


# --- Очистка demo-конфига OpenSearch Security ---
sudo sed -i '/^######## Start OpenSearch Security Demo Configuration ########/,/^######## End OpenSearch Security Demo Configuration ########/d' "${filecnfg}"
sudo sed -i '/plugins\.security\.audit\.type/d' "${filecnfg}"
sudo sed -i '/plugins\.security\.authcz/d' "${filecnfg}"

# Базовые настройки
sudo sed -i "s/^#\?cluster.name:.*/cluster.name: graylog/" "${filecnfg}"
sudo sed -i 's/^#\?node.name:.*/node.name: ${HOSTNAME}/' "${filecnfg}"
sudo sed -i "s/^#\?network.host:.*/network.host: 0.0.0.0/" "${filecnfg}"

# Полностью отключаем HTTPS и security plugin
sudo sed -i "/^plugins.security.ssl/d" "${filecnfg}"
sudo sed -i "/^plugins.security.authcz/d" "${filecnfg}"
sudo sed -i "/^plugins.security.allow/d" "${filecnfg}"

sudo sed -i "/^plugins.security.restapi/d" "${filecnfg}"
sudo sed -i "/^plugins.security.audit/d" "${filecnfg}"
sudo sed -i "/^plugins.security.system_indices/d" "${filecnfg}"
sudo sed -i "/^plugins.security.enable_snapshot/d" "${filecnfg}"

# Отключить security plugin корректно
if ! grep -q "^plugins.security.disabled" "${filecnfg}"; then
  echo "plugins.security.disabled: true" | sudo tee -a "${filecnfg}" > /dev/null
fi

# Добавить системные параметры
if ! grep -q "^discovery.type" "${filecnfg}"; then
  echo "discovery.type: single-node" | sudo tee -a "${filecnfg}" > /dev/null
fi

if ! grep -q "^action.auto_create_index" "${filecnfg}"; then
  echo "action.auto_create_index: false" | sudo tee -a "${filecnfg}" > /dev/null
fi

# Системные параметры ядра
sudo sysctl -w vm.max_map_count=262144

if ! grep -q "vm.max_map_count=262144" /etc/sysctl.conf; then
  echo "vm.max_map_count=262144" | sudo tee -a /etc/sysctl.conf > /dev/null
fi

sudo systemctl daemon-reload
