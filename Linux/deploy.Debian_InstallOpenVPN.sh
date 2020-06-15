#!/bin/sh
# INSTALACAO BASICA PARA WORKSTATIONS LINUX
# VERSAO CENTOS 7.x.x
# CRIADO POR RAPHAEL MARIA.
# EM 18 DE FEVEREIRO DE 2020.
# VERSAO 1.0

# DADOS DO SERVIDOR
echo HOSTNAME?
read varhostname

echo IP ADDRESS?
read varip

##### PACOTE BASICO ######


##### CONFIGURANDO ETH #####
sudo nano /etc/network/interfaces
sudo cp  /etc/network/interfaces /etc/network/interfaces_backup

echo "
#These lines, or something similar to them, should already exist
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet dhcp

#We need to add the lines below this one
auto eth0:1
iface eth0:1 inet static
  address 192.168.15.10
  netmask 255.255.255.0" >> /etc/network/interfaces

sudo nano /etc/sysctl.conf
net.ipv4.ip_forward = 1
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.all.send_redirects = 0

sysctl -p /etc/sysctl.conf

##### Instalação VPN #####
##### FONTE #####
'''
https://site.elastichosts.com/blog/linux-l2tpipsec-vpn-server/
'''
sudo apt-get update
sudo apt-get install openswan xl2tpd
apt-get install iptables-persistent
sudo cp /etc/ipsec.conf /etc/ipsec.conf.backup

echo"config setup
nat_traversal=yes
virtual_private=%v4:10.0.0.0/8,%v4:192.168.0.0/16,%v4:172.16.0.0/12
oe=off
protostack=netkey
conn L2TP-PSK
authby=secret
pfs=no
auto=add
keyingtries=3
rekey=yes
ikelifetime=8h
keylife=1h
type=transport
left=

[lns default]
ip range = 192.168.15.50-192.168.15.60
local ip = 192.168.15.1
refuse chap = yes
refuse pap = yes
require authentication = yes
name=lardascortinas-vpn-server
ppp debug = yes
pppoptfile = /etc/ppp/options.xl2tpd
length bit = yes" >> /etc/ipsec.conf

sudo cp /etc/ppp/options.xl2tpd /etc/ppp/options.xl2tpd.backup
echo "
require-mschap-v2
ms-dns 8.8.8.8
ms-dns 4.2.2.1
ms-dns 8.8.4.4
proxyarp
asyncmap 0
auth
crtscts
lock
hide-password
modem
debug" >> /etc/ppp/options.xl2tpd

sudo cp /etc/ppp/chap-secrets /etc/ppp/chap-secrets.backup
echo "
# Secrets for authentication using CHAP
# client        server                           secret                       IP addresses
*               elastichosts-vpn-server          a-secure-chap-secret         *
" >> /etc/ppp/chap-secrets

iptables -t nat -A POSTROUTING -o eth0 -s 192.168.0.0/24 -j MASQUERADE
iptables-save > /etc/iptables/rules.v4

/etc/init.d/ipsec start
/etc/init.d/xl2tpd start

update-rc.d ipsec defaults
update-rc.d xl2tpd defaults







echo "###############################"
echo "#### INSTALACAO FINALIZADA ####"
echo "###############################"
reboot
