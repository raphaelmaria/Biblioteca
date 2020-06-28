#!/bin/sh
# DESCRICAO: Efetua a configuração inicial do host CentOS 7 ou 8
# SINOPSE: Efetua a configuração inicial do host CentOS 7 ou 8
# USO/EXEMPLO: ./setup.Centos_StartConfig.sh
#
# OPCOES: 
# AUTHOR: Raphael Maria <http://raphaelmaria.com.br>
# VERSAO: 1.0.1 in 17 de Junho de 2020
# LICENCA: LICENSE GPL <http://gnu.org/licenses/gpl.html>

# Instalação de softwares básicos.
yum -y install dialog tree wget tar unzip vim make gcc dnf autoconf automake epel-release 

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

# Fazendo update de todo os sistema operacional
yum -y upgrade
yum -y update

# Instala o Dashboard WEB Red Hat Cockpit
yum -y install cockpit
systemctl enable --now cockpit.socket
firewall-cmd --permanent --zone=public --add-service=cockpit
firewall-cmd --reload

dialog --msgbox "Sua configuração iniciar foi concluida \nAcesse este dispositivo através do endereço \nhttps://$VARIPADDRESS:9090  \nusando o usuário de logado desta sessão do shell" 0 0