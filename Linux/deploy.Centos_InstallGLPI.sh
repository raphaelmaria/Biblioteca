


##### INSTALACAO DO MYSQL COMMUNITY #####
yum -y update
yum -y upgrade
yum -y install gcc unzip wget nss dkms git dnf snapd vim ansible libselinux-python
yum -y install nfs-utils tcsh libXext libSM libXrender Xvfb xorg-x11-server-Xorg xorg-x11-xauth xorg-x11-apps
yum -y groupinstall "Development Tools"
yum -y groupinstall "Legacy UNIX Compatibility"
yum -y groupinstall "X Window System"
yum -y groupinstall "Fonts"
export FONTCONFIG_PATH=/etc/fonts

wget https://dev.mysql.com/get/mysql80-community-release-el7-1.noarch.rpm
rpm -Uvh mysql80-community-release-el7-1.noarch.rpm
yum install mysql-server -y
systemctl start mysqld
systemctl enable mysqld
systemctl status mysqld

PASS = grep 'temporary password' /var/log/mysqld.log
echo "A senha temporaria é: $PASS"

firewall-cmd --get-default-zone
firewall-cmd --set-default-zone=public
firewall-cmd --permanent --add-port=3306/tcp
firewall-cmd --permanent --add-service=mysql

##### CONFIGURANDO O MYSQL DATABASE #####
mysql -u root -p
CREATE USER 'glpi'@'localhost' IDENTIFIED BY '2020glpiDBSecret!';
GRANT USAGE ON *.* TO 'glpi'@'localhost' IDENTIFIED BY '2020glpiDBSecret!';
CREATE DATABASE IF NOT EXISTS `glpi` ;
GRANT ALL PRIVILEGES ON `glpi`.* TO 'glpi'@'localhost';
FLUSH PRIVILEGES;
EXIT

mysql -uglpi -pglpiDBSecret glpi

Acesso do MySQL
User: root
Senha: P@55W0rd
