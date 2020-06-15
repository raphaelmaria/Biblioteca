#!/bin/bash
# Script
# INSTALANDO O GRAFANA NO CENTOS 8
# CRIADO POR RAPHAEL MARIA
# 13 DE JANEIRO DE 2020


yum -y install wget nss dkms dnf snapd vim ansible libselinux-python nfs-utils tcsh libXext libSM libXrender Xvfb xorg-x11-server-Xorg xorg-x11-xauth xorg-x11-apps
yum -y groupinstall "X Window System"
yum -y groupinstall "Fonts"
export FONTCONFIG_PATH=/etc/fonts

# Install Cockpit
yum -y install cockpit
systemctl enable --now cockpit.socket
firewall-cmd --permanent --zone=public --add-service=cockpit
firewall-cmd --reload
echo " Cockpit instalado com sucesso" /
echo " Abra um navegador e digite https://<IP da maquina>:9090" /

# INSTALANDO O GRAFANA
yum update -y
wget https://dl.grafana.com/oss/release/grafana-6.5.2-1.x86_64.rpm
yum install wget -y
yum -y install initscripts fontconfig
sudo yum localinstall grafana-6.5.2-1.x86_64.rpm
yum -y install fontconfig.*
yum -y install freetype.*
yum -y install urw-fonts

# ALTERANDO PORTA DO GRAFANA PARA 3000
systemctl start firewalld
firewall-cmd --get-default-zone
firewall-cmd --set-default-zone=public
firewall-cmd --add-service=grafana-server --permanent
firewall-cmd --permanent --add-port=3000/tcp
firewall-cmd --permanent --add-port=80/tcp
firewall-cmd --permanent --add-port=3001/tcp
firewall-cmd --permanent --add-port=3306/tcp
firewall-cmd --reload
firewall-cmd --list-all

sudo setcap 'cap_net_bind_service=+ep' /usr/sbin/grafana-server 
sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 3000

# INSTALAR BANCO DE DADOS LOCAIS
cat <<EOF | tee /etc/yum.repos.d/MariaDB.repo
[mariadb]
name = MariaDB
baseurl = http://yum.mariadb.org/10.4/centos7-amd64
gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
gpgcheck=1
EOF

yum makecache fast
yum -y install MariaDB-server MariaDB-client
yum -y install php-mysqlnd

systemctl enable --now mariadb
systemctl status mariadb

mysql_secure_installation


#### CRIACAO INTERATIVA DE DB MARIADB ####

mysql -u root -p << EOF
"create database dashdb character set utf8 collate utf8_bin;"
"grant all privileges on local.* to dashdb@localhost identified by 'password';"
"quit;"
EOF

systemctl enable grafana-server
systemctl start grafana-server

# INSTALANDO PLUGINS UTEIS
grafana-cli plugins install alexanderzobnin-zabbix-app
grafana-cli plugins install grafana-clock-panel
grafana-cli plugins install ntop-ntopng-datasource
grafana-cli plugins install grafana-piechart-panel
grafana-cli plugins install praj-ams-datasource
grafana-cli plugins install cognitedata-datasource
grafana-cli plugins install larona-epict-panel
grafana-cli plugins install agenty-flowcharting-panel
grafana-cli plugins install ddurieux-glpi-app
grafana-cli plugins install monitoringartist-monitoringart-datasource

systemctl restart grafana-server
