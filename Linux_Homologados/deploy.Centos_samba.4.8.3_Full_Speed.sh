#!/bin/sh
# Script de configuração de servidor SAMBA
# Criado por Raphael Maria
# Em 20 de Dezembro de 2019
# Versao 1.0

# Requisitos 
# O Compartilhamento deve esta montando.

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

systemctl stop firewalld
systemctl disable firewalld
#firewall-cmd --get-default-zone
#firewall-cmd --set-default-zone=public
#firewall-cmd --permanent --add-port=9090/tcp
#firewall-cmd --reload
#firewall-cmd --list-all

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
	map to guest = Bad User
	guest ok = yes

##################################
#####     LOGS DO SAMBA    #######
##################################
log file = /var/log/samba/%m.log
# Tamanho de Log e igual a 200Mb
max log size = 200000
# Nivel de Coleta de Log
log level = 1 auth:5

###################################
####       TUNNING SAMBA     ######
###################################
strict locking = no
read raw = yes
write raw = yes
oplocks = yes
max xmit = 65535
deadtime = 15
getwd cache = yes
socket options = TCP_NODELAY	

[$SHARE]
	comment = Accounts data directory
	path = $SHARE
	valid users = o2
	public = yes
	writable = yes
	veto files = *.exe, *.tar, *.gz, *.sh

	vfs objects = recycle
	recycle:repository = Lixeira
	recycle:keeptree = yes
	recycle:versions = yes
	
	
	
	" > /etc/samba/smb.conf

chcon -Rt samba_share_t /storage
smbcontrol all reload-config

systemctl enable smb
systemctl start smb
systemctl enable nmb
systemctl start nmb



