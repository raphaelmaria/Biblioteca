#!/bin/bash

yum -y update
yum -y upgrade
yum -y install gcc unzip wget nss dkms git dnf snapd vim ansible libselinux-python
yum -y install nfs-utils tcsh libXext libSM libXrender Xvfb xorg-x11-server-Xorg xorg-x11-xauth xorg-x11-apps
yum -y groupinstall "Development Tools"
yum -y groupinstall "Legacy UNIX Compatibility"
yum -y groupinstall "X Window System"
yum -y groupinstall "Fonts"
export FONTCONFIG_PATH=/etc/fonts

wget https://dev.mysql.com/get/Downloads/MySQL-8.0/mysql-8.0.19-1.el7.x86_64.rpm-bundle.tar
tar xvf mysql-8.0.19-1.el7.x86_64.rpm-bundle.tar
cd mysql-8.0.19-1.el7.x86_64.rpm-bundle