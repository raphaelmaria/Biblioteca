#!/bin/sh
# Instalado de ZFS em CentOS 7.7
# Creado por Raphael Maria em 07/11/2019
# Versão 1.2
# For Red Hat / CentOS 7
# 
# Biografia de pesquisa para confeccao destas linhas:
# https://github.com/zfsonlinux/zfs/wiki/Custom-Packages#get-the-source-code
# 
yum -y install wget nss dkms git dnf snapd vim ansible libselinux-python nfs-utils tcsh libXext libSM libXrender Xvfb xorg-x11-server-Xorg xorg-x11-xauth xorg-x11-apps
yum -y install http://download.zfsonlinux.org/epel/zfs-release.el7_7.noarch.rpm
dnf -y install autoconf automake libtool rpm-build
dnf -y install zlib-devel libuuid-devel libattr-devel libblkid-devel libselinux-devel libudev-devel
dnf -y install libacl-devel libaio-devel device-mapper-devel openssl-devel libtirpc-devel elfutils-libelf-devel
dnf -y install kernel-devel-$(uname -r)
yum -y install epel-release
yum -y install python36 python36-devel python36-setuptools python36-cffi
yum -y install epel-release
yum -y install zfs

# Habilitar o ZFS Pool no Kernel da Maquina
modprobe zfs
lsmod | grep zfs
/sbin/modprobe zfs

# Comando para criar o Pool de Disco em Raid 5
zpool create -f storage raidz /dev/sd[a-w]1
zpool create storage/dados

echo "@reboot         root    sleep 10; zpool import -a;" >> /etc/crontab

#Instalar ZFS AUTO Snapshot
# Guia e Repositorio para Download
# https://github.com/zfsonlinux/zfs-auto-snapshot
wget https://github.com/zfsonlinux/zfs-auto-snapshot/archive/upstream/1.2.4.tar.gz
tar -xzf 1.2.4.tar.gz
cd zfs-auto-snapshot-upstream-1.2.4
make install