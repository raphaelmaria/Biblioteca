#!/bin/bash

apt-get -y update
apt-get -y upgrade
apt-get -y install gcc unzip wget nss dkms git dnf snapd vim ansible libselinux-python
apt-get -y install nfs-utils tcsh libXext libSM libXrender Xvfb xorg-x11-server-Xorg xorg-x11-xauth xorg-x11-apps
apt-get -y groupinstall "Development Tools"
apt-get -y groupinstall "Legacy UNIX Compatibility"
apt-get -y groupinstall "X Window System"
apt-get -y groupinstall "Fonts"
export FONTCONFIG_PATH=/etc/fonts

wget https://dev.mysql.com/get/mysql80-community-release-el7-1.noarch.rpm
rpm -Uvh mysql80-community-release-el7-1.noarch.rpm
apt-get install mysql-server
systemctl start mysqld
systemctl status mysqld

PASS=grep 'temporary password' /var/log/mysqld.log
echo "A senha temporaria é: $PASS"




firewall-cmd --get-default-zone
firewall-cmd --set-default-zone=public
firewall-cmd --permanent --add-port=3306/tcp
firewall-cmd --permanent --add-service=mysql