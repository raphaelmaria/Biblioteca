#! /bin/bash
#
# Update O2 Comp-E
#
# By Uira Vilanova
# Colaboration jhone Medeiros and Rafael Maria
#
#
# Instalacao e atualizacao de sistemas e softwares para O2 Workstations
#
# v1.103d
#
##################################################################################
#
#
WHOAMI=` ( whoami ) `
echo "$WHOAMI"
if [ "$WHOAMI" == "root" ]
  then
  
############ Variaveis ##############
INSTALLDIR="/mnt/installers"
SOURCEDIR="/mnt/RRender/Installers"
LASTKERNEL="/usr/src/kernels/3.10.0-957.27.2.el7.x86_64"
NUKEDIR="/usr/local/Nuke10.5v5/"
NUKE11DIR="/usr/local/Nuke11.3v4/"
RESOLVEDIR="/opt/resolve/bin/resolve"
FUSIONDIR="/opt/BlackmagicDesign/Fusion9/"
FUSIONRENDER="/opt/BlackmagicDesign/FusionRenderNode9/"
FUSION16DIR="/opt/BlackmagicDesign/Fusion16/"
FUSION16RENDER="/opt/BlackmagicDesign/FusionRenderNode16/"
PFTRACKFILE="/usr/bin/pftrack2017"
MOCHADIR="/opt/isl/mochaproV5/bin/"
MOCHAVR="/opt/isl/mochaVRV5/bin/"
MOCHALIC="/etc/opt/bis/licences/client.lic"
BMDFILE="/usr/share/applications/BlackmagicDesktopVideoSetup.desktop"
LDAPFILE="/etc/nslcd.conf"
CHROMEDIR="/opt/google/chrome/"
NEATDIR="/usr/local/Neat Video v4 OFX/"
ONIX="/etc/profile.d/onix.sh"
OCIO="/etc/profile.d/ocio.sh"
BLENDERDIR="/opt/blender-2.80/"
HOUDINIDIR="/opt/hfs17.5.173"
MAYA19DIR="/usr/autodesk/maya2019"
MAYA17DIR="/usr/autodesk/maya2017"
VRAYMAYA17="/usr/ChaosGroup/V-Ray/Maya2017-x64"
VRAYMAYA19="/usr/ChaosGroup/V-Ray/Maya2019-x64"
NUKELIC="/usr/local/foundry/RLM/foundry_client.lic"
TVDIR="/opt/teamviewer/"
WACOMPRESSURE="/etc/X11/xorg.conf.d/99-wacom-pressure2k.conf"
WACOMBUTTONS="/etc/init.d/Wacom_disable_touch_and_ring.sh"
MOUNTS="192.168.8.2:/Storage/Onix               /mnt/Onix               nfs     defaults        0 0"
MOUNTS2=` ( grep -F "Onix" /etc/fstab ) `
NVINSTALLEDDIR="/usr/src/nvidia-410.93/"
NTFS3G="/usr/lib64/libntfs-3g.so.88.0.0"
HOSTNAME1=` ( grep -F "" /etc/hostname ) `
HOSTNAME2="vxfhost"
#HOSTNAME2="maquina$NUMNAME"
USERADMIN="1"
USERADMIN2=` ( grep -c '^admin:' /etc/passwd ) `
NETPATH="/etc/sysconfig/network-scripts"
NETENID=` ( ip link | awk -F: '$0 !~ "lo|vir|wl|^[^0-9]"{print $2;getline}' ) `
NETENID2="ifcfg-$NETENID"
NETENID3="${NETENID2// /}"
NETENID4="${NETENID// /}"
NETUUID=` ( grep -F "UUID" $NETPATH/$NETENID3 ) `
NETBOOTPROTO=` ( grep -F "BOOTPROTO" $NETPATH/$NETENID3 ) `
NETPROTOCHK="BOOTPROTO=dhcp"
DATE=` ( date '+%Y''%m''%d' ) `
BKPFILES="/mnt/backup_files"
LASTIPNUM=` ( ip -o addr show dev "$NETENID4" | awk '$3 == "inet" {print $4}' |  sed -r 's!/.*!!; s!.*\.!!' ) `
NUMNAME=` ( expr $LASTIPNUM - 100 ) `
UPSERVICE="/etc/systemd/system/update.service"
VLC="/usr/bin/svlc"
PAUTA="/usr/local/o2pauta"
SLACKDIR="/usr/bin/slack"
KRITA="/usr/bin/krita"
GNOMEBKP="/etc/gdm/custom.bkp"
GNOMECONF=` ( cat /etc/gdm/custom.conf ) `
SUDORES="/etc/sudores.bkp"
AUTOSTARTFI="/home/$USERNAME/.config/autostart/update.desktop"
AUTOSTARTFO="/home/$USERNAME/.config/autostart/"
LIBGBDM="/usr/lib64/libgbm.so.1.0.0"
SNAPD="/var/lib/snapd/snap"
SPOTIFY="Spotify version 1.1.10.546.ge08ef575, Copyright (c) 2019, Spotify Ltd"
#
PAUDIOVRSINST=` ( pulseaudio --version ) `
PAUDIOVRSNEW="pulseaudio 10.0"
rm -rf /tmp/paudio.txt
echo $PAUDIOVRSINST >> /tmp/paudio.txt
PAUDIO=` (  grep -o '^[^[:space:]]\+' /tmp/paudio.txt ) `
#
USER1=` ( who -u ) `
rm -rf /tmp/loggeduser.txt
echo $USER1 >> /tmp/loggeduser.txt
USER2=` (  sed -i 's/root//g' /tmp/loggeduser.txt ) `
USER3=` (grep -o '^[^[:space:]]\+' /tmp/loggeduser.txt ) `
#USER3=` (  awk 'NF'   /tmp/loggeduser.txt ) `
USERNAME="$USER3"
###


##########  ADDUser Admin  ##########
#` usermod -a -G wheel flame2020_1 ` 
` usermod -a -G wheel $USERNAME `


#########  Adding User in sudores #####
if [ ! -e "$SUDORES" ]; then
 cp -f /etc/sudores /etc/sudores.bkp
#echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudores
echo "$USERNAME ALL=(ALL) ALL" >> /etc/sudores
fi

#### Change User ####
# -H -u $USERNAME bash -c "/home/o2/Desktop/update69.sh"



##########  Install Dir ##########

if [ ! -d "$INSTALLDIR" ]; then
 echo "Creating ${INSTALLDIR}..."
 mkdir $INSTALLDIR/
 chmod 777 $INSTALLDIR/  
fi


########## Enabling Auto Login KDE ##########
# cp -f /usr/share/config/kdm/kdmrc /usr/share/config/kdm/kdmrc.bkp
# sed -i 's/#AutoLoginEnable=true/AutoLoginEnable=true/g' /usr/share/config/kdm/kdmrc
# sed -i 's/#AutoLoginUser=fred/AutoLoginUser=o2/g' /usr/share/config/kdm/kdmrc
# sed -i 's/#AutoLoginUser=o2/AutoLoginUser=o2/g' /usr/share/config/kdm/kdmrc
# sed -i 's/#AutoLoginPass=secret!/AutoLoginPass=o2/g' /usr/share/config/kdm/kdmrc
# sed -i 's/#AutoLoginPass=o2/AutoLoginPass=o2/g' /usr/share/config/kdm/kdmrc


########## Enabling Auto Login GNOME ##########
if [ ! -e "$GNOMEBKP" ]; then
mv -f /etc/gdm/custom.conf /etc/gdm/custom.bkp
 echo "# GDM configuration storage" >> /etc/gdm/custom.conf
 echo "" >> /etc/gdm/custom.conf
 echo "[daemon]" >> /etc/gdm/custom.conf
 echo "" >> /etc/gdm/custom.conf
 echo "AutomaticLoginEnable=True" >> /etc/gdm/custom.conf
 echo "AutomaticLogin=o2" >> /etc/gdm/custom.conf
 echo "" >> /etc/gdm/custom.conf
 echo "[security]" >> /etc/gdm/custom.conf
 echo "" >> /etc/gdm/custom.conf
 echo "" >> /etc/gdm/custom.conf
 echo "[xdmcp]" >> /etc/gdm/custom.conf
 echo "" >> /etc/gdm/custom.conf
 echo "[debug]" >> /etc/gdm/custom.conf
 echo "# Uncomment the line below to turn on debugging" >> /etc/gdm/custom.conf
 echo "#Enable=true" >> /etc/gdm/custom.conf
# echo "$GNOMECONF"
fi


########## Enabling Service Script Autorun ##########
#if [ ! -e "$UPSERVICE" ]; then
# cp -f $SOURCEDIR/update.service $INSTALLDIR/update.service
# cp -f $INSTALLDIR/update.service $UPSERVICE
#fi


##########  hostname  ##########
if [ "$HOSTNAME1" == "$HOSTNAME2" ]
then
{
if [ ! -d "$BKPFILES" ]; then
 mkdir $BKPFILES
elsif
[ ! -d "$BKPFILES/$DATE" ]
 mkdir $BKPFILES/$DATE
else
 chmod 777 $BKPFILES/*
fi
}
mv -f /etc/hostname  $BKPFILES/$DATE/hostname
 echo "Digite o nome desejado para a maquina"
read HOSTNAME
 echo $HOSTNAME >> /etc/hostname
hostname $HOSTNAME
fi  

##########  IP Fixo - user interaction  ###########
if [ "$NETBOOTPROTO" == "$NETPROTOCHK" ]
then
echo ""
echo ""
echo "#####Configurando rede#######"
echo ""
echo "Interfaces disponiveis:"
echo "$NETENID"
echo ""
echo "Digite o nome da interface desejada"
read ENID
echo ""
echo "Digite o IP da maquina"
read IPADDED
NETUUIDUI=` ( grep -F "UUID" $NETPATH/ifcfg-$ENID ) `
{
if [ ! -d "$BKPFILES" ]; then
mkdir $BKPFILES
elsif
[ ! -d "$BKPFILES/$DATE" ]
mkdir $BKPFILES/$DATE
else
chmod 777 $BKPFILES/*
fi
}
mv /etc/sysconfig/network-scripts/ifcfg-$ENID $BKPFILES/$DATE/$ENID
echo "
# By Uira Vilanova
NAME="$ENID"
DEVICE="$ENID"
$NETUUIDUI
TYPE="Ethernet"
BOOTPROTO="none"
DEFROUTE="yes"
IPV4_FAILURE_FATAL="no"
IPV6INIT="no"
IPADDR="$IPADDED"
GATEWAY="192.168.8.1"
PREFIX="16"
DNS1="192.168.8.15"
DNS2="192.168.8.16"
DNS3="8.8.8.8"
DOMAIN="o2pos.com"
ONBOOT="yes" ">> $NETPATH/ifcfg-$ENID
systemctl restart network
sleep 12
#reboot
fi

##########  IP Fixo - auto get name eth id ############
#if [ "$NETBOOTPROTO" == "$NETPROTOCHK" ]
#then
# echo "Digite o IP da m[aquina"
#read IPADDED
#{
#if [ ! -d "$BKPFILES" ]; then
# mkdir $BKPFILES
#elsif
#[ ! -d "$BKPFILES/$DATE" ]
# mkdir $BKPFILES/$DATE
#else
# chmod 777 $BKPFILES/*
#fi
#}
#mv /etc/sysconfig/network-scripts/$NETENID3 $BKPFILES/$DATE/$NETENID3
# echo "
## By Uirado
#NAME="$NETENID4"
#DEVICE="$NETENID4"
#$NETUUID
#TYPE="Ethernet"
#BOOTPROTO="none"
#DEFROUTE="yes"
#IPV4_FAILURE_FATAL="no"
#IPV6INIT="no"
#IPADDR="$IPADDED"
#GATEWAY="192.168.8.1"
#PREFIX="16"
#DNS1="192.168.8.15"
#DNS2="192.168.8.16"
#DNS3="8.8.8.8"
#DOMAIN="o2pos.com"
#ONBOOT="yes" ">> $NETPATH/$NETENID3
# systemctl restart network
#sleep 5
# reboot
#fi

###########  ADDUser Admin  ##########
#if [ "$USERADMIN2" != "$USERADMIN" ]
#then
# echo "Digite a senha para o usu[ario admin"
#read ADMINPASS
#adduser admin
# echo "$ADMINPASS" | passwd --stdin admin
#usermod -a -G wheel admin
#fi


##########  FSTAB  ##########

if [ "$MOUNTS" != "$MOUNTS2" ]
then
{
if [ ! -d "/opt2" ]; then
 mkdir /opt2
fi
}
{
if [ ! -d "/Volumes" ]; then
 mkdir /Volumes
fi
}
{
if [ ! -d "/mnt/Onix" ]; then
 mkdir /mnt/Onix
fi
}
{
if [ ! -d "/mnt/Library" ]; then
 mkdir /mnt/Library
fi
}
{
if [ ! -d "/mnt/Publicidade" ]; then
 mkdir /mnt/Publicidade
fi
}
{
if [ ! -d "/mnt/Entretenimento" ]; then
 mkdir /mnt/Entretenimento
fi
}
{
if [ ! -d "/mnt/Entretenimento2" ]; then
 mkdir /mnt/Entretenimento2
fi
}
{
if [ ! -d "/mnt/Entretenimento3" ]; then
 mkdir /mnt/Entretenimento3
fi
}
{
if [ ! -d "/mnt/Entretenimento4" ]; then
 mkdir /mnt/Entretenimento4
fi
}
{
if [ ! -d "/mnt/RRender" ]; then
 mkdir /mnt/RRender 
fi
}
{
if [ ! -d "/mnt/RAW1" ]; then
 mkdir /mnt/RAW1 
fi
}
{
if [ ! -d "/mnt/RAW2" ]; then
 mkdir /mnt/RAW2 
fi
}
{
if [ ! -d "/mnt/RAW3" ]; then
 mkdir /mnt/RAW3 
fi
}
{
if [ ! -d "/mnt/RAWADV" ]; then
 mkdir /mnt/RAWADV 
fi
}
{
if [ ! -d "/mnt/Library2" ]; then
 mkdir /mnt/Library2/
fi
}
{
if [ ! -d "/mnt/install" ]; then
 mkdir /mnt/install 
fi
}
chmod 777 /mnt/*
chmod 777 /opt2
chmod 777 /Volumes
echo "192.168.8.33:/opt                       /opt2                   nfs     defaults        0 0" >> /etc/fstab
echo "192.168.8.2:/Storage/Onix               /mnt/Onix               nfs     defaults        0 0" >> /etc/fstab
echo "192.168.8.2:/Storage/Library            /mnt/Library            nfs     defaults        0 0" >> /etc/fstab
echo "192.168.8.14:/Storage/Publicidade       /mnt/Publicidade        nfs     defaults        0 0" >> /etc/fstab
echo "192.168.8.31:/Storage/Entretenimento    /mnt/Entretenimento     nfs     defaults        0 0" >> /etc/fstab
echo "192.168.8.22:/Storage/Entretenimento2   /mnt/Entretenimento2    nfs     defaults        0 0" >> /etc/fstab
echo "192.168.8.25:/Storage/Entretenimento3   /mnt/Entretenimento3    nfs     defaults        0 0" >> /etc/fstab
echo "192.168.8.39:/Storage/Entretenimento4   /mnt/Entretenimento4    nfs     defaults        0 0" >> /etc/fstab
echo "192.168.8.200:/mnt/RRender              /mnt/RRender            nfs     defaults        0 0" >> /etc/fstab
echo "192.168.8.19:/Storage/RAW1              /mnt/RAW1               nfs     defaults        0 0" >> /etc/fstab
echo "192.168.8.32:/Storage/RAW2              /mnt/RAW2               nfs     defaults        0 0" >> /etc/fstab
echo "192.168.8.38:/Storage/RAW3              /mnt/RAW3               nfs     defaults        0 0" >> /etc/fstab
echo "192.168.8.86:/Storage/RAWADV            /mnt/RAWADV             nfs     defaults        0 0" >> /etc/fstab
echo "192.168.8.48:/Storage/Library2          /mnt/Library2           nfs     defaults        0 0" >> /etc/fstab
echo "#192.168.8.7:/Storage/install            /mnt/install            nfs     defaults        0 0" >> /etc/fstab
echo "/mnt                                    /Volumes                none	bind" >> /etc/fstab
mount -a
fi

######  Adding to AutoStart #########
#if [ ! -e "$AUTOSTARTFI" ]; then
# echo "#######  Adding to AutoStart  #########" ##### 
# mkdir "/home/$USERNAME/.config/autostart/"
# cp -f $SOURCEDIR/update.desktop $INSTALLDIR/update.desktop
# cp -f $INSTALLDIR/update.desktop $AUTOSTARTFO/update.desktop
# chmod -R 777 "/home/$USERNAME/.config/autostart/update.desktop"
#fi


#######  Epel Release / Last Kernel #########
if [ ! -d "$LASTKERNEL" ]; then
echo "#######  Instalando Epel  #########" ##### 
cd $INSTALLDIR
yum -y install wget
yum -y install epel-release
wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
rpm -i epel-release-latest-7.noarch.rpm
yum -y update
yum install -y dolphin
yum install -y htop
yum install -y lshw
reboot
fi


###################SnapD###################
if [ ! -d "$SNAPD" ]; then
yum -y install snapd
systemctl enable --now snapd.socket
ln -s /var/lib/snapd/snap /snap
fi


##############  NVidia   ###################
if [ ! -d "$NVINSTALLEDDIR" ]; then
grubby --update-kernel=ALL   --args="rd.driver.blacklist=nouveau nouveau.modeset=0"
cp -f $SOURCEDIR/NVIDIA-Linux-x86_64-410.93-custom.run $INSTALLDIR/NVIDIA-Linux-x86_64-410.93-custom.run
cd $INSTALLDIR
chmod 777 NVIDIA-Linux-x86_64-410.93-custom.run
cp -f $SOURCEDIR/nvinstall.service $INSTALLDIR/nvinstall.service
chmod 777 nvinstall.service
cp -f $INSTALLDIR/nvinstall.service /etc/systemd/system/nvinstall.service
/bin/systemctl enable nvinstall.service
####### change Default Desktop #######
# sed -i 's/XSession=/XSession=kde/g' /var/lib/AccountsService/users/$USERNAME
sed -i 's/XSession=gnome/XSession=kde/g' /var/lib/AccountsService/users/$USERNAME
reboot
fi



#############   Config LDAP  ###############
if [ ! -e "$LDAPFILE" ]; then

#######  nss-pam-ldap nscd  #########
echo "#######  Instalando nss-pam-ldap nscd  #########" ##### 
yum install -y nss-pam-ldap nscd 

#######  nss-pam-ldap nscd  #########
echo "#######  Instalando openldap-clients nss-pam-ldapd  #########" ##### 
yum -y install openldap-clients nss-pam-ldapd


echo "#######  configurando LDAP  #########"
authconfig --enableldap \
--enableldapauth \
--ldapserver=192.168.8.9 \
--ldapbasedn="dc=o2pos,dc=com" \
--enablemkhomedir \
--updateall
#{
#if [ ! -d "$INSTALLDIR/ldap" ]; then
mkdir $INSTALLDIR/ldap/
chmod 777 $INSTALLDIR/ldap/ 
#else
cp -f -p -R $SOURCEDIR/ldap $INSTALLDIR/
cd $INSTALLDIR/ldap
#unzip -fo $INSTALLDIR/ldap/ldap.zip
cp -f $INSTALLDIR/ldap/idmapd.conf /etc/idmapd.conf
cp -f $INSTALLDIR/ldap/nslcd.conf /etc/nslcd.conf
cp -f $INSTALLDIR/ldap/nsswitch.conf /etc/nsswitch.conf
cp -f $INSTALLDIR/ldap/openldap/ldap.conf /etc/openldap/ldap.conf
cp -f $INSTALLDIR/ldap/pam.d/password-auth-ac /etc/pam.d/password-auth-ac
cp -f $INSTALLDIR/ldap/pam.d/system-auth-ac /etc/pam.d/system-auth-ac
systemctl enable nslcd
systemctl restart nslcd
reboot
fi




#####################  YUM INSTALL ####################


#############   cinnamon  ###############
#

#if [ "$CINNAMON" != "Cinnamon" ]; then
# echo "#######  Instalando cinnamon  #########" ##### 
# yum -y -q install cinnamon
#fi

#######  Pulse Audio / PAVU Control  #########
if [ "$PAUDIO" != "pulseaudio" ]; then 
 echo "#######  Instalando Pulse Audio e Pavu Control #########" ##### 
 yum -y install pulseaudio pavucontrol
fi

#######  DKMS  #########
#
##if [ "$DKMS" != "dkms" ]; then
# echo "#######  Instalando DKMS  #########" ##### 
# yum -y -q install dkms
#fi

#######  GBDM  #########
if [ ! -e "$LIBGBDM"  ]; then
 echo "#######  Instalando GBDM  #########" ##### 
 yum -y install gdbm-devel
fi
 
 ############   Vlc  ###############
if [ ! -e "$VLC" ]; then
 echo "#######  Instalando VLC  #########" #####
 yum -y install http://repo.okay.com.mx/centos/7/x86_64/release/okay-release-1-1.noarch.rpm
 yum -y install vlc
fi


 #######  NTFS3G  #########
if [ ! -e "$NTFS3G" ]; then
 yum -y install cinnamon ntfs-3g gcc mesa-libGL mesa-libGL-devel nss dkms git dnf ansible libselinux-python smplayer ffmpeg HandBrake-{gui,cli} libdvdcss gstreamer{,1}-plugins-ugly gstreamer-plugins-bad-nonfree gstreamer1-plugins-bad-freeworld libde265 x265
fi

 #######  EXFAT  #########

yum install -y http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm
yum install -y exfat-utils fuse-exfat

################### YUM UPDATE ####################


#############   cinnamon  ###############
CINNAMONVRSINST=` ( cinnamon --version ) `
CINNAMONVRSNEW="Cinnamon 3.6.7"
rm -rf /tmp/cinnamon.txt
echo $CINNAMONVRSINST >> /tmp/cinnamon.txt
CINNAMON=` (  grep -o '^[^[:space:]]\+' /tmp/cinnamon.txt ) `

if [ "$CINNAMONVRSINST" != "$CINNAMONVRSNEW" ]; then
 echo "#######  Atualizando Cinnamon  #########" ##### 
 yum -y update cinnamon
fi

#######  Pulse Audio / PAVU Control  #########
if [ "$PAUDIOVRSINST" != "$PAUDIOVRSNEW" ]; then
 echo "#######  Atualizando Pulse Audio e Pavu Control #########" ##### 
 yum -y update pulseaudio pavucontrol
fi

#######  DKMS  #########
DKMSVRSINST=` ( dkms --version ) `
DKMSVRSNEW="dkms:2.6"
rm -rf /tmp/dkms.txt
echo $DKMSVRSINST >> /tmp/dkms.txt
DKMS=` ( cut -c"-4" /tmp/dkms.txt ) `

if [ "$DKMSVRSINST" != "$DKMSVRSNEW" ]; then
 echo "#######  Atualizando DKMS #########" ##### 
  yum -y -q update dkms
fi

#############   Onix.sh  ###############
if [ ! -e "$ONIX" ]; then
 echo "#######  Adicionando onix.sh   #########" ##### 
 echo "export NUKE_PATH=/mnt/Onix/.Nuke" >> /etc/profile.d/onix.sh
# echo "export OCIO=/mnt/Onix/OCIO/ACES/config.ocio" >> /etc/profile.d/onix.sh
fi


#############   Wacom Pressure.sh  ###############
if [ ! -e "$WACOMPRESSURE" ]; then
echo "Setting Wacom Pressure" 
echo "Section \"InputClass\" " >> /etc/X11/xorg.conf.d/99-wacom-pressure2k.conf
echo "Identifier \"Wacom pressure compatibility\" " >> /etc/X11/xorg.conf.d/99-wacom-pressure2k.conf
echo "MatchDriver \"wacom\" " >> /etc/X11/xorg.conf.d/99-wacom-pressure2k.conf
echo "Option \"Pressure2K\" \"true\" " >> /etc/X11/xorg.conf.d/99-wacom-pressure2k.conf
echo "EndSection" >> /etc/X11/xorg.conf.d/99-wacom-pressure2k.conf
fi


#############   Wacom Disable Buttons and touch  ###############
if [ ! -e "$WACOMBUTTONS" ]; then
cp -f $SOURCEDIR/Wacom_disable_touch_and_ring.sh $INSTALLDIR/Wacom_disable_touch_and_ring.sh
cd $SOURCEDIR
chmod 777 Wacom_disable_touch_and_ring.sh
cp -f $INSTALLDIR/Wacom_disable_touch_and_ring.sh /etc/init.d/Wacom_disable_touch_and_ring.sh
fi 


#############   Google Chrome  ###############
if [ ! -d "$CHROMEDIR" ]; then
 echo "#######  Instalando Google Chrome  #########" ##### 
 echo "[google-chrome]" >> /etc/yum.repos.d/google-chrome.repo
 echo "name=google-chrome" >> /etc/yum.repos.d/google-chrome.repo
 echo "baseurl=http://dl.google.com/linux/chrome/rpm/stable/x86_64" >> /etc/yum.repos.d/google-chrome.repo
 echo "enabled=1" >> /etc/yum.repos.d/google-chrome.repo
 echo "gpgcheck=1" >> /etc/yum.repos.d/google-chrome.repo
 echo "gpgkey=https://dl.google.com/linux/linux_signing_key.pub" >> /etc/yum.repos.d/google-chrome.repo
 yum -y install google-chrome-stable
fi
yum update google-chrome-stable

############   TeamViewer 12   ###############
if [ ! -d "$TVDIR" ]; then
 echo "#######  Instalando TeamViewer 12  #########" ##### 
 cp -f $SOURCEDIR/teamviewer_12.0.85001.i686.rpm $INSTALLDIR/teamviewer_12.0.85001.i686.rpm
cd $INSTALLDIR
 chmod 777 teamviewer_12.0.85001.i686.rpm
 rpm -Uvh --replacefiles teamviewer_12.0.85001.i686.rpm
fi


############   TeamViewer   ###############
#{
#if [ ! -d "$TVDIR" ]; then
# echo "#######  Instalando TeamViewer  #########" ##### 
# rpm --import  https://dl.tvcdn.de/download/linux/signature/TeamViewer2017.asc
# cd $INSTALLDIR
# wget https://download.teamviewer.com/download/linux/teamviewer.x86_64.rpm
# sudo yum -y localinstall ./teamviewer.x86_64.rpm
#fi
#} 


############   Pauta  ###############
if [ ! -d "$PAUTA" ]; then
echo "#######  Instalando Pauta  #########" #####
cd /tmp
mkdir pauta
chmod 777 pauta
cd /pauta
wget https://play.o2filmes.com/pauta/app/lnx/pauta_bridge_install.sh
chmod +X pauta_bridge_install.sh
chmod 777 pauta_bridge_install.sh
bash pauta_bridge_install.sh
fi


############   Slack  ###############

if [ ! -d "$SLACKDIR" ]; then
echo "#######  Instalando Slack  #########" ##### 
cp -f $SOURCEDIR/slack-4.0.1-0.1.fc21.x86_64.rpm $INSTALLDIR/slack-4.0.1-0.1.fc21.x86_64.rpm
cd $INSTALLDIR
chmod 777 slack-4.0.1-0.1.fc21.x86_64.rpm
rpm -Uvh --replacefiles slack-4.0.1-0.1.fc21.x86_64.rpm
fi




############   krita  ###############
{
if [ ! -e "$KRITA" ]; then
 echo "#######  Instalando Krita  #########" ##### 
yum -y install calligra-krita.x86_64
fi
}

############   NUKE 10  ###############
{
if [ ! -d "$NUKEDIR" ]; then
echo "#######  Instalando Nuke 10.5v5  #########" ##### 
cp -f $SOURCEDIR/Nuke10.5v5-linux-x86-release-64.tgz $INSTALLDIR/Nuke10.5v5-linux-x86-release-64.tgz
cd $INSTALLDIR
tar -xvf $INSTALLDIR/Nuke10.5v5-linux-x86-release-64.tgz
chmod 777 Nuke10.5v5-linux-x86-release-64-installer
./Nuke10.5v5-linux-x86-release-64-installer
fi
}

###NUKE 11
#if [ ! -d "$NUKE11DIR" ]; then
# echo "#######  Instalando Nuke 11.3  #########" ##### 
# cp -f /root/Desktop/Nuke11.3v4-linux-x86-release-64.tgz $INSTALLDIR/Nuke11.3v4-linux-x86-release-64.tgz
#cd $INSTALLDIR
#tar -xvf $INSTALLDIR/Nuke11.3v4-linux-x86-release-64.tgz
# chmod 777 Nuke11.3v4-linux-x86-release-64-installer
#./Nuke11.3v4-linux-x86-release-64-installer
#fi

############   Lic NUKE ###############
{
if [ ! -e "$NUKELIC" ]; then
echo "#######  Instalando Nuke lic para 10.5  #########" ##### 
mkdir /usr/local/foundry
mkdir /usr/local/foundry/RLM/
chmod -R 777 /usr/local/foundry/
echo "HOST 192.168.8.5 any 4101" >> /usr/local/foundry/RLM/foundry_client.lic
fi
}


#############   Resolve 15  ###############
{
if [ ! -e "$RESOLVEDIR" ]; then
echo "#######  Instalando Resolve 15.3  #########" ##### 
cp -f $SOURCEDIR/DaVinci_Resolve_15.3.1_Linux.run $INSTALLDIR/DaVinci_Resolve_15.3.1_Linux.run
cd $INSTALLDIR
chmod 777 DaVinci_Resolve_15.3.1_Linux.run
sudo -u $USERNAME  -H sh -c "./DaVinci_Resolve_15.3.1_Linux.run -i -y"
fi
}

#############   Resolve 15  ###############
{
if [ ! -e "$RESOLVEDIR" ]; then
echo "#######  Instalando Resolve 15.3  #########" ##### 
cp -f $SOURCEDIR/DaVinci_Resolve_Studio_15.3.1_Linux.run $INSTALLDIR/DaVinci_Resolve_Studio_15.3.1_Linux.run
cd $INSTALLDIR
chmod 777 DaVinci_Resolve_Studio_15.3.1_Linux.run
sudo -u $USERNAME  -H sh -c "./DaVinci_Resolve_Studio_15.3.1_Linux.run -i -y"
fi
}

############   Fusion 9  ###############
#if [ ! -d "$FUSIONDIR" ]; then
#echo "#######  Instalando Fusion 9  #########" ##### 
#cp -f $SOURCEDIR/Blackmagic_Fusion_Studio_Linux_9.0.2.tar $INSTALLDIR/Blackmagic_Fusion_Studio_Linux_9.0.2.tar
#cd $INSTALLDIR
#tar -xvf $INSTALLDIR/Blackmagic_Fusion_Studio_Linux_9.0.2.tar
#chmod 777 Blackmagic_Fusion_Studio_Linux_9.0.2_installer.run
#chmod 777 Blackmagic_Fusion_Render_Node_Linux_9.0.2_installer.run
#./Blackmagic_Fusion_Studio_Linux_9.0.2_installer.run -i -y
#fi



############   Fusion 9  ###############
#if [ ! -d "$FUSIONRENDER" ]; then
#echo "#######  Instalando Fusion REnder 9  #########" ##### 
#cp -f $SOURCEDIR/Blackmagic_Fusion_Studio_Linux_9.0.2.tar $INSTALLDIR/Blackmagic_Fusion_Studio_Linux_9.0.2.tar
#cd $INSTALLDIR
#tar -xvf $INSTALLDIR/Blackmagic_Fusion_Studio_Linux_9.0.2.tar
#chmod 777 Blackmagic_Fusion_Studio_Linux_9.0.2_installer.run
#chmod 777 Blackmagic_Fusion_Render_Node_Linux_9.0.2_installer.run
#./Blackmagic_Fusion_Render_Node_Linux_9.0.2_installer.run -i -y
#fi


############   Fusion 16  ###############
if [ ! -d "$FUSION16DIR" ]; then
echo "#######  Instalando Fusion 16  #########" ##### 
cp -f $SOURCEDIR/Blackmagic_Fusion_Studio_16.1b2_Linux.tar.gz $INSTALLDIR/Blackmagic_Fusion_Studio_16.1b2_Linux.tar.gz
cd $INSTALLDIR
tar -xvf $INSTALLDIR/Blackmagic_Fusion_Studio_16.1b2_Linux.tar.gz
chmod 777 Blackmagic_Fusion_Studio_Linux_16.1_installer.run
chmod 777 Blackmagic_Fusion_Render_Node_Linux_16.1_installer.run
./Blackmagic_Fusion_Studio_Linux_16.1_installer.run -i -y
./Blackmagic_Fusion_Render_Node_Linux_16.1_installer.run -i -y
fi



#############   Fusion Render 16  ###############
#if [ ! -d "$FUSION16RENDER" ]; then
#echo "#######  Instalando Fusion REnder 9  #########" ##### 
#cp -f $SOURCEDIR/Blackmagic_Fusion_Studio_16.1b2_Linux.tar.gz $INSTALLDIR/Blackmagic_Fusion_Studio_16.1b2_Linux.tar.gz
#cd $INSTALLDIR
#tar -xvf $INSTALLDIR/Blackmagic_Fusion_Studio_16.1b2_Linux.tar.gz
#chmod 777 Blackmagic_Fusion_Studio_Linux_16.1_installer.run
#chmod 777 Blackmagic_Fusion_Render_Node_Linux_16.1_installer.run
#./Blackmagic_Fusion_Render_Node_Linux_16.1_installer.run -i -y
#fi



#############   PFTRACK 2017  ###############
if [ ! -e "$PFTRACKFILE" ]; then
 echo "#######  Instalando libusb  #########" ##### 
 yum -y -q install libusb
 echo "#######  Instalando PFTRACK 2017  #########" ##### 
cp -f $SOURCEDIR/pftrack-2017.05.19-1.x86_64.rpm $INSTALLDIR/pftrack-2017.05.19-1.x86_64.rpm
cd $INSTALLDIR
chmod 777 pftrack-2017.05.19-1.x86_64.rpm
rpm -Uvh pftrack-2017.05.19-1.x86_64.rpm
fi


#############   Mocha  ###############
if [ ! -d "$MOCHADIR" ]; then
echo "#######  Instalando Mocha   #########" ##### 
cp -f $SOURCEDIR/mochapro-5.5.1-13127.x86_64.rpm $INSTALLDIR/mochapro-5.5.1-13127.x86_64.rpm
cd $INSTALLDIR
chmod 777 mochapro-5.5.1-13127.x86_64.rpm
rpm -Uvh --replacefiles --nodeps mochapro-5.5.1-13127.x86_64.rpm
fi

##############   Mocha VR  ###############
if [ ! -d "$MOCHAVR" ]; then
echo "#######  Instalando Mocha VR  #########" ##### 
cp -f $SOURCEDIR/mochaVR-5.5.1-13127.x86_64.rpm $INSTALLDIR/mochaVR-5.5.1-13127.x86_64.rpm
cd $INSTALLDIR
chmod 777 mochaVR-5.5.1-13127.x86_64.rpm
rpm -Uvh --replacefiles --nodeps mochaVR-5.5.1-13127.x86_64.rpm
fi

############   Lic Mocha ###############
{
if [ ! -e "$MOCHALIC" ]; then
echo "#######  Instalando Mocha lic  #########" ##### 
mkdir /etc/opt/bis/
mkdir /etc/opt/isl/
mkdir /etc/opt/bis/licences/
mkdir /etc/opt/bis/licenses/
mkdir /etc/opt/isl/licences/
mkdir /etc/opt/isl/licenses/
chmod -R 777 /etc/opt/*
echo "SERVER Atlas 000C46CDED80" >> /etc/opt/bis/licences/client.lic
echo "USE_SERVER" >> /etc/opt/bis/licences/client.lic
echo "SERVER Atlas 000C46CDED80" >> /etc/opt/bis/licenses/client.lic
echo "USE_SERVER" >> /etc/opt/bis/licenses/client.lic
echo "SERVER Atlas 000C46CDED80" >> /etc/opt/isl/licences/client.lic
echo "USE_SERVER" >> /etc/opt/isl/licences/client.lic
echo "SERVER Atlas 000C46CDED80" >> /etc/opt/isl/licenses/client.lic
echo "USE_SERVER" >> /etc/opt/isl/licenses/client.lic
fi
}



#############   Blender  ###############
if [ ! -d "$BLENDERDIR" ]; then
echo "#######  Instalando Blender #########" ##### 
cp -f $SOURCEDIR/blender-2.80-linux-glibc217-x86_64.tar.bz2 $INSTALLDIR/blender-2.80-linux-glibc217-x86_64.tar.bz2
cd $INSTALLDIR
tar -xvf $INSTALLDIR/blender-2.80-linux-glibc217-x86_64.tar.bz2
chmod -R 777 blender-2.80-linux-glibc217-x86_64
mv blender-2.80-linux-glibc217-x86_64 /opt/blender-2.80
fi

#############   Black Magic Desktop Video  ###############
if [ ! -e "$BMDFILE" ]; then
echo "#######  Instalando Black Magic Desktop Video  #########" ##### 
cp -f $SOURCEDIR/desktopvideo-11.2a8.x86_64.rpm $INSTALLDIR/desktopvideo-11.2a8.x86_64.rpm
cp -f $SOURCEDIR/desktopvideo-gui-11.2a8.x86_64.rpm $INSTALLDIR/desktopvideo-gui-11.2a8.x86_64.rpm
cp -f $SOURCEDIR/desktopvideo-scanner-11.2a8.x86_64.rpm $INSTALLDIR/desktopvideo-scanner-11.2a8.x86_64.rpm
cp -f $SOURCEDIR/mediaexpress-3.5.9a10.x86_64.rpm $INSTALLDIR/mediaexpress-3.5.9a10.x86_64.rpm
cd $INSTALLDIR
chmod 777 desktopvideo-11.2a8.x86_64.rpm
chmod 777 desktopvideo-gui-11.2a8.x86_64.rpm
chmod 777 desktopvideo-scanner-11.2a8.x86_64.rpm
chmod 777 mediaexpress-3.5.9a10.x86_64.rpm
rpm -Uvh --replacefiles desktopvideo-11.2a8.x86_64.rpm
rpm -Uvh --replacefiles desktopvideo-gui-11.2a8.x86_64.rpm
rpm -Uvh --replacefiles desktopvideo-scanner-11.2a8.x86_64.rpm
rpm -Uvh --replacefiles mediaexpress-3.5.9a10.x86_64.rpm
fi

###################### Neat 4.8.5 ########################

if [ ! -d "$NEATDIR" ]; then
echo "#######  Instalando Neat 4.8.5  #########" ##### 
cp -f $SOURCEDIR/NeatVideoOFX.Intel64.tgz $INSTALLDIR/NeatVideoOFX.Intel64.tgz
cd $INSTALLDIR
tar -xvf $INSTALLDIR/NeatVideoOFX.Intel64.tgz
chmod -R 777 NeatVideo4OFX.Pro.Intel64.run
./NeatVideo4OFX.Pro.Intel64.run --mode console
fi

###################### MAYA 17 ########################

if [ ! -d "$MAYA17DIR" ]; then
echo "#######  Instalando MAYA 2017.5  #########" ##### 
mkdir $INSTALLDIR/maya2017
chmod 777 $INSTALLDIR/maya2017
cp -f $SOURCEDIR/Autodesk_Maya_2017_Update5_EN_Linux_64bit.tgz $INSTALLDIR/maya2017/Autodesk_Maya_2017_Update5_EN_Linux_64bit.tgz
cd $INSTALLDIR/maya2017
tar -xvf $INSTALLDIR/maya2017/Autodesk_Maya_2017_Update5_EN_Linux_64bit.tgz
#./setup-bin --noui --force
./setup --noui --force --serial_number=561-74540031 --product_key=657I1 --license_type=kStandalone
fi

###################### Vray 3.6 - MAYA 17 ########################

if [ ! -d "$VRAYMAYA17" ]; then
echo "#######  Instalando Vray Next for MAYA 19  #########" ##### 
cp -f $SOURCEDIR/vray_adv_36001_maya2017_linux_x64 $INSTALLDIR/vray_adv_36001_maya2017_linux_x64
cp -f $SOURCEDIR/config_vray_2017.xml $INSTALLDIR/config_vray_2017.xml
cd $INSTALLDIR
chmod 777 $INSTALLDIR/vray_adv_36001_maya2017_linux_x64
chmod 777 $INSTALLDIR/config_vray_2017.xml
./vray_adv_36001_maya2017_linux_x64 -gui=0 -configFile="$INSTALLDIR/config_vray_2017.xml" -quiet=1
fi




###################### MAYA 19 ########################

if [ ! -d "$MAYA19DIR" ]; then
echo "#######  Instalando MAYA 2019  #########" ##### 
mkdir $INSTALLDIR/maya2019
chmod 777 $INSTALLDIR/maya2019
cp -f $SOURCEDIR/Autodesk_Maya_2019_2_Update_Linux_64bit.tgz $INSTALLDIR/maya2019/Autodesk_Maya_2019_2_Update_Linux_64bit.tgz
cd $INSTALLDIR/maya2019
tar -xvf $INSTALLDIR/maya2019/Autodesk_Maya_2019_2_Update_Linux_64bit.tgz
#./setup-bin --noui --force
./setup-bin --noui --force --serial_number=561-74540031 --product_key=657K1 --license_type=kStandalone
fi


# --serial_number=666-69696969 --product_key=657K1 --license_type=kNetwork --server_name=licserv


###################### Vray Next - MAYA 19 ########################

if [ ! -d "$VRAYMAYA19" ]; then
echo "#######  Instalando Vray Next for MAYA 19  #########" ##### 
cp -f $SOURCEDIR/vray_adv_41202_maya2019_linux_x64 $INSTALLDIR/vray_adv_41202_maya2019_linux_x64
cp -f $SOURCEDIR/config_vray_2019.xml $INSTALLDIR/config_vray_2019.xml
cd $INSTALLDIR
chmod 777 $INSTALLDIR/vray_adv_41202_maya2019_linux_x64
chmod 777 $INSTALLDIR/config_vray_2019.xml
./vray_adv_41202_maya2019_linux_x64 -gui=0 -configFile="$INSTALLDIR/config_vray_2019.xml" -quiet=1
fi


###################### HOUDINI 17.5.173 ########################

if [ ! -d "$HOUDINIDIR" ]; then
echo "#######  Instalando houdini-17.5.173  #########" ##### 
cp -f $SOURCEDIR/houdini-17.5.173-linux_x86_64_gcc6.3.tar.gz $INSTALLDIR/houdini-17.5.173-linux_x86_64_gcc6.3.tar.gz
cd $INSTALLDIR
tar -xvf $INSTALLDIR/houdini-17.5.173-linux_x86_64_gcc6.3.tar.gz
chmod -R 777 houdini-17.5.173-linux_x86_64_gcc6.3
cd houdini-17.5.173-linux_x86_64_gcc6.3
./houdini.install --make-dir --install-houdini --auto-install --accept-EULA 
rm -rf /home/$USERNAME/.sesi_licenses.pref
echo "serverhost=192.168.8.63" >> /home/$USERNAME/.sesi_licenses.pref
/opt/hfs17.5/bin/hserver -S 192.168.8.63
fi



###################Spotify###################
SPOTIFY2=` ( spotify --version ) `
if [ "$SPOTIFY" != "$SPOTIFY2" ]; then
snap install spotify
fi



########## Disabling Auto Login KDE ##########
# sed -i 's/AutoLoginEnable=true/#AutoLoginEnable=true/g' /usr/share/config/kdm/kdmrc
# sed -i 's/AutoLoginUser=o2/#AutoLoginUser=o2/g' /usr/share/config/kdm/kdmrc
# sed -i 's/AutoLoginPass=o2/#AutoLoginPass=o2/g' /usr/share/config/kdm/kdmrc


########## Disabling Gnome Auto Login ##########
mv -f /etc/gdm/custom.bkp /etc/gdm/custom.conf


########## Removing user from sudores ##########
 mv -f /etc/sudores.bkp /etc/sudores

##########Enabling service on restart ############
#systemctl enable update2.service


########## Removing root permissions form user ##########
 gpasswd -d $USERNAME wheel

########## Removing Install Dir  ##########
rm -rf $INSTALLDIR

 echo "Workstation updated"

else

 echo "Please,run as root!"
 echo "Workstation NOT updated"


fi
