#!/bin/sh
# Instalacao do serviço de monitoramento
# Zabbix 4, Grafana e agregados

yum -y install mariadb-server mariadb
systemctl start mariadb
mysql_secure_installation
# P@ssword2020!
systemctl enable mariadb.service

rpm -Uvh https://repo.zabbix.com/zabbix/4.4/rhel/7/x86_64/zabbix-release-4.4-1.el7.noarch.rpm
yum clean all
yum -y install zabbix-server-mysql zabbix-web-mysql zabbix-agent
mysql -uroot -p
# mysql> create database zabbix character set utf8 collate utf8_bin;
# mysql> grant all privileges on zabbix.* to zabbix@localhost identified by 'password';
# mysql> quit;

zcat /usr/share/doc/zabbix-server-mysql*/create.sql.gz | mysql -uzabbix -p zabbix

echo "DBPassword=password" >> /etc/zabbix/zabbix_server.conf
sed -i 's/^"# php_value date.timezone Europe/Riga"/"php_value date.timezone America/Sao_Paulo"/' /etc/httpd/conf.d/zabbix.conf
systemctl restart zabbix-server zabbix-agent httpd
systemctl enable zabbix-server zabbix-agent httpd
