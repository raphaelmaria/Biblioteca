
timedatectl set-timezone America/Sao_Paulo

# Instalação de softwares básicos.
yum -y install dialog wget tar unzip vim gcc dnf epel-release ipa-client &
yum -y install net-tools tcpdump nano curl &

##### VARIAVEIS
VARHOSTNAME=$(dialog --stdout --inputbox 'Insira o nome  do hostname desta maquina: ' 0 0)
VARIPADDRESS=$(dialog --stdout --inputbox 'Insira o IP ADDRESS do hostname desta maquina: ' 0 0)
VARGATEWAY=$(dialog --stdout --inputbox 'Insira o GATEWAY do hostname desta rede: ' 0 0)

hostnamectl set-hostname $VARHOSTNAME
# Altera somente o IP Address de DHCP para FIXO com o ip designado anterimente.
VARINTERFACE=$(nmcli con show | tail -1 | awk '{print $1}')
nmcli con modify $VARINTERFACE ipv4.method manual ipv4.addresses $VARIPADDRESS/16 ipv4.gateway $VARGATEWAY ipv4.dns 8.8.8.8,8.8.4.4.,1.1.1.1 ipv4.dns-search [Dominio interno]
nmcli con up $VARINTERFACE

# Instalação do Ansible
yum -y install ansible  epel-release &
yum provides pip &
yum install python2-pip -y &
pip install pip --upgrade &
pip install ansible &
pip install ansible --upgrade &

# Setup SELINUX
setenforce 0 &
getenforce &
sestatus &

# Setup MariaDB - EM TESTE
'''
dnf -y install mysql-server
systemctl enable --now mysqld
systemctl status mysqld
mysql_secure_instalation << EOF
y
1
8!H58HefmPGU
8!H58HefmPGU
y
y
y
y
y
EOF
dialog --msgbox 'MySQL foi configurado com sucesso' 0 0
'''
zcat /usr/share/doc/zabbix-server-mysql*/create.sql.gz | mysql -uzabbix -p zabbix
'''
#Acessar o Mysql
mysql -u root -p

Digitar a senha:
8!H58HefmPGU

Adaptar e rodar os comandos:
# Para Zabbix
create database zabbix character set utf8 collate utf8_bin;
create user 'zabbix'@'localhost' identified by 'Z@bbix1989';
grant all privileges on zabbix to 'zabbix'@'localhost';
create user 'zabbix'@'192.168.8.4' identified with mysql_native_password by 'Z@bbix1989';
grant all privileges on zabbix.* to 'zabbix'@'192.168.8.4';
UPDATE mysql.user SET Super_Priv='Y' WHERE user='zabbix' AND host='192.168.8.4';
# Para Grafana
create user 'USER'@'localhost' identified by 'P@ssword1234';
grant all privileges on zabbix.* to 'auth'@'localhost';
create user 'USER'@'[IP que vai acessar]' identified with mysql_native_password by 'P@ssword1234';
grant all privileges on zabbix.* to 'USER'@'[IP que vai acessar]';
UPDATE mysql.user SET Super_Priv='Y' WHERE user='USER' AND host='[IP que vai acessar]';
flush privileges;
'''


# Setup Firewalld
firewall-cmd --permanent --add-port=3306/tcp # MySQL Connect
firewall-cmd --permanent --add-port=10051/tcp # Zabbix Server
firewall-cmd --permanent --add-port=1005/tcp # Zabbix Agent
firewall-cmd reload


