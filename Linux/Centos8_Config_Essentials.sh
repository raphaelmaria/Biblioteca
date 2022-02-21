#!/bin/sh
# Instalação inicial
# Automatizacao de Instalacao de Servidores
# Itens Essenciais
# Criado por Raphael Maria
# Em 14 de Fevereiro de 2020

sed -i 's/\r$//' setup.Centos8_Essentials.sh
tr -d '\r' < script.sh > setup_centos8.sh
# Instalação de softwares básicos.
yum -y install dialog net-tools wget tar unzip vim make gcc dnf autoconf automake epel-release ipa-client

##### VARIAVEIS
VARHOSTNAME=$(dialog --stdout --inputbox 'Insira o nome  do hostname desta maquina: ' 0 0)
VARIPADDRESS=$(dialog --stdout --inputbox 'Insira o IP ADDRESS do hostname desta maquina: ' 0 0)
VARGATEWAY=$(dialog --stdout --inputbox 'Insira o GATEWAY do hostname desta rede: ' 0 0)

# Altera somente o IP Address de DHCP para FIXO com o ip designado anterimente.
VARINTERFACE=$(nmcli con show | tail -1 | awk '{print $1}')
nmcli con modify $VARINTERFACE ipv4.method manual ipv4.addresses $VARIPADDRESS/16 ipv4.gateway 192.168.8.1 ipv4.dns 192.168.8.100,192.168.8.110,192.168.8.15 ipv4.dns-search o2pos.com.br
nmcli con up $VARINTERFACE

hostnamectl set-hostname $VARHOSTNAME.o2pos.com.br
timedatectl set-timezone America/Sao_Paulo

# Install Cockpit
yum -y install cockpit
systemctl enable --now cockpit.socket

yum install ansible -y
yum install python2-pip -y
pip2 install pip --upgrade
pip2 install ansible
pip2 install ansible --upgrade

# Instalacao Zabbix
#rpm -ivh http://repo.zabbix.com/zabbix/2.4/rhel/6/x86_64/zabbix-release-2.4-1.el6.noarch.rpm
yum -y install zabbix-agent.x86_64
service zabbix-agent stop
sed -i 's/^Server=127.0.0.1/Server=192.168.8.4/' /etc/zabbix/zabbix_agentd.conf
sed -i 's/^Hostname=Zabbix server/Hostname='$VARHOSTNAME'/' /etc/zabbix/zabbix_agentd.conf
mkdir /var/run/zabbix
chown zabbix.zabbix /var/run/zabbix/
zabbix_agentd -c /etc/zabbix/zabbix_agentd.conf
systemctl start zabbix-agent
systemctl enable zabbix-agent
service zabbix-agent restart

##### PACOTE BASICO ######
yum update -y
yum upgrade -y

# Setup Configure Firewall
# Setup Firewall Interno
systemctl start firewalld
firewall-cmd --get-default-zone
firewall-cmd --set-default-zone=public
firewall-cmd --permanent --add-port=3306/tcp
firewall-cmd --permanent --add-port=9090/tcp
firewall-cmd --add-service=zabbix-agent  --permanent
firewall-cmd --add-service=http  --permanent
firewall-cmd --add-service=https  --permanent
firewall-cmd --reload
firewall-cmd --list-all
reboot