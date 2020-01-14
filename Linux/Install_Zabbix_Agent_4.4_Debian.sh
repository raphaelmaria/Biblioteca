#!/bin/sh
##################################
## Script desenvolvido por Raphael Maria
## 
## INSTALACAO DE ZABBIX AGENT EM LINUX
##  
## Criado em 04/12/2019 as 15h23m
## Versao de 0.2
## Usado na O2 Pos Producoes Ltda.

#Instalação Zabbix
apt install zabbix-agent
service zabbix-agent stop
sed -i 's/^Server=127.0.0.1/Server=192.168.8.4/' /etc/zabbix/zabbix_agentd.conf
sed -i 's/^Hostname=Athena/Hostname=SRVO2OVT01/' /etc/zabbix/zabbix_agentd.conf
chkconfig zabbix on
chkconfig zabbix-agent on
mkdir /var/run/zabbix
chown zabbix.zabbix /var/run/zabbix/
zabbix_agentd -c /etc/zabbix/zabbix_agentd.conf
service zabbix-agent start
systemctl enable zabbix-agent
#firewall-cmd --add-service=zabbix-agent
#firewall-cmd --add-service=zabbix-agent  --permanent
service zabbix-agent restart
exit