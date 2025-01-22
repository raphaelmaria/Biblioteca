#!/bin/sh
# Script de instalacao das VMs do Marcelo.
# Baseado em Ubuntu 18.04
# Criado e documentado por Raphael Maria
# Em 08 de Abril de 2020 as 18h20m
# 


# Scripts maquina do marcelo

# Instalacao padrao de essenciais
apt-get update
reboot
hostnamectl set-hostname <name>.o2pos.com.br
reboot

apt -y install gcc unzip wget dkms git vim ansible
export FONTCONFIG_PATH=/etc/fonts
apt-get remove cloud-init -y

# Ovirt Guest Monitor
apt-get install ovirt-guest-agent -y
systemctl enable ovirt-guest-agent
systemctl start ovirt-guest-agent
systemctl status ovirt-guest-agent
echo "* * */1 * * root apt update install ovirt-guest-agent -y" >> /etc/crontab

# Install Cockpit
apt-get -y install cockpit
systemctl enable --now cockpit.socket

# Instalacao Zabbix
echo "INICIANDO INSTALACAO DO ZABBIX"
echo " AGUARDE O PROCESSO"
service zabbix-agent stop
killall -TERM zabbix_agentd
apt autoremove -y
apt purge zabbix-agent -y
rm -rf /etc/zabbix
rm -rf /var/run/zabbix

apt install zabbix-agent -y
sed -i 's/^Server=127.0.0.1/Server=192.168.8.4/' /etc/zabbix/zabbix_agentd.conf
sed -i 's/^Hostname=Zabbix server/Hostname='$HOSTNAME'/' /etc/zabbix/zabbix_agentd.conf
sudo ufw allow proto tcp from 192.168.8.4 to any port 10050

systemctl enable zabbix-agent
systemctl start zabbix-agent
service zabbix-agent restart

# Criar usuario o2pos e Ansible
adduser o2pos
usermod -aG sudo o2pos
sudo passwd o2pos

adduser ansible
mkdir /home/ansible/.ssh
chmod 755 /home/ansible/.ssh
chown root:root /home/ansible/.ssh
echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCu8wGTaS91Z+UZ3xHi+SSjcHBFOppzv82SPhqAltlS39iQG3VTfTswkltrqSnbBBhu19yeQJYX28TimShsuKkd2iE1GQmkV/ej69DICMI4JslPeb1r8Wt+TXuG09TLi9Ok2GpKZBUsDfIFEWoKwxat1bAQZMoWPnfrq/H40HDUqJfTWsKiSA7Zq2GH/ClD8oDh/bO8WLDAOBPbQmF7hiRETWmt1JqNawerLCxpsSJZShb5jrxpRdfnbGdPFA06/o/oMm4pVxTniiosFr+1gJusIpyoTtZv+maJHIGyPBJ/h5zYlxUlACYT31AZ+VWrKaRGa17IIc005qqGAy4oTiKj mferreira@ubuntu' >> /home/ansible/.ssh/authorized_keys
chmod 644 /home/ansible/.ssh/authorized_keys
chown root:root /home/ansible/.ssh/authorized_keys
usermod -aG sudo ansible
sudo passwd ansible

# Atualização de OS
apt-get full-upgrade -y

# Entra no dominio FreeIPA
hostnamectl set-hostname $HOSTNAME.o2pos.com.br
apt-get install freeipa-client -y
ipa-client-install --mkhomedir

