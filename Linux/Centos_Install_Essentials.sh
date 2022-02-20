#!/bin/sh
# INSTALACAO BASICA PARA WORKSTATIONS LINUX
# VERSAO CENTOS 7.x.x
# CRIADO POR RAPHAEL MARIA.
# EM 18 DE FEVEREIRO DE 2020.
# VERSAO 1.0

# DADOS DO SERVIDOR
echo HOSTNAME?
read varhostname

echo IP ADDRESS?
read varip

##### PACOTE BASICO ######
yum update -y
yum upgrade -y
yum -y install epel-release

echo "INSTALADO PACOTE BASICO PARA O SISTEMA"
yum -y install \
    vim gcc unzip wget nss git dnf tcsh \
    gcc gcc-c++ make autoconf automake binutils bison \
    flex gcc gcc-c++ gettext \
    libtool make patch pkgconfig \
    redhat-rpm-config rpm-build rpm-sign \
    ctags elfutils indent patchutils

yum -y install \
    mesa-libGL mesa-libGL-devel kernel-devel \
    ntfs-3g.x86_64 nss dkms snapd \
    ansible libselinux-python vlc smplayer \
    ffmpeg HandBrake-{gui,cli} libdvdcss gstreamer{,1}-plugins-ugly \
    gstreamer-plugins-bad-nonfree gstreamer1-plugins-bad-freeworld \ 
    libde265 x265 exfat-utils fuse-exfat    


hostnamectl set-hostname $varhostname.o2pos.com.br

##### CONFIGURACAO NETWORK #####
nmcli con show

echo "Qual a placa de rede?"
read varinterface

nmcli con modify $varinterface ipv4.method manual ipv4.addresses $varip/16 ipv4.gateway 192.168.8.1 ipv4.dns 192.168.8.100,192.168.8.110 ipv4.dns-search o2pos.com.br
nmcli con up $varinterface

echo "###############################"
echo "#### INSTALACAO FINALIZADA ####"
echo "###############################"
reboot
