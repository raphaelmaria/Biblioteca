#!/usr/bin/env bash

# FONTE: https://bestmonitoringtools.com/how-to-install-zabbix-on-raspberry-pi-raspbian/#Step_1_Install_Raspberry_Pi_OS_Raspbian_on_Raspberry_Pi
sudo apt update
sudo apt upgrade -y

sudo wget https://repo.zabbix.com/zabbix/6.0/raspbian/pool/main/z/zabbix-release/zabbix-release_6.0-2+debian$(cut -d"." -f1 /etc/debian_version)_all.deb
sudo dpkg -i zabbix-release_6.0-2+debian$(cut -d"." -f1 /etc/debian_version)_all.deb
sudo apt update
sudo apt -y install zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent

sudo apt -y install mariadb-server
sudo systemctl start mariadb
sudo systemctl enable mariadb

sudo passwd root << EOF
password
password
EOF

sudo mysql_secure_installation << EOF
password
y
y
password
password
y
y
y
y
EOF

mysql -uroot -p'password' -e "create database zabbix character set utf8mb4 collate utf8mb4_bin;"
mysql -uroot -p'password' -e "grant all privileges on zabbix.* to zabbix@localhost identified by 'zabbixDBpass';"

sudo zcat /usr/share/doc/zabbix-sql-scripts/mysql/server.sql.gz | mysql -uzabbix -p'zabbixDBpass' zabbix
sudo sed -i 's/^DBPassword=/DBPassword=zabbixDBpass/' /etc/zabbix/zabbix_server.conf
sudo systemctl restart zabbix-server zabbix-agent
sudo systemctl enable zabbix-server zabbix-agent

sudo sed -i '20c\php_value date.timezone America/Sao_Paulo/' /etc/zabbix/apache.conf 
sudo systemctl restart apache2
sudo systemctl enable apache2

# https://ora-600.com/2022/04/zabbix-locale-for-language-en_us-is-not-found-on-the-web-server-tried-to-set-en_us-en_us-utf8/


echo "Acesso IP/zabbix"
echo "User: Admin"
echo "Pass: zabbix"




