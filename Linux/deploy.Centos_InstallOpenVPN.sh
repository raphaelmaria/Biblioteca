#!/bin/sh
# INSTALACAO BASICA PARA WORKSTATIONS LINUX
# VERSAO CENTOS 7.x.x
# CRIADO POR RAPHAEL MARIA.
# EM 18 DE FEVEREIRO DE 2020.
# VERSAO 1.0
##############################################
#
############### VARIAVEIS ####################
# Instalação de softwares básicos.
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

##### Instalação VPN #####
##### FONTE #####
'''
https://www.hostinger.com.br/tutoriais/como-configurar-vpn-no-servidor-linux-com-openvpn/
'''
wget https://swupdate.openvpn.org/community/releases/openvpn-2.4.9.tar.gz





sudo yum -y install net-tools
curl -O http://swupdate.openvpn.org/as/openvpn-as-2.7.3-CentOS7.x86_64.rpm
sudo rpm --install openvpn-as-*.rpm
passwd openvpn << EOF
vpnpassword
vpnpassword
EOF

echo 'net.ipv4.ip_forward=1' | sudo tee -a /etc/sysctl.d/99-sysctl.conf
sudo sysctl -p
sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1
sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1

##### FIREWALL SETUP #####
firewall-cmd --get-default-zone
firewall-cmd --set-default-zone=public
# Firewall Service Allow
firewall-cmd --permanent --zone=public --add-service=cockpit
firewall-cmd --permanent --zone=public --add-service=openvpn
firewall-cmd --permanent --zone=public --add-service=samba
firewall-cmd --permanent --zone=public --add-service=http
firewall-cmd --permanent --zone=public --add-service=https
# Firewall Port Allow
firewall-cmd --permanent --zone=public --add-port=9090/tcp
firewall-cmd --permanent --zone=public --add-port=1194/udp
firewall-cmd --permanent --zone=public --add-port=943/tcp
firewall-cmd --permanent --zone=public --add-port=443/tcp
firewall-cmd --permanent --zone=public --add-port=80/tcp
firewall-cmd --permanent --zone=public --add-port=22/tcp
firewall-cmd --reload
firewall-cmd --list-all

Sua instalação foi efetuada com sucesso, agora para efetuar a configuração abra seu navegador e entre no endereço https://IP LOCAL:943/admin, com usuário: 