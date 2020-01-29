#!/bin/sh

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

