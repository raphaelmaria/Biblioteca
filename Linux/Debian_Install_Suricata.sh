#!/usr/bin/env bash

sudo apt -y install curl vim 

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

