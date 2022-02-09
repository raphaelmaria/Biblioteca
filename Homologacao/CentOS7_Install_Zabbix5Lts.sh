#!/bin/sh
# DESCRICAO: Script de Instalação do Zabbix 5 LTS em Ovirt VM
# SINOPSE: Efetua a instalação do Zabbix Server 5 LTS
# USO/EXEMPLO: ./setup.Centos_InstallZabbix5Lts.sh
#
# OPCOES: NÃO POSSUI OPÇÃO
# AUTHOR: Raphael Maria <http://raphaelmaria.com.br>
# VERSAO: 0.0.1
# LICENCA: LICENSE GPL <http://gnu.org/licenses/gpl.html>

# Instalação de softwares básicos.
yum install -y dialog wget tar unzip vim make gcc dnf autoconf automake epel-release ipa-client
yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm
yum-config-manager --enable remi-php74

##### VARIAVEIS
VARHOSTNAME=$(dialog --stdout --inputbox 'Insira o nome  do hostname desta maquina: ' 0 0)
VARIPADDRESS=$(dialog --stdout --inputbox 'Insira o IP ADDRESS do hostname desta maquina: ' 0 0)
VARGATEWAY=$(dialog --stdout --inputbox 'Insira o GATEWAY do hostname desta rede: ' 0 0)


hostnamectl set-hostname $VARHOSTNAME.o2pos.com.br
# Altera somente o IP Address de DHCP para FIXO com o ip designado anterimente.
VARINTERFACE=$(nmcli con show | tail -1 | awk '{print $1}')
nmcli con modify $VARINTERFACE ipv4.method manual ipv4.addresses $VARIPADDRESS/24 ipv4.gateway $VARGATEWAY ipv4.dns 8.8.8.8,1.1.1.1 ipv4.dns-search auto
nmcli con up $VARINTERFACE

timedatectl set-timezone America/Sao_Paulo

# Setup Zabbix 5 LTS
rpm -Uvh https://repo.zabbix.com/zabbix/5.0/rhel/7/x86_64/zabbix-release-5.0-1.el7.noarch.rpm
dnf clean all
yum install zabbix-server-mysql zabbix-agent

# FRONT-END DA APLICACAO
yum-config-manager --enable rhel-server-rhscl-7-rpms
vim /etc/yum.repos.d/zabbix.repo
'''
Editar arquivo /etc/yum.repos.d/zabbix.repo e habilitar o repositório de frontend do zabbix.
[zabbix-frontend]
...
enabled=1
'''
yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm
yum-config-manager --enable remi-php74
yum install zabbix-web-mysql-scl zabbix-apache-conf-scl
yum install php php-common php-opcache php-mcrypt php-cli php-gd php-curl php-mysql -y

# Instalacao do Banco de Dados Mysql Community
rpm -i https://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm
yum install -y mysql-community-server
service mysqld start

PASS = grep 'temporary password' /var/log/mysqld.log
echo "A senha temporaria é: $PASS"
NewPass = P@sssword2020

mysql_secure_installation << EOF
$NewPass
$NewPass
EOF
mysql -uroot -p $NewPass -e "create database zabbix character set utf8 collate utf8_bin";
mysql -uroot -p $NewPass -e "create user zabbix@localhost identified by 'P@ssword2020';"
mysql -uroot -p $NewPass -e "create user grafana@localhost identified by 'P@ssword2020';"
mysql -uroot -p $NewPass -e "grant all privileges on zabbix.* to zabbix@localhost;"
mysql -uroot -p $NewPass -e "grant all privileges on grafana.* to zabbix@localhost;"

zcat /usr/share/doc/zabbix-server-mysql*/create.sql.gz | mysql -uzabbix -p zabbix << EOF
$NewPass
EOF

/etc/php.fpm.d/zabbix.conf America/Sao_Paulo

systemctl restart zabbix-server zabbix-agent httpd php-fpm
systemctl enable zabbix-server zabbix-agent httpd php-fpm