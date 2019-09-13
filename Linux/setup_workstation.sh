# Script para configuração da Workstations
# Criado por Raphael Maria
# Versão 1.0


# Atualização de OS
#yum install epel-release -y
#rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
#rpm -Uvh https://www.elrepo.org/elrepo-release-7.0-3.el7.elrepo.noarch.rpm
#yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
#yum check-update
#yum update -y

# Audio Codecs
yum install http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm -y
yum -y install gcc unzip wget mesa-libGL mesa-libGL-devel ntfs-3g.x86_64 nss dkms git dnf snapd vim ansible libselinux-python vlc smplayer ffmpeg HandBrake-{gui,cli} libdvdcss gstreamer{,1}-plugins-ugly gstreamer-plugins-bad-nonfree gstreamer1-plugins-bad-freeworld libde265 x265


rpm -aq | grep teamviewer
rpm -e teamviewer-*
rm -rf /etc/teamviewer
## rpm --import http://download.teamviewer.com/download/TeamViewer_Linux_PubKey.asc
yum install http://192.168.8.7/app/teamviewer_12.0.137452.i686.rpm -y
#yum install http://download.teamviewer.com/download/teamviewer.i686.rpm -y
systemctl enable teamviewerd.service
systemctl start teamviewerd.service

#remover Kernels Antigos
package-cleanup --oldkernels --count=2

#Install 10 Gigabit Versão Uira
scp -r root@192.168.8.7:/Storage/Install/Linux/Drivers/Rede/Startech/Tehuti_TN4010_Linux-ESXI_PCIe_10_Gigabit_Network_Card .
cd Tehuti_TN4010_Linux-ESXI_PCIe_10_Gigabit_Network_Card/Linux
make install

# Install 10 Gigabit Versão Rafael Fuzarri
wget http://install.o2pos.com/app/tn40xx-0.3.6.17.zip
unzip tn40xx-0.3.6.17.zip
cd tn40xx-0.3.6.17.2
make && sudo make install


#wget http://download1.rpmfusion.org/free/el/updates/testing/7/x86_64/
#rpm -Uvh rpmfusion-free-release*rpm
#yum install x264-libs

mdadm --create /dev/md0 --level=raid0 --raid-devices 2 /dev/sdb1 /dev/sdc1 
mkfs.ext4 --force /dev/md0

# Driver Video com RUN DA NVIDIA
init 2
yum remove xorg-x11-drivers xorg-x11-drv-nouveau -y
yum remove kmod-nvidia
rpm -e kmod-nvidia
wget http://192.168.8.7/app/NVIDIA-Linux-390.87.zip
OU
wget http://192.168.8.7/app/NVIDIA-Linux-430.14.zip

unzip NVIDIA-Linux-*.*zip
chmod 777 NVIDIA-*
./NVIDIA-Linux-*.*.run -a
init 6

# Driver de video com YUM Repositorys 
init 2
yum -y install xorg-x11-drivers xorg-x11-drv-nouveau
yum -y install kmod-nvidia


# Interface Install
yum grouplist
yum groupremove "GNOME Desktop" -y
systemctl set-default graphical.target
systemctl start graphical.target



#Install Neat Video Plugin
scp root@192.168.8.7:/Storage/Install/Linux/Softwares/Neatvideo/NeatVideo4OFX.Pro.Intel64.run .
bash NeatVideo4OFX.Pro.Intel64.run

scp -r root@192.168.8.11:/Storage/Homes/skeleton /tmp
mv /tmp/skeleton/* /etc/skel
chmod -R 777 /etc/skel/*

#######################
## Set Name Hostname ##
#######################
hostnamectl set-hostname vmrender2
sed -i 's/^Domain = localdomain/Domain = o2pos.com/' /etc/idmapd.conf

#############################################
#####      Configurando Diretorios      #####
#############################################
cp -b /etc/fstab /root/backups/fstab.bkps
ln -s /mnt /Volumes
ln -s /mnt/cache /mnt/Cache_Nuke
ln -s /mnt/cache /mnt/cache_nuke
umount -a
mkdir /mnt/RRender
chmod 777 /mnt/RRender
mkdir /mnt/Library
chmod 777 /mnt/Library
mkdir /mnt/Library2
chmod 777 /mnt/Library2
mkdir /mnt/RAW1
chmod 777 /mnt/RAW1
mkdir /mnt/RAW2
chmod 777 /mnt/RAW2
mkdir /mnt/RAW3
chmod 777 /mnt/RAW3
mkdir /mnt/RAWADV
chmod 777 /mnt/RAWADV
mkdir /mnt/Publicidade
chmod 777 /mnt/Publicidade
mkdir /mnt/Entretenimento
chmod 777 /mnt/Entretenimento
mkdir /mnt/Entretenimento2
chmod 777 /mnt/Entretenimento2
mkdir /mnt/Entretenimento3
chmod 777 /mnt/Entretenimento3
mkdir /mnt/Entretenimento4
chmod 777 /mnt/Entretenimento4
mkdir /mnt/Onix
chmod 777 /mnt/Onix
mkdir /mnt/Install
chmod 777 /mnt/Install
mkdir /mnt/opt2
chmod 777 /mnt/opt2
mkdir /mnt/oldhomes
chmod 777 /mnt/oldhomes
mkdir /mnt/cache
chmod -R 777 /mnt/cache
mkdir /mnt/raid
chmod -R 777 /mnt/raid
chmod -R 777 /mnt/cache_nuke
chmod -R 777 /mnt/Cache_Nuke

umount -a
echo '# Servidor Royal Render
192.168.8.200:/mnt/RRender /mnt/RRender nfs defaults 0 0

##############################
# Servidores Storages de Arquivos
##############################

192.168.8.2:/Storage/Library            /mnt/Library            nfs     defaults        0 0
#192.168.8.48:/Storage/Library2          /mnt/Library2           nfs     defaults        0 0
192.168.8.19:/Storage/RAW1              /mnt/RAW1               nfs     defaults        0 0
192.168.8.32:/Storage/RAW2              /mnt/RAW2               nfs     defaults        0 0
192.168.8.38:/Storage/RAW3              /mnt/RAW3               nfs     defaults        0 0
192.168.8.86:/Storage/RAWADV            /mnt/RAWADV             nfs     defaults        0 0
#192.168.8.14:/Storage/Publicidade       /mnt/Publicidade        nfs     defaults        0 0
192.168.8.31:/Storage/Entretenimento    /mnt/Entretenimento     nfs     defaults        0 0
192.168.8.22:/Storage/Entretenimento2   /mnt/Entretenimento2    nfs     defaults        0 0
192.168.8.25:/Storage/Entretenimento3   /mnt/Entretenimento3    nfs     defaults        0 0
192.168.8.39:/Storage/Entretenimento4   /mnt/Entretenimento4    nfs     defaults        0 0

#########################
# Servidores auxiliares
#########################

#192.168.8.33:/opt                      /opt                    nfs     defaults        0 0
192.168.8.2:/Storage/Onix               /mnt/Onix               nfs     defaults        0 0
#192.168.8.7:/Storage/Install            /mnt/Install            nfs     defaults        0 0
#192.168.8.11:/Storage/Homes            /home                 nfs     defaults        0 0

################
# Discos locais
################

#Padrao para disco de cache do Nuke
#/dev/sdb1                   /mnt/cache                  		ext4     defaults        0 0 

#Padrao para quando estive um 1 disco mecanico instalado
#/dev/sdc1                   /mnt/slave                         ext4     defaults        0 0' >> /etc/fstab


mount -a
df -h
ll -la /mnt
#####################
#### PROGRAMAS ######
#####################
rm -rf /usr/local/foundry/RLM
#rm -rf /etc/launchd.conf 
#echo "setenv NUKE_PATH /Volumes/Onix/.Nuke" >> /etc/launchd.conf 
#/opt/o2app/1_Exec_como_root_o2_app_handler.sh
rm -rf /opt/scripts/WacomPressureBug.sh
wget https://play.o2filmes.com/pauta/app/lnx/pauta_bridge_install.sh
chmod +X pauta_bridge_install.sh
chmod 777 pauta_bridge_install.sh
bash pauta_bridge_install.sh
rm -rf pauta_bridge_install.sh
/opt/hfs17.5/bin/hkey

#Acertos
echo "O servidor é 192.168.8.63"

# Instalando VNC SERVER 
yum install tigervnc-server xorg-x11-fonts-Type1 -y
cp /lib/systemd/system/vncserver@.service  /etc/systemd/system/vncserver@:1.service
vi /etc/systemd/system/vncserver@\:1.service
systemctl daemon-reload
systemctl start vncserver@:1
systemctl status vncserver@:1
systemctl enable vncserver@:1
echo "Insira a senha para acesso"
vncserver


/etc/init.d/rrAutostart restart

#Placa de rede
#ip a  (pegar o Mac, Nome da Interface)
#rodar o comando uuidgen (nome da placa de rede)
#Copiar esses dados e alterar no escript abaixo 
#Configuração antiga
mkdir /root/backups
mv /etc/sysconfig/network-scripts/ifcfg-ens3 /root/backups/ifcfg-ens3_bkp
echo "
# Configuracao gerada por script
HWADDR="56:6f:d4:39:00:04"
NAME="ens3"
UUID="af3873f7-8a5e-4e08-8e53-b999720acb21"
TYPE="Ethernet"
BOOTPROTO="none"
DNS1="192.168.8.15"
DNS2="192.168.8.16"
DNS3="8.8.8.8"
DOMAIN="o2pos.com"
DEFROUTE="yes"
IPV4_FAILURE_FATAL="no"
IPV6INIT="no"
ONBOOT="yes"
AUTOCONNECT_PRIORITY="-999"
IPADDR="192.168.9.51"
PREFIX="16"
GATEWAY="192.168.8.1" ">> /etc/sysconfig/network-scripts/ifcfg-ens3
ls /etc/sysconfig/network-scripts | grep "ifcfg-ens3"
systemctl stop NetworkManager
systemctl disable NetworkManager
systemctl enable network
systemctl restart network

# Configuração de IP com Network Manager
nmcli con show
# Linha para comando de IP FIXO
nmcli connection modify enp7s0 ipv4.method manual ipv4.addresses 192.168.9.25/16 ipv4.gateway 192.168.8.1 ipv4.dns 192.168.8.15,192.168.8.16 ipv4.dns-search o2pos.com
# Linha para comando para o DNS FIXO APENAS
nmcli connection modify "Interface" ipv4.ignore-auto-dns yes ipv4.dns 192.168.8.100,192.168.8.110 ipv4.dns-search o2pos.com.br
nmcli connection up enp7s0

sudo hostnamectl set-hostname camstorage




mv /etc/resolv.conf /etc/resolv.conf.old
echo "name server = 192.168.8.100
name server = 192.168.8.110" >> /etc/resolv.conf

 
yum install ipa-client
ipa-client-install --mkhomedir --no-ntpd

nmcli con mod "Wired connection 1" ipv4.ignore-auto-dns yes ipv4.dns 192.168.8.100,192.168.8.110 ipv4.dns-search o2pos.com.br
/opt/hfs17.5/bin/hkey

reboot



rpm -ivh [pacote]


# Instanado o Royal Render
echo "Configuração terminada com sucesso"




sudo echo "setenv NUKE_PATH /Volumes/Onix/.Nuke" >> /etc/launchd.conf 
sudo echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">
  <plist version=\"1.0\">
  <dict>
  <key>Label</key>
  <string>setenv.NUKE_PATH</string>
  <key>ProgramArguments</key>
  <array>
    <string>/bin/launchctl</string>
    <string>setenv</string>
    <string>NUKE_PATH</string>
    <string>/Volumes/Onix/.Nuke</string>
  </array>
  <key>RunAtLoad</key>
  <true/>
  <key>ServiceIPC</key>
  <false/>
</dict>
</plist>" >> /Library/LaunchAgents/setenv.Nuke.plist

sudo chown root  /Library/LaunchAgents/setenv.Nuke.plist



na pasta /cron.hourly
gcds

# Install Cinnamon Desktop View
yum -y install epel-release
yum -y groupinstall "X Window system"
yum -y install lightdm
yum -y install cinnamon


# Download Nuke
LINUX
http://thefoundry.s3.amazonaws.com/products/nuke/releases/10.5v5/Nuke10.5v5-linux-x86-release-64.tgz
MAC
http://thefoundry.s3.amazonaws.com/products/nuke/releases/10.0v3/Nuke10.0v3-mac-x86-release-64.dmg


http://thefoundry.s3.amazonaws.com/products/hieroplayer/releases/1.9v1/HieroPlayer1.9v1-mac-x86-release-64.dmg

http://thefoundry.s3.amazonaws.com/products/hieroplayer/releases/11.0v1/HieroPlayer11.0v1-mac-x86-release-64.dmg

# Variable Nuke Path Linux
Criar o arquivo em:

echo "export NUKE_PATH=/mnt/Onix/.Nuke" >> /etc/profile.d/onix.sh



http://thefoundry.s3.amazonaws.com/products/Hiero/releases/11.0v0/Hiero11.0v0-mac-x86-release-64.dmg



Hiero 11.0v2 User Guide - AWS
https://thefoundry.s3.amazonaws.com/products/nuke/.../11.../Hiero11.0v2_UserGuide.p...

https://thefoundry.s3.amazonaws.com/products/nuke/releases/11.0v2/Hiero11.0v2-mac-x86-release-64.dmg


