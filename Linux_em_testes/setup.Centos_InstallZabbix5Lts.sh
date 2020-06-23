#!/bin/sh
# DESCRICAO: Script de Instalação do Zabbix 5 LTS em Ovirt VM
# SINOPSE: Efetua a instalação do Zabbix Server 5 LTS
# USO/EXEMPLO: ./setup.Centos_InstallZabbix5Lts.sh
#
# OPCOES: NÃO POSSUI OPÇÃO
# AUTHOR: Raphael Maria <http://raphaelmaria.com.br>
# VERSAO: 0.0.1
# LICENCA: LICENSE GPL <http://gnu.org/licenses/gpl.html>

# Instalação de softwares básicos.
yum -y install dialog wget tar unzip vim make gcc dnf autoconf automake epel-release ipa-client

##### VARIAVEIS
VARHOSTNAME=$(dialog --stdout --inputbox 'Insira o nome  do hostname desta maquina: ' 0 0)
VARIPADDRESS=$(dialog --stdout --inputbox 'Insira o IP ADDRESS do hostname desta maquina: ' 0 0)
VARGATEWAY=$(dialog --stdout --inputbox 'Insira o GATEWAY do hostname desta rede: ' 0 0)


hostnamectl set-hostname $VARHOSTNAME.o2pos.com.br
# Altera somente o IP Address de DHCP para FIXO com o ip designado anterimente.
VARINTERFACE=$(nmcli con show | tail -1 | awk '{print $1}')
nmcli con modify $VARINTERFACE ipv4.method manual ipv4.addresses $VARIPADDRESS/16 ipv4.gateway 192.168.8.1 ipv4.dns 192.168.8.100,192.168.8.110 ipv4.dns-search o2pos.com.br
nmcli con up $VARINTERFACE

hostnamectl set-hostname $VARHOSTNAME.o2pos.com.br
timedatectl set-timezone America/Sao_Paulo

# Setup Zabbix 5 LTS
rpm -Uvh https://repo.zabbix.com/zabbix/5.0/rhel/8/x86_64/zabbix-release-5.0-1.el8.noarch.rpm
dnf clean all
dnf install zabbix-server-mysql zabbix-web-mysql zabbix-apache-conf zabbix-agent

/etc/php.fpm.d/zabbix.conf America/Sao_Paulo

systemctl restart zabbix-server zabbix-agent httpd php-fpm
systemctl enable zabbix-server zabbix-agent httpd php-fpm