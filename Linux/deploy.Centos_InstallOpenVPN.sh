#!/bin/sh
# INSTALACAO BASICA PARA WORKSTATIONS LINUX
# VERSAO CENTOS 7.x.x
# CRIADO POR RAPHAEL MARIA.
# EM 18 DE FEVEREIRO DE 2020.
# VERSAO 1.0
##############################################
#
############### VARIAVEIS ####################
varhostname=CONTOSOSRV

##### PACOTE BASICO ######
hostnamectl set-hostname $varhostname
yum -y install epel-release
yum -y update
yum -y upgrade
yum -y install wget vim tar unzip make
yum -y install cockpit
systemctl enable --now cockpit.socket

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