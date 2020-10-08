#!/bin/bash
# Script
# INSTALANDO O GRAFANA NO CENTOS 8
# CRIADO POR RAPHAEL MARIA
# 13 DE JANEIRO DE 2020

# Instalação de softwares básicos.
cd ~
mkdir grafanatmp
chmod -R 777 grafanatmp
cd grafanatmp
yum -y install dialog wget tar unzip vim make gcc dnf autoconf automake epel-release 

##### VARIAVEIS
VARHOSTNAME=$(dialog --stdout --inputbox 'Insira o nome  do hostname desta maquina: ' 0 0)
VARIPADDRESS=$(dialog --stdout --inputbox 'Insira o IP ADDRESS do hostname desta maquina: ' 0 0)
VARGATEWAY=$(dialog --stdout --inputbox 'Insira o GATEWAY do hostname desta rede: ' 0 0)


hostnamectl set-hostname $VARHOSTNAME
# Altera somente o IP Address de DHCP para FIXO com o ip designado anterimente.
VARINTERFACE=$(nmcli con show | tail -1 | awk '{print $1}')
nmcli con modify $VARINTERFACE ipv4.method manual ipv4.addresses $VARIPADDRESS/24 ipv4.gateway $VARGATEWAY ipv4.dns 8.8.8.8,8.8.4.4,1.1.1.1
nmcli con up $VARINTERFACE

# INSTALACOES COMPLEMENTARES E UPDATES
yum -y install ansible
yum provides pip
yum install python2-pip -y
pip2 install pip --upgrade
pip2 install ansible
pip2 install ansible --upgrade
yum check-update
yum update -y

# Install Cockpit
yum -y install cockpit
systemctl enable --now cockpit.socket
firewall-cmd --permanent --zone=public --add-service=cockpit
firewall-cmd --reload
echo " Cockpit instalado com sucesso" /
echo " Abra um navegador e digite https://<IP da maquina>:9090" /

# INSTALANDO O GRAFANA
yum update -y
wget https://dl.grafana.com/oss/release/grafana-6.5.2-1.x86_64.rpm
yum -y install initscripts fontconfig
sudo yum localinstall grafana-6.5.2-1.x86_64.rpm
wget https://dl.grafana.com/oss/release/grafana-7.2.0-1.x86_64.rpm
sudo yum localinstall grafana-7.2.0-1.x86_64.rpm
yum -y install fontconfig.*
yum -y install freetype.*
yum -y install urw-fonts

# ALTERANDO PORTA DO GRAFANA PARA 3000
systemctl start firewalld
firewall-cmd --get-default-zone
firewall-cmd --set-default-zone=public
firewall-cmd --permanent --add-port=3000/tcp
firewall-cmd --permanent --add-port=80/tcp
firewall-cmd --permanent --add-port=3001/tcp
firewall-cmd --permanent --add-port=3306/tcp

firewall-cmd --permanent --zone=public --add-service=http
firewall-cmd --permanent --zone=public --add-service=https
firewall-cmd --permanent --zone=public --add-service=grafana-server


firewall-cmd --reload
firewall-cmd --list-all

sudo setcap 'cap_net_bind_service=+ep' /usr/sbin/grafana-server 
sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 3000

systemctl enable grafana-server
systemctl start grafana-server

# INSTALANDO PLUGINS UTEIS
grafana-cli plugins install alexanderzobnin-zabbix-app
grafana-cli plugins install grafana-clock-panel
grafana-cli plugins install grafana-piechart-panel
grafana-cli plugins install praj-ams-datasource
grafana-cli plugins install larona-epict-panel
grafana-cli plugins install agenty-flowcharting-panel
grafana-cli plugins install ddurieux-glpi-app

echo "allow_loading_unsigned_plugins = 'alexanderzobnin-zabbix-app'" >> /etc/grafana/grafana.ini
echo "allow_loading_unsigned_plugins = alexanderzobnin-zabbix-datasource" >> /etc/grafana/grafana.ini
service grafana-server restart
cd ~
rm -rf grafanatmp
