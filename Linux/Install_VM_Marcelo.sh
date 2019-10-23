#!/bin/sh
# Script de instalacao das VMs do Marcelo.
# Baseado em CentOS 7 (provaval que rode na versao 8)
# Criado e documentado por Raphael Maria
# Em 11 de Outubro de 2019 as 11h17m
# 


# Scripts maquina do marcelo

# Instalacao padrao de essenciais
yum -y install gcc unzip wget nss dkms git dnf snapd vim ansible libselinux-python
yum -y install nfs-utils tcsh libXext libSM libXrender Xvfb xorg-x11-server-Xorg xorg-x11-xauth xorg-x11-apps
yum -y groupinstall "X Window System"
yum -y groupinstall "Fonts"
export FONTCONFIG_PATH=/etc/fonts

# Ovirt Guest Monitor
yum -y install epel-release
yum install ovirt-guest-agent-common
systemctl enable ovirt-guest-agent.service
systemctl start ovirt-guest-agent.service
systemctl status ovirt-guest-agent.service

# Instalacao Python 3
yum install centos-release-scl
yum install rh-python36
scl enable rh-python36 bash

# Install Cockpit
yum -y install cockpit
systemctl enable --now cockpit.socket
firewall-cmd --permanent --zone=public --add-service=cockpit
firewall-cmd --reload

# Instalacao Zabbix
rpm -ivh http://repo.zabbix.com/zabbix/2.4/rhel/6/x86_64/zabbix-release-2.4-1.el6.noarch.rpm
yum -y install zabbix-agent.x86_64
service zabbix-agent stop
sed -i 's/^Server=127.0.0.1/Server=192.168.8.4/' /etc/zabbix/zabbix_agentd.conf
sed -i 's/^Hostname=Zabbix server/Hostname=phrasernet/' /etc/zabbix/zabbix_agentd.conf
chkconfig zabbix on
chkconfig zabbix-agent on
mkdir /var/run/zabbix
chown zabbix.zabbix /var/run/zabbix/
zabbix_agentd -c /etc/zabbix/zabbix_agentd.conf
service zabbix-agent start
systemctl enable zabbix-agent
firewall-cmd --add-service=zabbix-agent
firewall-cmd --add-service=zabbix-agent  --permanent
service zabbix-agent restart

# Criar usuario o2pos e Ansible
adduser o2pos
usermod -a -G wheel o2pos
sudo passwd o2pos

adduser ansible
mkdir /home/ansible/.ssh
chmod 755 /home/ansible/.ssh
chown root:root /home/ansible/.ssh
echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCu8wGTaS91Z+UZ3xHi+SSjcHBFOppzv82SPhqAltlS39iQG3VTfTswkltrqSnbBBhu19yeQJYX28TimShsuKkd2iE1GQmkV/ej69DICMI4JslPeb1r8Wt+TXuG09TLi9Ok2GpKZBUsDfIFEWoKwxat1bAQZMoWPnfrq/H40HDUqJfTWsKiSA7Zq2GH/ClD8oDh/bO8WLDAOBPbQmF7hiRETWmt1JqNawerLCxpsSJZShb5jrxpRdfnbGdPFA06/o/oMm4pVxTniiosFr+1gJusIpyoTtZv+maJHIGyPBJ/h5zYlxUlACYT31AZ+VWrKaRGa17IIc005qqGAy4oTiKj mferreira@ubuntu' >> /home/ansible/.ssh/authorized_keys
chmod 644 /home/ansible/.ssh/authorized_keys
chown root:root /home/ansible/.ssh/authorized_keys
usermod -a -G wheel ansible
sudo passwd ansible

systemctl start firewalld
firewall-cmd --get-default-zone
firewall-cmd --set-default-zone=public
firewall-cmd --permanent --add-port=3306/tcp
firewall-cmd --permanent --add-port=4567/tcp
firewall-cmd --permanent --add-port=4568/tcp
firewall-cmd --permanent --add-port=4444/tcp
firewall-cmd --permanent --add-port=4567/udp
firewall-cmd --reload
firewall-cmd --list-all

### Configuracao de rede do CentOS / Fedora
nmcli con show
nmcli connection modify "System eth0" ipv4.method manual ipv4.addresses 192.168.8.96/16 ipv4.gateway 192.168.8.1 ipv4.dns 192.168.8.100,192.168.8.110 ipv4.dns-search o2pos.com.br
nmcli connection up "System eth0"

# Atualização de OS
yum check-update
yum update -y

hostnamectl set-hostname labappsrv.o2pos.com.br
yum install ipa-client -y
ipa-client-install --mkhomedir --no-ntp

