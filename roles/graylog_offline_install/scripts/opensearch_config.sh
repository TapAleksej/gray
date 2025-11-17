#!/usr/bin/bash
#set -x

filecnfg="/etc/opensearch/opensearch.yml"

sudo sed -i "s/^#\?cluster.name:.*/cluster.name: graylog/" "${filecnfg}"
#sudo sed -i "s/^#\?node.name:.*/node.name: ${HOSTNAME}/" "${filecnfg}"
sudo sed -i 's/^#\?node.name:.*/node.name: ${HOSTNAME}/' "${filecnfg}"
sudo sed -i "s/^#\?network.host:.*/network.host: 0.0.0.0/" "${filecnfg}"
#sudo sed -i "s/^#\?plugins.security.ssl.http.enabled: true*/plugins.security.ssl.http.enabled: false/" "${filecnfg}"




if ! grep -q "^discovery.type" "${filecnfg}"; then
# Добавляем строки в конец (через tee, чтобы сработал sudo)
  {
    echo "discovery.type: single-node"
    echo "action.auto_create_index: false"
    echo "plugins.security.disabled: true"
    echo "indices.query.bool.max_clause_count: 32768"
  } | sudo tee -a "${filecnfg}" > /dev/null
fi

 sudo sysctl -w vm.max_map_count=262144

if ! grep -q '^vm.max_map_count=262144' /etc/sysctl.conf; then
        echo "vm.max_map_count=262144" | sudo tee -a /etc/sysctl.conf > /dev/null
fi


 sudo systemctl daemon-reload
#cat "${filecnfg}"