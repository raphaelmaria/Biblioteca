#!/bin/sh
# DESCRICAO: EFETUA INSTALACAO DO SAMBA E CONFIGURAÇÃO DO ACTIVE DIRECTORY
# SINOPSE: Efetua a instalação de pacotes e reconfiguração do Active Directory
# USO/EXEMPLO: .\Install_SAMBA_ADDS.sh 
#
# OPCOES: 
# AUTHOR: Raphael Maria <http://raphaelmaria.com.br>
# VERSAO: 0.0.1
# LICENCA: LICENSE GPL <http://gnu.org/licenses/gpl.html>

echo "Digite o nome do Dominio: "
read URLDOMAIN

echo "Digite o IP do servidor: "
read IPADDRESS

echo "Digite a mascara: "
read IPMASK

echo "Digite o GATEWAY: "
read GATEWAY




sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y
sudo apt-get install vim -y

#
# Instalando o Samba 4 e o Kerberos 5
#
sudo apt-get install samba krb5-user krb5-config winbind libpam-winbind libnss-winbind -y << EOF
$URLDOMAIN
$URLDOMAIN
$URLDOMAIN
EOF
sudo systemctl stop samba-ad-dc.service smbd.service nmbd.service winbind.service
sudo systemctl disable samba-ad-dc.service smbd.service nmbd.service winbind.service
sudo mv /etc/samba/smb.conf /etc/samba/smb.conf.original
sudo samba-tool domain provision --use-rfc2307 --interactive << EOF
$URLDOMAIN




8.8.8.8
P4s5@2020Bras1l
EOF

touch /ADM_DOMAIN.txt
echo "DOMINIO\Administrator
Administrator@dominio.local" >> /ADM_DOMAIN.txt

echo" Seu dominio foi configurado com sucesso até agora,
anote seu usuário e sua senha de administrador do dominio
em um local seguro.
===============================
User: $URLDOMAIN\Administrador
Password: P4s5@2020Bras1l
===============================
Obs.: Uma copia foi salva na raiz do seu disco."

### SENHA DO ADM DA VM O22013lx!

# Iniciando configuração.
sudo mv /etc/krb5.conf /etc/krb5.conf.original
sudo ln -s /var/lib/samba/private/krb5.conf /etc/
ls -l /etc/krb5.conf
sudo systemctl unmask samba-ad-dc.service
sudo systemctl start samba-ad-dc.service
sudo systemctl enable samba-ad-dc.service
sudo systemctl status samba-ad-dc.service
sudo samba-tool domain level show

# Mudando o DNS padrão do Linux e removendo o Link do Resolv.conf
sudo su
apt-get install resolvconf
unlink /etc/resolv.conf
systemctl stop systemd-resolved
systemctl disable systemd-resolved

echo "
search $URLDOMAIN
domain $URLDOMAIN
nameserver $IPADDRESS" >> /etc/resolv.conf

touch /etc/netplan/01-netcfg.yaml
echo "network:
version: 2
renderer: networkd
ethernets:
enp0s3:
dhcp4: no
addresses: $IPADDRESS/24 
gateway4: $IPGATEWAY
nameservers:
search: $URLDOMAIN
addresses: $IPADDRESS" > /etc/netplan/01-netcfg.yaml

exit