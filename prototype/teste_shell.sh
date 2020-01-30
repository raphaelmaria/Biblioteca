#!/bin/sh
:<TERMINAL"
SCRIPT DE SETUP BASICA EM VMS
Configuracao inicial para VM's nova criadas no sistema Ovirt
Rodando em sua versao 1 com data de 29 de Janeiro de 2020 pelo criador RAPHAEL MARIA"
TERMINAL 

HOSTNAME=""
DOMAIN=""
INTERFACE="(nmcli con show | awk )"
IP=""
MASK=""
DNS1=""
DNS2=""
DNS3=""
hostnamectl set-hostname $HOSTNAME.$DOMAIN
nmcli con mod $INTERFACE 
nmcli con modify $INTERFACE ipv4.method manual ipv4.addresses $IP/$MASK ipv4.gateway 192.168.8.1 ipv4.dns $DNS1,$DNS2,$DNS3 ipv4.dns-search $DOMAIN

