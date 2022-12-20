#!/bin/bash
wget https://repo.zabbix.com/zabbix/6.2/debian/pool/main/z/zabbix-release/zabbix-release_6.2-4%2Bdebian11_all.deb
dpkg -i zabbix-release_6.2-4+debian11_all.deb
apt update

apt install zabbix-server-pgsql zabbix-frontend-php php7.4-pgsql zabbix-nginx-conf zabbix-sql-scripts zabbix-agent
sudo apt-get -y install postgresql

sudo -u postgres createuser --pwprompt zabbix >> EOF
password
password
EOF
sudo -u postgres createdb -O zabbix zabbix

zcat /usr/share/zabbix-sql-scripts/postgresql/server.sql.gz | sudo -u zabbix psql zabbix

 sudo sed -i 's/# DBPassword=password/DBPassword='$passDB' /etc/zabbix/zabbix_server.conf

 sudo sed -i 's/'# listen 8080;'/'listen 80;'/ /etc/zabbix/nginx.conf
 sudo sed -i 's/'# server_name example.com;'/'server_name $domain;'/ /etc/zabbix/nginx.conf

sud
