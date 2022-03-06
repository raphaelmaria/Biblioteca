#!/bin/env bash





# INSTALL ZABBIX REPOSITORY
wget https://repo.zabbix.com/zabbix/6.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.0-1+ubuntu20.04_all.deb
sudo dpkg -i zabbix-release_6.0-1+ubuntu20.04_all.deb
sudo apt update

# INSTALL Zabbix server, Frontend, Agent
sudo apt install zabbix-server-mysql zabbix-frontend-php zabbix-nginx-conf zabbix-sql-scripts zabbix-agent

# CREATE INITIAL DATABASE
sudo mysql -uroot -p -e "create database zabbix character set utf8mb4 collate utf8mb4_bin;"
sudo mysql -uroot -p -e "create user zabbix@localhost identified by 'password';"
sudo mysql -uroot -p -e "grant all privileges on zabbix.* to zabbix@localhost;"
sudo mysql -uroot -p -e "quit;"
sudo zcat /usr/share/doc/zabbix-sql-scripts/mysql/server.sql.gz | mysql -uzabbix -p zabbix

# Configure the database for Zabbix server

sudo sed -i 's/#DBPassword=/DBPassword=password' /etc/zabbix/zabbix_server.conf

# Configure PHP for Zabbix frontend
sudo sed -i 's/# listen 80;/listen 80;'  /etc/zabbix/nginx.conf
sudo sed -i 's/# server_name example.com;/server_name $urlDomain;' /etc/zabbix/nginx.conf

#  Start Zabbix server and agent processes
sudo systemctl restart zabbix-server zabbix-agent nginx php7.4-fpm
sudo systemctl enable zabbix-server zabbix-agent nginx php7.4-fpm