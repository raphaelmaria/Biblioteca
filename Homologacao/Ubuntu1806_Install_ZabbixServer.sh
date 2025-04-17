Ubuntu 20.04

wget https://repo.zabbix.com/zabbix/5.2/ubuntu/pool/main/z/zabbix-release/zabbix-release_5.2-1+ubuntu20.04_all.deb
dpkg -i zabbix-release_5.2-1+ubuntu20.04_all.deb
apt update

apt install zabbix-server-mysql -y
apt install zabbix-frontend-php -y
apt install zabbix-nginx-conf -y
apt install zabbix-agent

#Criando Database - Zabbix Server
mysql -uroot -p${MYSQLPASS} -e "create database zabbix character set utf8 collate utf8_bin;"
mysql -uroot -p${MYSQLPASS} -e "create user 'auth'@'192.168.15.180' identified by 'P@ssword2020!;'"
mysql -uroot -p${MYSQLPASS} -e "grant all privileges on inventory to 'inventory'@'localhost';"
mysql -uroot -p${MYSQLPASS} -e "create user 'root'@'192.168.15.180' identified with mysql_native_password by 'P@ssword2020!';"
mysql -uroot -p${MYSQLPASS} -e "grant all privileges on zabbix.* to 'root'@'192.168.15.180';"
mysql -uroot -p${MYSQLPASS} -e "UPDATE mysql.user SET Super_Priv='Y' WHERE user='inventory' AND host='192.168.15.180';"
