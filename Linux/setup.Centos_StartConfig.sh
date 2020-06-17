#!/bin/sh
# DESCRICAO: Efetua a configuração inicial do host.
# SINOPSE: Efetua a instalação inicial do Host
# USO/EXEMPLO: ./setup.Centos_StartConfig.sh
#
# OPCOES: 
# AUTHOR: Raphael Maria <http://raphaelmaria.com.br>
# VERSAO: 0.0.1
# LICENCA: LICENSE GPL <http://gnu.org/licenses/gpl.html>

##### VARIAVEIS
dialog --inputbox 'Insira o nome  do hostname desta maquina: ' 10 50 >$VARHOSTNAME
dialog --inputbox 'Insira o IP ADDRESS do hostname desta maquina: ' 15 50 >$VARIPADDRESS

hostnamectl set-hotname $VARHOSTNAME
# Altera somente o IP Address de DHCP para FIXO com o ip designado anterimente.
VARINTERFACE=${nmcli con show | tail -1 | awk '{print $1}'}
nmcli con modify $VARINTERFACE ipv4.method manual ipv4.addresses $VARIPADDRESS/24
nmcli con up $VARINTERFACE

# Instalação de softwares básicos.
yum -y install wget tar unzip vim make gcc dnf autoconf automake epel-release 

# Instala o Dashboard WEB Red Hat Cockpit
yum -y install cockpit
systemctl enable --now cockpit.socket
firewall-cmd --permanent --zone=public --add-service=cockpit
firewall-cmd --reload