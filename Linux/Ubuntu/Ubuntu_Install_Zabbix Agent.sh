#!/bin/bash
# Empresa: O2 POS PRODUCOES LTDA
# Desenvolvedor: Raphael xxxxx xx xxxxxxxxx Maria
# Cargo: Administrador de Redes
# Versão 1.0.1
# Criado em 15/06/2020
# Ticket Origem: 
# Solicitante:
# Descrição:
# Código com comentários:
'''
Descrição aqui
'''
############### VARIAVEIS AQUI ################
hostname=[Nome do Servidor]


# Script de Installação Debian/Ubuntu
#Instalação Basica
sudo apt upgrade -y && sudo apt update -y
sudo apt --fix-broken install
sudo apt install ansible vim wget git network-manager nfs-common diskinfo gcc dkms snapd chrony -y
sudo hostnamectl set-hostname $hostname.o2pos.com.br
sudo export PATH="$PATH:/sbin"
sudo export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# Instalação do Zabbix
sudo dpkg -i http://repo.zabbix.com/zabbix/2.4/rhel/6/x86_64/zabbix-release-2.4-1.el6.noarch.deb
sudo apt -y install zabbix-agent.x86_64
sudo service zabbix-agent stop
sudo sed -i 's/^Server=127.0.0.1/Server=192.168.8.4/' /etc/zabbix/zabbix_agentd.conf
sudo sed -i 's/^Hostname=Zabbix server/Hostname='$hostname'/' /etc/zabbix/zabbix_agentd.conf
sudo chkconfig zabbix on
sudo chkconfig zabbix-agent on
sudo mkdir /var/run/zabbix
sudo chown zabbix.zabbix /var/run/zabbix/
sudo zabbix_agentd -c /etc/zabbix/zabbix_agentd.conf
sudo service zabbix-agent start
sudo systemctl enable zabbix-agent
sudo service zabbix-agent restart

sudo nmcli con show
sudo nmcli connection modify "Wired connection 1" ipv4.method manual ipv4.addresses 192.168.7.23 ipv4.gateway 192.168.8.1 ipv4.dns 192.168.8.100,192.168.8.110 ipv4.dns-search o2pos.com.br
sudo nmcli connection up "Wired connection 1"
sudo systemd-resolve --flush-caches

###### Firewall Interno UFW Setup #####
'''
Exemplos para permitir (Allow):
sudo ufw allow [service]
sudo ufw allow [port]
sudo ufw allow [port]/protocol
sudo ufw allow [port start]:[port end]/protocol
sudo ufw allow  from [IP Address]
sudo ufw allow  from [IP Address] to any port [Number Port]
sudo ufw allow  from [Ranger IP Address]/[Mask]
sudo ufw allow  from [Ranger IP Address]/[Mask] to any port [Number Port]
sudo ufw allow  from [Interface Ethernet] to any port [Number Port]

Exemplos para negar (Deny):
Siga a mesma logica dos comandos acima, mas trocando a palavra "allow" por "deny".

Exemplos para deletar a regra:
sudo ufw delete allow [servico]
sudo ufw delete allow [Number Port]

Exemplos para DESATIVAR o Firewall UFW:
sudo ufw disable
Exemplos para REINICIAR o Firewall UFW:
sudo ufw reset
'''
# Ports
sudo ufw allow 22/tcp
sudo ufw allow 10050/tcp
sudo ufw allow 9090/tcp

# Services
sudo ufw allow ssh
sudo ufw allow zabbix-agent