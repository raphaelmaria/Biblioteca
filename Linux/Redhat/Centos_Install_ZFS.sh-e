#!/bin/sh
'''
INSTALACAO DE ZFS
OS: CENTOS 7 E 8
CRIADO EM 22 DE FEVEREIRO DE 2020 POR RAPHAEL MARIA
'''

ECHO "INSTALACAO DOS PACOTES BASICOS"
yum -y install epel-release
yum -y install wget nss dkms git dnf snapd vim ansible libselinux-python nfs-utils tcsh libXext libSM libXrender Xvfb xorg-x11-server-Xorg xorg-x11-xauth xorg-x11-apps
dnf -y install autoconf automake libtool rpm-build
dnf -y install libacl-devel libaio-devel device-mapper-devel openssl-devel libtirpc-devel elfutils-libelf-devel
dnf -y install kernel-devel-$(uname -r)
yum -y install epel-release


ECHO "INSTALACAO DO ZFS"
yum -y install http://download.zfsonlinux.org/epel/zfs-release.el7_7.noarch.rpm
dnf -y install zlib-devel libuuid-devel libattr-devel libblkid-devel libselinux-devel libudev-devel
yum update -y
yum -y install zfs
modprobe zfs
lsmod | grep zfs
/sbin/modprobe zfs

echo 'Please enter your choice: '
options=("RAID0" "RAID1" "RAID5" "RAID6")
select raid in "${RAID[@]}"
do
    case $raid in
        "RAID0")
            echo "Iniciando configuração em RAID 0"
            ;;
        "RAID1")
            echo "Iniciando configuração em RAID 1"
            ;;
        "RAID5")
            echo "Iniciando configuração em RAID 5"
            ;;
        "RAID6")
            echo "Iniciando configuração em RAID 6"
            ;;
#       "Option 3")
#            echo "you chose choice $REPLY which is $opt"
#            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done


echo "Nome do Compartilhamento: "
read SHARE

ls /dev | grep "sd"

echo "Qual o disco inicial: "
read DISC1

echo "Qual o disco final: "
read DISC2

zpool create -f $SHARE $raid /dev/sd[$DISC1-$DISC2]1
zpool create /mnt/storage
mkdir -p /mnt/storage/$SHARE
chmod -R 777 /mnt/storage/$SHARE

