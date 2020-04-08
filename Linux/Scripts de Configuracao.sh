# Script para configuração da Render Farm
# Criado por Raphael Maria
# Versão 1.0

# Instalando Interface Grafica
#apt-get grouplist
#sudo apt-get groups install "GNOME Desktop"
#systemctl set-default graphical.target
#systemctl start graphical.target
cd

# Codec Audio e Video
#Libavcodec
#apt-get install libvorbis  yasm freetype zlib bzip2 faac lame speex libvpx libogg  libtheora  x264 XviD openjpeg15 opencore-amr
#wget https://libav.org/releases/libav-12.3.tar.gz
#tar -xvf libav-12.3.tar.gz
#cd libav-12.3
#./configure --extra-cflags=-I/opt/local/include --extra-ldflags=-L/opt/local/lib --enable-gpl --enable-version3  --enable-libvpx
#make
#make install

sed -i 's/^Domain = localdomain/Domain = o2pos.com/' /etc/idmapd.conf

# Atualização de OS
apt-get -y check-update
apt-get -y update
apt-get -y install vim net-tools
cd

#abertura de portas Firewall
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -F
iptables -X
cd

# Instalando VNC SERVER 
apt-get -y install tigervnc-server xorg-x11-fonts-Type1
cp /lib/systemd/system/vncserver@.service /etc/systemd/system/vncserver@:3.service
echo "Insira a senha para acesso"
vncserver

rm -rf /etc/hostname.bkp
rm -rf /etc/hostname.old
mv /etc/hostname /etc/hostname.bkp
echo "maquina115" >> /etc/hostname
echo "maquina115" > /proc/sys/kernel/hostname 

#Instalação Zabbix
#rpm -ivh http://repo.zabbix.com/zabbix/2.4/rhel/6/x86_64/zabbix-release-2.4-1.el6.noarch.rpm
#apt-get -y install zabbix-agent.x86_64
#service zabbix-agent stop
#sed -i 's/^SERVER=*/SERVER=192.168.8.4/' /etc/zabbix/zabbix_agentd.conf


#sed -i 's/^Hostname=maquinaxx/Hostname=Maquina115/' /etc/zabbix/zabbix_agentd.conf
#chkconfig zabbix on
#chkconfig zabbix-agent on
#mkdir /var/run/zabbix
#chown zabbix.zabbix /var/run/zabbix/
#zabbix_agentd -c /etc/zabbix/zabbix_agentd.conf
#service zabbix-agent start

# Criando diretorios
mkdir /mnt/Library2
chmod 777 /mnt/Library2
mkdir /mnt/RAWADV
chmod 777 /mnt/RAWADV
echo "192.168.8.48:/Storage/Library2 /mnt/Library2 nfs defaults 0 0" >> /etc/fstab
echo "192.168.8.86:/Storage/RAWADV /mnt/RAWADV nfs defaults 0 0" >> /etc/fstab
mount -a
df -h

#Placa de rede
rm -rf /etc/sysconfig/network-scripts/ifcfg-enp0s31f6
echo "HWADDR=1c:1b:0d:67:05:71" >> /etc/sysconfig/network-scripts/ifcfg-enp0s31f6
echo "TYPE=Ethernet" >> /etc/sysconfig/network-scripts/ifcfg-enp0s31f6
echo "BOOTPROTO=none" >> /etc/sysconfig/network-scripts/ifcfg-enp0s31f6
echo "DNS1=192.168.8.15" >> /etc/sysconfig/network-scripts/ifcfg-enp0s31f6
echo "DNS2=192.168.8.16" >> /etc/sysconfig/network-scripts/ifcfg-enp0s31f6
echo "DNS3=8.8.8.8" >> /etc/sysconfig/network-scripts/ifcfg-enp0s31f6
echo "DOMAIN=o2pos.com" >> /etc/sysconfig/network-scripts/ifcfg-enp0s31f6
echo "DEFROUTE=yes" >> /etc/sysconfig/network-scripts/ifcfg-enp0s31f6
echo "IPV4_FAILURE_FATAL=no" >> /etc/sysconfig/network-scripts/ifcfg-enp0s31f6
echo "IPV6INIT=no" >> /etc/sysconfig/network-scripts/ifcfg-enp0s31f6
echo "NAME=enp0s31f6" >> /etc/sysconfig/network-scripts/ifcfg-enp0s31f6
echo "UUID=056ca37d-e90e-46b9-9ea5-55fe95485c77" >> /etc/sysconfig/network-scripts/ifcfg-enp0s31f6
echo "ONBOOT=yes" >> /etc/sysconfig/network-scripts/ifcfg-enp0s31f6
echo "AUTOCONNECT_PRIORITY=-999" >> /etc/sysconfig/network-scripts/ifcfg-enp0s31f6
echo "IPADDR=192.168.9.215" >> /etc/sysconfig/network-scripts/ifcfg-enp0s31f6
echo "PREFIX=16" >> /etc/sysconfig/network-scripts/ifcfg-enp0s31f6
echo "GATEWAY=192.168.8.1" >> /etc/sysconfig/network-scripts/ifcfg-enp0s31f6

reboot

/opt/hfs17.0/bin/hkey




# Instanado o Royal Render
echo "Configuração terminada com sucesso"