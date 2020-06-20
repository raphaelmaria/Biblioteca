
timedatectl set-timezone America/Sao_Paulo


# Instalação de softwares básicos.
yum -y install dialog wget tar unzip vim make gcc dnf epel-release ipa-client
yum -y install net-tools tcpdump nano curl 

##### VARIAVEIS
VARHOSTNAME=$(dialog --stdout --inputbox 'Insira o nome  do hostname desta maquina: ' 0 0)
VARIPADDRESS=$(dialog --stdout --inputbox 'Insira o IP ADDRESS do hostname desta maquina: ' 0 0)
VARGATEWAY=$(dialog --stdout --inputbox 'Insira o GATEWAY do hostname desta rede: ' 0 0)

hostnamectl set-hostname $VARHOSTNAME
# Altera somente o IP Address de DHCP para FIXO com o ip designado anterimente.
VARINTERFACE=$(nmcli con show | tail -1 | awk '{print $1}')
nmcli con modify $VARINTERFACE ipv4.method manual ipv4.addresses $VARIPADDRESS/16 ipv4.gateway 192.168.8.1 ipv4.dns 192.168.8.100,192.168.8.110 ipv4.dns-search o2pos.com.br
nmcli con up $VARINTERFACE

# Instalação do Ansible
yum -y install ansible  epel-release
yum provides pip
yum install python2-pip -y
pip install pip --upgrade
pip install ansible
pip install ansible --upgrade

# Setup SELINUX
setenforce 0
getenforce
sestatus

# Setup MariaDB
dnf -y install mysql-server
systemctl enable --now mysqld
systemctl status mysqld
mysql_secure_instalation << EOF
yes
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

mysql> create database zabbix character set utf8 collate utf8_bin;
mysql> create user 'zabbix'@'localhost' identified by 'Z@bbix1989';
mysql> grant all privileges on zabbix.* to 'zabbix'@'localhost';


