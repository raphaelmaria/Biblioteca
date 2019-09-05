#!/bin/python

hn = (input('Digite o Nome da Maquina:'))
ipaddress = (input('Digite o IP Address da máquina'))
networkcard = (input('Nome da Interface de rede'))

host= sp.run('hostnamectl set-hostname' %hn)

tnetworking1= sp.run('nmcli connection modify ', %networkcard, 'ipv4.method manual ipv4.addresses' %ipaddress'/16 ipv4.gateway 192.168.8.1 ipv4.dns 192.168.8.15,192.168.8.16 ipv4.dns-search o2pos.com')

tnetworking2= sp.run('nmcli connection up', %networkcard)

installer1= sp.run('yum -y install ntfs-3g.x86_64  nss dkms git dnf snapd vim ansible libselinux-python vlc smplayer ffmpeg HandBrake-{gui,cli} libdvdcss gstreamer{,1}-plugins-ugly gstreamer-plugins-bad-nonfree gstreamer1-plugins-bad-freeworld')
