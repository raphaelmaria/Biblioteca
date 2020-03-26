#!/bin/sh
# Script de configuração de servidor SAMBA
# Criado por Raphael Maria
# Em 20 de Dezembro de 2019
# Versao 1.0

# Requisitos 
# O Compartilhamento deve esta montando.


# INSTALACOES COMPLEMENTARES E UPDATES
yum -y install epel-release
yum check-update
yum update -y

yum -y install wget nss dkms git dnf snapd vim ansible libselinux-python nfs-utils tcsh libXext libSM libXrender Xvfb xorg-x11-server-Xorg xorg-x11-xauth xorg-x11-apps
yum install centos-release-scl -y
yum install rh-python36 -y
scl enable rh-python36 bash

# INSTALACAO DO PAINEL DE CONTROLE PARA SERVIDOR VIA WEB
yum -y install cockpit
systemctl enable --now cockpit.socket
firewall-cmd --permanent --zone=public --add-service=cockpit
firewall-cmd --reload

echo " PAINEL DE GESTADO DO SERVIDOR INSTALADO COM SUCESSO PARA ACESSAR "
echo " UTILIZE DIGITE IP:9090 EM UM NAVEGADOR "
echo " PARA FAZER LOGIN USE OS DADOS DOS USUARIOS CRIADOS LOCALMENTES NA MAQUINA "    

# Pacotes para instalacao
yum -y install samba samba-client samba-common

# SETUP SERVIDOR
echo "Nome do Servidor:"
read HOSTNAME
hostnamectl set-hostname $HOSTNAME

#INTERFACE = '(nmcli con show | awk 1git)'
echo "DIGITE O NOME DA PLACA DE REDE:"
read INTERFACE
echo "IP DESTINADO AO SERVIDOR"
read IPADDRESS
echo "MASCARA:"
read SUBNET
echo "DIGITE O GATEWAY DA REDE:"
read GATEWAY

nmcli connection modify $INTERFACE ipv4.method manual ipv4.addresses $IPADDRESS/$SUBNET ipv4.gateway $GATEWAY ipv4.dns 192.168.8.100,192.168.8.110 ipv4.dns-search o2pos.com.br
nmcli connection up $INTERFACE

systemctl stop firewalld
firewall-cmd --get-default-zone
firewall-cmd --set-default-zone=public
firewall-cmd --permanent --add-port=9090/tcp
firewall-cmd --reload
firewall-cmd --list-all

# Script para substituicao de SMB.CONF
mv /etc/samba/smb.conf /etc/samba/smb.bkp.conf
ulimit -n 16384
echo "* - nofile 16384" >> /etc/security/limits.conf

echo "Digite o caminho do Share:"
read SHARE
adduser "o2"
smbpasswd -a "o2"

echo "# See smb.conf.example for a more detailed config file or
# read the smb.conf manpage.
# Run 'testparm' to verify the config is correct after
# you modified it.

[global]
	workgroup = WORKGROUP
	netbios name = infoscale
	security = user

##### >>>> CONFIGURACAO DE LOGS
log file = /var/log/samba/%m.log
# Tamanho de Log e igual a 200Mb
max log size = 200000
# Nivel de Coleta de Log
log level = 1 auth:5

# Alta velocidade
strict locking = no
read raw = yes
write raw = yes
oplocks = yes
max xmit = 65535
deadtime = 15
getwd cache = yes
socket options = TCP_NODELAY	

[accounts]
	comment = Accounts data directory
	path = $SHARE
	valid users = o2
	public = yes
	writable = yes" > /etc/samba/smb.conf

chcon -Rt samba_share_t /mnt/slave

systemctl enable smb
systemctl start smb
systemctl enable nmb
systemctl start nmb



