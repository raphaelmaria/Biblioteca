#!/bin/sh
# INSTALACAO BASICA PARA WORKSTATIONS LINUX
# VERSAO CENTOS 7.x.x
# CRIADO POR RAPHAEL MARIA.
# EM 18 DE FEVEREIRO DE 2020.
# VERSAO 1.0
##############################################
#
############### VARIAVEIS ####################
varhostname=

##### PACOTE BASICO ######
hostnamectl set-hostname $varhostname
yum -y install epel-release
yum -y update
yum -y upgrade
yum -y install wget git dnf vim
yum -y install cockpit
systemctl enable --now cockpit.socket

##### Instalação VPN #####
##### FONTE #####
'''
https://www.hostinger.com.br/tutoriais/como-configurar-vpn-no-servidor-linux-com-openvpn/
'''
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

echo "###############################"
echo "#### INSTALACAO FINALIZADA ####"
echo "###############################"
reboot
