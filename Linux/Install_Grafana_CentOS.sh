#!/bin/bash
# Script
# INSTALANDO O GRAFANA NO CENTOS 8
# CRIADO POR RAPHAEL MARIA
# 13 DE JANEIRO DE 2020

# INSTALANDO O GRAFANA
yum update -y
wget https://dl.grafana.com/oss/release/grafana-6.5.2-1.x86_64.rpm
yum install wget -y
yum -y install initscripts fontconfig
sudo yum localinstall grafana-6.5.2-1.x86_64.rpm
yum -y install fontconfig.*
yum -y install freetype.*
yum -y install -y urw-fonts
# sudo /sbin/chkconfig --add grafana-server
# sudo service grafana-server start


# ALTERANDO PORTA DO GRAFANA PARA 3000
systemctl start firewalld
firewall-cmd --get-default-zone
firewall-cmd --set-default-zone=public
firewall-cmd --add-service=grafana-server --permanent
firewall-cmd --permanent --add-port=3000/tcp
firewall-cmd --permanent --add-port=80/tcp
firewall-cmd --permanent --add-port=3001/tcp
firewall-cmd --reload
firewall-cmd --list-all

sudo setcap 'cap_net_bind_service=+ep' /usr/sbin/grafana-server 
sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 3000

# INSTALAR BANCO DE DADOS LOCAIS
yum -y install @mariadb
cat <<EOF >> /etc/yum.repos.d/mariadb.repo
[mariadb]
name = MariaDB
baseurl = http://yum.mariadb.org/10.4/centos8-amd64
gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
gpgcheck=1
EOF

systemctl start mariadb
systemctl enable mariadb
systemctl status mariadb

mysql_secure_installation


#### CRIACAO INTERATIVA DE DB MARIADB ####

echo "Entre com a senha de usuario root do seu MySQL password!"
echo "Note: password will be hidden when typing"
read passwd
mysql -u root -p $passwd -e "CREATE DATABASE teste2db;"
mysql -u root -p $passwd -e "CREATE USER teste2@localhost IDENTIFIED BY 'teste1234';"
mysql -u root -p $passwd -e "GRANT ALL PRIVILEGES ON teste2.* TO 'teste2db'@'localhost';"
mysql -u root -p $passwd -e "FLUSH PRIVILEGES;"

# COMANDO MANUAL
# mysql -u root -p mysql
# REATE DATABASE grafanadb;
# GRANT ALL ON grafanadb.* TO grafana@localhost IDENTIFIED BY 'grafana';

systemctl enable grafana-server
systemctl start grafana-server

# INSTALANDO PLUGINS UTEIS
grafana-cli plugins install raintank-worldping-app
grafana-cli plugins install alexanderzobnin-zabbix-app
grafana-cli plugins install grafana-clock-panel
grafana-cli plugins install ntop-ntopng-datasource
grafana-cli plugins install raintank-worldping-app
grafana-cli plugins install grafana-piechart-panel
grafana-cli plugins install praj-ams-datasource
grafana-cli plugins install cognitedata-datasource
grafana-cli plugins install larona-epict-panel
grafana-cli plugins install agenty-flowcharting-panel
grafana-cli plugins install ddurieux-glpi-app
grafana-cli plugins install monitoringartist-monitoringart-datasource

systemctl restart grafana-server

