#!/usr/bin/env bash

sudo apt -y install curl vim wget apt-transport-https

sudo add-apt-repository ppa:oisf/suricata-stable
echo "deb http://deb.debian.org/debian bullseye-blackports main" > /etc/apt/source.list.d/backports.list

sudo apt update

sudo apt -y install suricata suricata-update -t bullseye-backports

sudo apt -y install network-manager
INTERFACE=$(nmcli device show | awk '/DEVICE/ {print $2}' | head -n 1)
echo "Escreva seu escopo de rede local. Ex.: 192.168.x.x/24"
read RANGEIP


sed -i '19 s/^/#/' /etc/default/suricata && sed -i '20 a\IFACE='$INTERFACE'' /etc/default/suricata
sed -i '18 s/^/#/' /etc/suricata/suricata.yaml && sed -i '19 a\HOME_NET: "['$RANGEIP']"' /etc/suricata/suricata.yaml
sed -i '24 s/^/#/' /etc/suricata/suricata.yaml && sed -i '25 a\EXTERNAL_NET: "any"' /etc/suricata/suricata.yaml

# Visualização de Alertas numa tentativa de ataque real
# Elastic Search
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee /etc/apt/source.list.d/elastic-7.x.list
sudo apt update && sudo apt -y install elasticsearch
sudo systemctl enable elasticsearch.service --now

# Evebox
wget -qO - https://evebox.org/files/GPG-KEY-evebox | sudo apt-key add -
echo "deb http://files.evebox.org/evebox/debian stable main" | sudo tee /etc/apt/source.list.d/evebox.list
sudo apt update && sudo apt -y install evebox