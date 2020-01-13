#!/bin/bash
# Script
# INSTALANDO O GRAFANA NO CENTOS 8
# CRIADO POR RAPHAEL MARIA
# 13 DE JANEIRO DE 2020

# INSTALANDO O GRAFANA
yum update -y
yum install https://s3-us-west-2.amazonaws.com/grafana-releases/release/grafana-5.1.0-1.x86_64.rpm
yum install wget -y
yum -y install initscripts fontconfig
rpm -Uvh grafana-5.1.0-1.x86_64.rpm
yum -y install fontconfig.*
yum -y install freetype.*
yum -y install -y urw-fonts
sudo /sbin/chkconfig --add grafana-server
sudo service grafana-server start

# ALTERANDO PORTA DO GRAFANA PARA 3000
systemctl start firewalld
firewall-cmd --get-default-zone
firewall-cmd --set-default-zone=public
firewall-cmd --permanent --add-port=3000/tcp
firewall-cmd --permanent --add-port=80/tcp
firewall-cmd --reload
firewall-cmd --list-all

sudo setcap 'cap_net_bind_service=+ep' /usr/sbin/grafana-server 
sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 3000





# INSTALANDO PLUGINS UTEIS
grafana-cli plugins install raintank-worldping-app
grafana-cli plugins install alexanderzobnin-zabbix-app
grafana-cli plugins install grafana-clock-panel
grafana-cli plugins install ntop-ntopng-datasource

