#!/bin/sh
##################################
## Script desenvolvido por Raphael Maria
## 
## INSTALACAO DE ZABBIX AGENT EM LINUX
##  
## Criado em 01/08/2019 as 18h14m
## Versao de 0.1
## Usado na O2 Pos Producoes Ltda.

#Instalação Zabbix
rpm -ivh http://repo.zabbix.com/zabbix/2.4/rhel/6/x86_64/zabbix-release-2.4-1.el6.noarch.rpm
yum -y install zabbix-agent.x86_64
service zabbix-agent stop
sed -i 's/^Server=127.0.0.1/Server=192.168.8.4/' /etc/zabbix/zabbix_agentd.conf
sed -i 's/^Hostname=Zabbix server/Hostname=SRVO2OVT02/' /etc/zabbix/zabbix_agentd.conf
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
exit