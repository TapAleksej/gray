#!/usr/bin/bash
#set -x

filecnfg="/etc/opensearch/opensearch.yml"

sudo sed -i "s/^#\?cluster.name:.*/cluster.name: graylog/" "${filecnfg}"
sudo sed -i "s/^#\?node.name:.*/node.name: ${HOSTNAME}/" "${filecnfg}"
#sudo sed -i 's/^#\?node.name:.*/node.name: ${HOSTNAME}/' "${filecnfg}"
sudo sed -i "s/^#\?network.host:.*/network.host: 0.0.0.0/" "${filecnfg}"


if ! grep -q "^discovery.type" "${filecnfg}"; then
# Добавляем строки в конец (через tee, чтобы сработал sudo)
  {
    echo "discovery.type: single-node"
    echo "action.auto_create_index: false"
    echo "plugins.security.disabled: true"
  } | sudo tee -a "${filecnfg}" > /dev/null
fi

if ! grep -q '^vm.max_map_count=262144' /etc/sysctl.conf; then
        echo "vm.max_map_count=262144" | sudo tee -a /etc/sysctl.conf > /dev/null
fi


 sudo sysctl -w vm.max_map_count=262144



 sudo systemctl daemon-reload
#cat "${filecnfg}"