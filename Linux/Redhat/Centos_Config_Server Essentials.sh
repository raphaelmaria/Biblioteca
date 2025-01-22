#!/bin/sh
# INSTALACAO BASICA PARA WORKSTATIONS LINUX
# VERSAO CENTOS 7.x.x
# CRIADO POR RAPHAEL MARIA.
# EM 18 DE FEVEREIRO DE 2020.
# VERSAO 1.0

# Instalação de softwares básicos.
yum -y install dialog wget tar unzip vim make gcc dnf autoconf automake epel-release 

##### VARIAVEIS
VARHOSTNAME=$(dialog --stdout --inputbox 'Insira o nome  do hostname desta maquina: ' 0 0)
VARIPADDRESS=$(dialog --stdout --inputbox 'Insira o IP ADDRESS do hostname desta maquina: ' 0 0)

hostnamectl set-hostname $VARHOSTNAME.o2pos.com.br

# Altera somente o IP Address de DHCP para FIXO com o ip designado anterimente.
VARINTERFACE=$(nmcli con show | tail -1 | awk '{print $1}')
nmcli con modify $VARINTERFACE ipv4.method manual ipv4.addresses $VARIPADDRESS/16 ipv4.gateway 192.168.8.1 ipv4.dns 192.168.8.100,192.168.8.110 ipv4.dns-search o2pos.com.br
nmcli con up $VARINTERFACE



echo "###############################"
echo "#### INSTALACAO FINALIZADA ####"
echo "###############################"
reboot
