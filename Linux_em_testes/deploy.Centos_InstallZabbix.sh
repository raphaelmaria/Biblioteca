#!/bin/sh
# DESCRICAO: EFETUADO INSTALAÇÃO DO STORAGE EM SAMBA COM IPA
# SINOPSE: 
# USO/EXEMPLO: .\Install_SFZ.sh
#
# OPCOES: NÃO POSSUI OPÇÃO
# AUTHOR: Raphael Maria <http://raphaelmaria.com.br>
# VERSAO: 0.0.1
# LICENCA: LICENSE GPL <http://gnu.org/licenses/gpl.html>


######### INSTALAÇÃO ZABBIX VIA DOCKER
timedatectl set-timezone America/Sao_Paulo

# Install Cockpit
yum -y install cockpit
systemctl enable --now cockpit.socket
firewall-cmd --permanent --zone=public --add-service=cockpit
firewall-cmd --reload
# Instalação de softwares básicos.
yum -y install dialog wget tar unzip vim make gcc dnf epel-release ipa-client
yum -y install net-tools tcpdump nano curl 

##### VARIAVEIS
VARHOSTNAME=$(dialog --stdout --inputbox 'Insira o nome  do hostname desta maquina: ' 0 0)
VARIPADDRESS=$(dialog --stdout --inputbox 'Insira o IP ADDRESS do hostname desta maquina: ' 0 0)
VARGATEWAY=$(dialog --stdout --inputbox 'Insira o GATEWAY do hostname desta rede: ' 0 0)

hostnamectl set-hostname $VARHOSTNAME
# Altera somente o IP Address de DHCP para FIXO com o ip designado anterimente.
VARINTERFACE=$(nmcli con show | tail -1 | awk '{print $1}')
nmcli con modify $VARINTERFACE ipv4.method manual ipv4.addresses $VARIPADDRESS/16 ipv4.gateway 192.168.8.1 ipv4.dns 192.168.8.100,192.168.8.110 ipv4.dns-search o2pos.com.br
nmcli con up $VARINTERFACE

# Instalação do Ansible
yum -y install ansible  epel-release
yum provides pip
yum install python2-pip -y
pip2 install pip --upgrade
pip2 install ansible
pip2 install ansible --upgrade

# Setup SELINUX
setenforce 0
getenforce
sestatus

rpm -Uvh https://repo.zabbix.com/zabbix/5.0/rhel/8/x86_64/zabbix-release-5.0-1.el8.noarch.rpm
dnf clean all
dnf install zabbix-server-mysql zabbix-web-mysql zabbix-nginx-conf zabbix-agent
 '''
Configure the database for Zabbix server
Edit file /etc/zabbix/zabbix_server.conf

DBPassword=password
e. Configure PHP for Zabbix frontend
Edit file /etc/nginx/conf.d/zabbix.conf, uncomment and set 'listen' and 'server_name' directives.

# listen 80;
# server_name example.com;
Edit file /etc/php-fpm.d/zabbix.conf, uncomment and set the right timezone for you.

; php_value[date.timezone] = Europe/Riga
 '''

systemctl restart zabbix-server zabbix-agent nginx php-fpm
systemctl enable zabbix-server zabbix-agent nginx php-fpm


firewall-cmd --zone=public --add-masquerade --permanent
irewall-cmd --get-default-zone
firewall-cmd --set-default-zone=public
firewall-cmd --permanent --add-service=http
firewall-cmd --permanent --add-service=zabbix-agent
firewall-cmd --permanent --zone=public --add-port=10050/tcp
firewall-cmd --permanent --zone=public --add-port=8080/tcp
firewall-cmd --permanent --zone=public --add-port=80/tcp
firewall-cmd --reload
firewall-cmd --list-all
firewall-cmd reload







