#!/bin/bash
# Instalação do Houdini License 17.5
# Criado por Raphael Maria - Data de 23/04/2019
# versão 01
scp o2@192.168.8.84:/Volumes/3TB/Downloads/Linux/H17.5/houdini-17.5.173-linux_x86_64_gcc6.3.tar.gz /root
cd /root/Downloads
tar -xvf houdini-17.5.173-linux_x86_64_gcc6.3.tar.gz
bash /houdini-17.5.173-linux_x86_64_gcc6.3/houdini.install -y
/etc/init.d/sesinetd stop
scp o2@192.168.8.84:/Volumes/3TB/Downloads/Linux/H17/H17_sesinet/Linux/sesinetd /root
rm -rf /usr/lib/sesi/sesinetd
mv /root/sesinetd /usr/lib/sesi
chmod -R 755 /usr/lib/sesi/sesinetd
reboot