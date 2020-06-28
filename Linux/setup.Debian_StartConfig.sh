#!/bin/sh
# DESCRICAO: Efetua a configuração inicial do host Debian/Ubuntu
# SINOPSE: Efetua a configuração inicial do host Debian/Ubuntu
# USO/EXEMPLO: ./setup.Centos_StartConfig.sh
#
# OPCOES: 
# AUTHOR: Raphael Maria <http://raphaelmaria.com.br>
# VERSAO: 0.0.1 em 17 de junho de 2020
# LICENCA: LICENSE GPL <http://gnu.org/licenses/gpl.html>

# Instalação de softwares básicos.
apt install dialog tree wget tar unzip vim make gcc autoconf automake -y

##### VARIAVEIS
VARHOSTNAME=$(dialog --stdout --inputbox 'Insira o nome  do hostname desta maquina: ' 0 0)
VARIPADDRESS=$(dialog --stdout --inputbox 'Insira o IP ADDRESS do hostname desta maquina: ' 0 0)
VARGATEWAY=$(dialog --stdout --inputbox 'Insira o GATEWAY do hostname desta rede: ' 0 0)

hostnamectl set-hostname $VARHOSTNAME
# Altera somente o IP Address de DHCP para FIXO com o ip designado anterimente.
VARINTERFACE=$(nmcli con show | tail -1 | awk '{print $1, $2, $3}')
nmcli con modify $VARINTERFACE ipv4.method manual ipv4.addresses $VARIPADDRESS/24 ipv4.gateway $VARGATEWAY ipv4.dns 8.8.8.8,8.8.4.4,1.1.1.1
nmcli con up $VARINTERFACE

# Instala o Dashboard WEB Red Hat Cockpit
echo 'deb http://deb.debian.org/debian stretch-backports main' > \
 /etc/apt/sources.list.d/backports.list

apt-get update -y
apt-get install cockpit
systemctl enable --now cockpit.socket

# Fazendo update de todo os sistema operacional
apt -y upgrade
apt -y update


dialog --msgbox "Sua configuração iniciar foi concluida \nAcesse este dispositivo através do endereço \nhttps://$VARIPADDRESS:9090  \nusando o usuário de logado desta sessão do shell" 0 0
