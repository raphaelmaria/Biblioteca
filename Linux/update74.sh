#!/bin/bash
#
# Update O2 Comp-E
#
# By Uira Vilanova
#
#
#
# Instalacao e atualizacao de sistemas e softwares para "comp entretenimento O2"
#
# v1.71
#
##################################################################################
#
#
############ Variaveis ##############
INSTALLDIR="/mnt/installers"
SOURCEDIR="/mnt/RRender/Installers"
LASTKERNEL="/usr/src/kernels/3.10.0-957.27.2.el7.x86_64"
NUKEDIR="/usr/local/Nuke10.5v5/"
NUKE11DIR="/usr/local/Nuke11.3v4/"
RESOLVEDIR="/opt/resolve/bin/resolve"
FUSIONDIR="/opt/BlackmagicDesign/Fusion9/"
FUSIONRENDER="/opt/BlackmagicDesign/FusionRenderNode9/"
PFTRACKFILE="/usr/bin/pftrack2017"
MOCHADIR="/opt/isl/mochaproV5/bin/"
MOCHAVR="/opt/isl/mochaVRV5/bin/"
MOCHALIC="/etc/opt/bis/licences/client.lic"
BMDFILE="/usr/share/applications/BlackmagicDesktopVideoSetup.desktop"
LDAPFILE="/etc/nslcd.conf"
CHROMEDIR="/opt/google/chrome/"
ONIX="/etc/profile.d/onix.sh"
OCIO="/etc/profile.d/ocio.sh"
BLENDERDIR="/opt/blender-2.80/"
NUKELIC="/usr/local/foundry/RLM/foundry_client.lic"
TVDIR="/opt/teamviewer/"
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
LASTIPNUM=` ( ip -o addr show dev "$NETENID4" | awk '$3 == "inet" {print $4}' | sudo sed -r 's!/.*!!; s!.*\.!!' ) `
NUMNAME=` ( expr $LASTIPNUM - 100 ) `
USER1=` ( who -u ) `
rm -rf /tmp/loggeduser.txt
echo $USER1 >> /tmp/loggeduser.txt
USER2=` (  sed -i 's/root//g' /tmp/loggeduser.txt ) `
USER3=` (grep -o '^[^[:space:]]\+' /tmp/loggeduser.txt ) `
#USER3=` (  awk 'NF'   /tmp/loggeduser.txt ) `
USERNAME="$USER3"
UPSERVICE="/etc/systemd/system/update.service"
VLC="/usr/bin/svlc"
PAUTA="/usr/local/o2pauta"
SLACKDIR="/usr/bin/slack"
KRITA="/usr/bin/kiita"
GNOMEBKP="/etc/gdm/custom.bkp"
GNOMECONF=` ( cat /etc/gdm/custom.conf) `
SUDORES="/etc/sudores.bkp"
AUTOSTARTFI="/home/$USERNAME/.config/autostart/update.desktop"
AUTOSTARTFO="/home/$USERNAME/.config/autostart/"

##########  ADDUser Admin  ##########
sudo usermod -a -G wheel $USERNAME


#########  Adding User in sudores #####
if [ ! -e "$SUDORES" ]; then
sudo cp -f /etc/sudores /etc/sudores.bkp
#echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudores
echo "$USERNAME ALL=(ALL) ALL" >> /etc/sudores
fi

#### Change User ####
#sudo -H -u $USERNAME bash -c "/home/o2/Desktop/update69.sh"



##########  Install Dir ##########

if [ ! -d "$INSTALLDIR" ]; then
sudo echo "Creating ${INSTALLDIR}..."
sudo mkdir $INSTALLDIR/
sudo chmod 777 $INSTALLDIR/  
fi


########## Enabling Auto Login KDE ##########
#sudo cp -f /usr/share/config/kdm/kdmrc /usr/share/config/kdm/kdmrc.bkp
#sudo sed -i 's/#AutoLoginEnable=true/AutoLoginEnable=true/g' /usr/share/config/kdm/kdmrc
#sudo sed -i 's/#AutoLoginUser=fred/AutoLoginUser=o2/g' /usr/share/config/kdm/kdmrc
#sudo sed -i 's/#AutoLoginUser=o2/AutoLoginUser=o2/g' /usr/share/config/kdm/kdmrc
#sudo sed -i 's/#AutoLoginPass=secret!/AutoLoginPass=o2/g' /usr/share/config/kdm/kdmrc
#sudo sed -i 's/#AutoLoginPass=o2/AutoLoginPass=o2/g' /usr/share/config/kdm/kdmrc


########## Enabling Auto Login GNOME ##########
if [ ! -e "$GNOMEBKP" ]; then
mv -f /etc/gdm/custom.conf /etc/gdm/custom.bkp
sudo echo "# GDM configuration storage" >> /etc/gdm/custom.conf
sudo echo "" >> /etc/gdm/custom.conf
sudo echo "[daemon]" >> /etc/gdm/custom.conf
sudo echo "" >> /etc/gdm/custom.conf
sudo echo "AutomaticLoginEnable=True" >> /etc/gdm/custom.conf
sudo echo "AutomaticLogin=o2" >> /etc/gdm/custom.conf
sudo echo "" >> /etc/gdm/custom.conf
sudo echo "[security]" >> /etc/gdm/custom.conf
sudo echo "" >> /etc/gdm/custom.conf
sudo echo "" >> /etc/gdm/custom.conf
sudo echo "[xdmcp]" >> /etc/gdm/custom.conf
sudo echo "" >> /etc/gdm/custom.conf
sudo echo "[debug]" >> /etc/gdm/custom.conf
sudo echo "# Uncomment the line below to turn on debugging" >> /etc/gdm/custom.conf
sudo echo "#Enable=true" >> /etc/gdm/custom.conf
#sudo echo "$GNOMECONF"
fi


########## Enabling Service Script Autorun ##########
#if [ ! -e "$UPSERVICE" ]; then
#sudo cp -f $SOURCEDIR/update.service $INSTALLDIR/update.service
#sudo cp -f $INSTALLDIR/update.service $UPSERVICE
#fi


##########  hostname  ##########
if [ "$HOSTNAME1" == "$HOSTNAME2" ]
then
{
if [ ! -d "$BKPFILES" ]; then
sudo mkdir $BKPFILES
elsif
[ ! -d "$BKPFILES/$DATE" ]
sudo mkdir $BKPFILES/$DATE
else
sudo chmod 777 $BKPFILES/*
fi
}
mv -f /etc/hostname  $BKPFILES/$DATE/hostname
sudo echo "Digite o nome desejado para a maquina"
read HOSTNAME
sudo echo $HOSTNAME >> /etc/hostname
hostname $HOSTNAME
fi  

##########  IP Fixo - user interaction  ###########
if [ "$NETBOOTPROTO" == "$NETPROTOCHK" ]
then
sudo echo ""
sudo echo ""
sudo echo "#####Configurando rede#######"
sudo echo ""
sudo echo "Interfaces disponiveis:"
sudo echo "$NETENID"
sudo echo ""
sudo echo "Digite o nome da interface desejada"
read ENID
sudo echo ""
sudo echo "Digite o IP da maquina"
read IPADDED
NETUUIDUI=` ( grep -F "UUID" $NETPATH/ifcfg-$ENID ) `
{
if [ ! -d "$BKPFILES" ]; then
sudo mkdir $BKPFILES
elsif
[ ! -d "$BKPFILES/$DATE" ]
sudo mkdir $BKPFILES/$DATE
else
sudo chmod 777 $BKPFILES/*
fi
}
mv /etc/sysconfig/network-scripts/ifcfg-$ENID $BKPFILES/$DATE/$ENID
sudo echo "
# By Uirado
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
sudo systemctl restart network
sleep 12
sudo reboot
fi

##########  IP Fixo - auto get name eth id ############
#if [ "$NETBOOTPROTO" == "$NETPROTOCHK" ]
#then
#sudo echo "Digite o IP da m[aquina"
#read IPADDED
#{
#if [ ! -d "$BKPFILES" ]; then
#sudo mkdir $BKPFILES
#elsif
#[ ! -d "$BKPFILES/$DATE" ]
#sudo mkdir $BKPFILES/$DATE
#else
#sudo chmod 777 $BKPFILES/*
#fi
#}
#mv /etc/sysconfig/network-scripts/$NETENID3 $BKPFILES/$DATE/$NETENID3
#sudo echo "
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
#sudo systemctl restart network
#sleep 5
#sudo reboot
#fi

###########  ADDUser Admin  ##########
#if [ "$USERADMIN2" != "$USERADMIN" ]
#then
#sudo echo "Digite a senha para o usu[ario admin"
#read ADMINPASS
#adduser admin
#sudo echo "$ADMINPASS" | passwd --stdin admin
#usermod -a -G wheel admin
#fi


##########  FSTAB  ##########

if [ "$MOUNTS" != "$MOUNTS2" ]
then
{
if [ ! -d "/opt2" ]; then
sudo mkdir /opt2
fi
}
{
if [ ! -d "/mnt/Onix" ]; then
sudo mkdir /mnt/Onix
fi
}
{
if [ ! -d "/mnt/Library" ]; then
sudo mkdir /mnt/Library
fi
}
{
if [ ! -d "/mnt/Publicidade" ]; then
sudo mkdir /mnt/Publicidade
fi
}
{
if [ ! -d "/mnt/Entretenimento" ]; then
sudo mkdir /mnt/Entretenimento
fi
}
{
if [ ! -d "/mnt/Entretenimento2" ]; then
sudo mkdir /mnt/Entretenimento2
fi
}
{
if [ ! -d "/mnt/Entretenimento3" ]; then
sudo mkdir /mnt/Entretenimento3
fi
}
{
if [ ! -d "/mnt/Entretenimento4" ]; then
sudo mkdir /mnt/Entretenimento4
fi
}
{
if [ ! -d "/mnt/RRender" ]; then
sudo mkdir /mnt/RRender 
fi
}
{
if [ ! -d "/mnt/RAW1" ]; then
sudo mkdir /mnt/RAW1 
fi
}
{
if [ ! -d "/mnt/RAW2" ]; then
sudo mkdir /mnt/RAW2 
fi
}
{
if [ ! -d "/mnt/RAW3" ]; then
sudo mkdir /mnt/RAW3 
fi
}
{
if [ ! -d "/mnt/RAWADV" ]; then
sudo mkdir /mnt/RAWADV 
fi
}
{
if [ ! -d "/mnt/Library2 " ]; then
sudo mkdir /mnt/Library2  
fi
}
{
if [ ! -d "/mnt/install" ]; then
sudo mkdir /mnt//mnt/install 
fi
}
sudo chmod 777 /mnt/*
sudo chmod 777 /opt2
sudo echo "192.168.8.33:/opt                       /opt2                   nfs     defaults        0 0" >> /etc/fstab
sudo echo "192.168.8.2:/Storage/Onix               /mnt/Onix               nfs     defaults        0 0" >> /etc/fstab
sudo echo "192.168.8.2:/Storage/Library            /mnt/Library            nfs     defaults        0 0" >> /etc/fstab
sudo echo "192.168.8.14:/Storage/Publicidade       /mnt/Publicidade        nfs     defaults        0 0" >> /etc/fstab
sudo echo "192.168.8.31:/Storage/Entretenimento    /mnt/Entretenimento     nfs     defaults        0 0" >> /etc/fstab
sudo echo "192.168.8.22:/Storage/Entretenimento2   /mnt/Entretenimento2    nfs     defaults        0 0" >> /etc/fstab
sudo echo "192.168.8.25:/Storage/Entretenimento3   /mnt/Entretenimento3    nfs     defaults        0 0" >> /etc/fstab
sudo echo "192.168.8.39:/Storage/Entretenimento4   /mnt/Entretenimento4    nfs     defaults        0 0" >> /etc/fstab
sudo echo "192.168.8.200:/mnt/RRender              /mnt/RRender            nfs     defaults        0 0" >> /etc/fstab
sudo echo "192.168.8.19:/Storage/RAW1              /mnt/RAW1               nfs     defaults        0 0" >> /etc/fstab
sudo echo "192.168.8.32:/Storage/RAW2              /mnt/RAW2               nfs     defaults        0 0" >> /etc/fstab
sudo echo "192.168.8.38:/Storage/RAW3              /mnt/RAW3               nfs     defaults        0 0" >> /etc/fstab
sudo echo "192.168.8.86:/Storage/RAWADV            /mnt/RAWADV             nfs     defaults        0 0" >> /etc/fstab
sudo echo "192.168.8.48:/Storage/Library2          /mnt/Library2           nfs     defaults        0 0" >> /etc/fstab
sudo echo "#192.168.8.7:/Storage/install            /mnt/install            nfs     defaults        0 0" >> /etc/fstab
sudo mount -a
fi

######  Adding to AutoStart #########
if [ ! -e "$AUTOSTARTFI" ]; then
sudo echo "#######  Adding to AutoStart  #########" ##### 
sudo mkdir "/home/$USERNAME/.config/autostart/"
sudo cp -f $SOURCEDIR/update.desktop $INSTALLDIR/update.desktop
sudo cp -f $INSTALLDIR/update.desktop $AUTOSTARTFO/update.desktop
sudo chmod -R 777 "/home/$USERNAME/.config/autostart/update.desktop"
fi


#######  Epel Release / Last Kernel #########
if [ ! -d "$LASTKERNEL" ]; then
sudo echo "#######  Instalando Epel  #########" ##### 
cd $INSTALLDIR
sudo sudo yum -y install wget
sudo yum -y install epel-release
wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo rpm -i epel-release-latest-7.noarch.rpm
sudo yum -y update
sudo yum install -y dolphin
sudo reboot
fi




##############  NVidia   ###################
if [ ! -d "$NVINSTALLEDDIR" ]; then
sudo grubby --update-kernel=ALL   --args="rd.driver.blacklist=nouveau nouveau.modeset=0"
sudo cp -f $SOURCEDIR/NVIDIA-Linux-x86_64-410.93-custom.run $INSTALLDIR/NVIDIA-Linux-x86_64-410.93-custom.run
cd $INSTALLDIR
sudo chmod 777 NVIDIA-Linux-x86_64-410.93-custom.run
sudo cp -f $SOURCEDIR/nvinstall.service $INSTALLDIR/nvinstall.service
sudo chmod 777 nvinstall.service
sudo cp -f $INSTALLDIR/nvinstall.service /etc/systemd/system/nvinstall.service
sudo systemctl enable nvinstall.service
####### change Default Desktop #######
sudo sed -i 's/XSession=gnome/XSession=kde/g' /var/lib/AccountsService/users/o2
#sudo reboot
fi


#############   Config LDAP  ###############
if [ ! -e "$LDAPFILE" ]; then

#######  nss-pam-ldap nscd  #########
sudo echo "#######  Instalando nss-pam-ldap nscd  #########" ##### 
sudo yum -y install nss-pam-ldap nscd 

#######  nss-pam-ldap nscd  #########
sudo echo "#######  Instalando openldap-clients nss-pam-ldapd  #########" ##### 
sudo yum -y install openldap-clients nss-pam-ldapd


sudo echo "#######  configurando LDAP  #########"
authconfig --enableldap \
--enableldapauth \
--ldapserver=192.168.8.9 \
--ldapbasedn="dc=o2pos,dc=com" \
--enablemkhomedir \
--updateall
#{
#if [ ! -d "$INSTALLDIR/ldap" ]; then
sudo mkdir $INSTALLDIR/ldap/
sudo chmod 777 $INSTALLDIR/ldap/ 
#else
sudo cp -f -p -R $SOURCEDIR/ldap $INSTALLDIR/
cd $INSTALLDIR/ldap
#unzip -fo $INSTALLDIR/ldap/ldap.zip
sudo cp -f $INSTALLDIR/ldap/idmapd.conf /etc/idmapd.conf
sudo cp -f $INSTALLDIR/ldap/nslcd.conf /etc/nslcd.conf
sudo cp -f $INSTALLDIR/ldap/nsswitch.conf /etc/nsswitch.conf
sudo cp -f $INSTALLDIR/ldap/openldap/ldap.conf /etc/openldap/ldap.conf
sudo cp -f $INSTALLDIR/ldap/pam.d/password-auth-ac /etc/pam.d/password-auth-ac
sudo cp -f $INSTALLDIR/ldap/pam.d/system-auth-ac /etc/pam.d/system-auth-ac
sudo systemctl enable nslcd
sudo systemctl restart nslcd
sudo reboot
fi
#}
#fi



#######  libusb  #########
sudo echo "#######  Instalando libusb  #########" ##### 
sudo yum -y install libusb

#############   cinnamon  ###############
sudo echo "#######  Instalando cinnamon  #########" ##### 
sudo yum -y install cinnamon

#######  DKMS  #########
sudo echo "#######  Instalando DKMS  #########" ##### 
sudo yum -y install dkms


#######  GBDM  #########
sudo echo "#######  Instalando GBDM  #########" ##### 
sudo yum -y install gdbm-devel

#######  Pulse Audio / PAVU Control  #########
sudo echo "#######  Instalando GBDM  #########" ##### 
sudo yum -y install pulseaudio pavucontrol


#######  Slack  #########
#sudo echo "#######  Instalando Slack  #########" #####
#sudo yum -y install slack-4.0.1-0.1.fc21.x86_64.rpm

#######  NTFS3G  #########
if [ ! -e "$NTFS3G" ]; then
sudo yum -y install ntfs-3g
fi


#######  NTFS3G  #########
#if [ ! -e "$NTFS3G" ]; then
#sudo yum install -y dolphin
#fi


#############   Onix.sh  ###############
if [ ! -e "$ONIX" ]; then
sudo echo "#######  Adicionando onix.sh   #########" ##### 
sudo echo "export NUKE_PATH=/mnt/Onix/.Nuke" >> /etc/profile.d/onix.sh
#sudo echo "export OCIO=/mnt/Onix/OCIO/ACES/config.ocio" >> /etc/profile.d/onix.sh
fi



#############   Google Chrome  ###############
if [ ! -d "$CHROMEDIR" ]; then
sudo echo "#######  Instalando Google Chrome  #########" ##### 
sudo echo "[google-chrome]" >> /etc/sudo yum.repos.d/google-chrome.repo
sudo echo "name=google-chrome" >> /etc/sudo yum.repos.d/google-chrome.repo
sudo echo "baseurl=http://dl.google.com/linux/chrome/rpm/stable/x86_64" >> /etc/sudo yum.repos.d/google-chrome.repo
sudo echo "enabled=1" >> /etc/sudo yum.repos.d/google-chrome.repo
sudo echo "gpgcheck=1" >> /etc/sudo yum.repos.d/google-chrome.repo
sudo echo "gpgkey=https://dl.google.com/linux/linux_signing_key.pub" >> /etc/sudo yum.repos.d/google-chrome.repo
sudo yum -y install google-chrome-stable
fi

############   TeamViewer 12   ###############
{
if [ ! -d "$TVDIR" ]; then
sudo echo "#######  Instalando TeamViewer 12  #########" ##### 
sudo cp -f $SOURCEDIR/teamviewer_12.0.85001.i686.rpm $INSTALLDIR/teamviewer_12.0.85001.i686.rpm
cd $INSTALLDIR
sudo chmod 777 teamviewer_12.0.85001.i686.rpm
#sudo rpm -Uvh --replacefiles teamviewer_12.0.85001.i686.rpm
fi
}

#############   TeamViewer 13   ###############
#{
#if [ ! -d "$TVDIR" ]; then
#sudo echo "#######  Instalando TeamViewer 13  #########" ##### 
#sudo cp -f $SOURCEDIR/teamviewer_13.2.75536.x86_64.rpm $INSTALLDIR/teamviewer_13.2.75536.x86_64.rpm
#cd $INSTALLDIR
#sudo chmod 777 teamviewer_13.2.75536.x86_64.rpm
#sudo rpm -Uvh --replacefiles teamviewer_13.2.75536.x86_64.rpm
#fi
#}

############   TeamViewer 14   ###############
#{
#if [ ! -d "$TVDIR" ]; then
#sudo echo "#######  Instalando TeamViewer 14 #########" ##### 
#sudo cp -f $SOURCEDIR/teamviewer-host_14.4.2669.x86_64.rpm $INSTALLDIR/teamviewer-host_14.4.2669.x86_64.rpm
#cd $INSTALLDIR
#sudo chmod 777 teamviewer-host_14.4.2669.x86_64.rpm
#sudo rpm -Uvh --replacefiles teamviewer-host_14.4.2669.x86_64.rpm
#fi
#}


############   Pauta  ###############
{
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
}



############   Slack  ###############
{
if [ ! -d "$SLACKDIR" ]; then
sudo echo "#######  Instalando Slack  #########" ##### 
sudo cp -f $SOURCEDIR/slack-4.0.1-0.1.fc21.x86_64.rpm $INSTALLDIR/slack-4.0.1-0.1.fc21.x86_64.rpm
cd $INSTALLDIR
sudo chmod 777 slack-4.0.1-0.1.fc21.x86_64.rpm
sudo rpm -Uvh --replacefiles slack-4.0.1-0.1.fc21.x86_64.rpm
fi
}

############   Vlc  ###############
{
if [ ! -e "$VLC" ]; then
sudo echo "#######  Instalando VLC  #########" #####
sudo yum -y install http://repo.okay.com.mx/centos/7/x86_64/release/okay-release-1-1.noarch.rpm
sudo yum -y install vlc
fi
}

############   krita  ###############
if [ ! -e "$KRITA" ]; then
sudo echo "#######  Instalando Krita  #########" ##### 
yum -y install calligra-krita.x86_64
fi

############   NUKE 10  ###############
if [ ! -d "$NUKEDIR" ]; then
sudo echo "#######  Instalando Nuke 10.5v5  #########" ##### 
sudo cp -f $SOURCEDIR/Nuke10.5v5-linux-x86-release-64.tgz $INSTALLDIR/Nuke10.5v5-linux-x86-release-64.tgz
cd $INSTALLDIR
tar -xvf $INSTALLDIR/Nuke10.5v5-linux-x86-release-64.tgz
sudo chmod 777 Nuke10.5v5-linux-x86-release-64-installer
./Nuke10.5v5-linux-x86-release-64-installer
fi


###NUKE 11
#if [ ! -d "$NUKE11DIR" ]; then
#sudo echo "#######  Instalando Nuke 11.3  #########" ##### 
#sudo cp -f /root/Desktop/Nuke11.3v4-linux-x86-release-64.tgz $INSTALLDIR/Nuke11.3v4-linux-x86-release-64.tgz
#cd $INSTALLDIR
#tar -xvf $INSTALLDIR/Nuke11.3v4-linux-x86-release-64.tgz
#sudo chmod 777 Nuke11.3v4-linux-x86-release-64-installer
#./Nuke11.3v4-linux-x86-release-64-installer
#fi

############   Lic NUKE ###############
{
if [ ! -e "$NUKELIC" ]; then
sudo echo "#######  Instalando Nuke lic para 10.5  #########" ##### 
sudo mkdir /usr/local/foundry
sudo mkdir /usr/local/foundry/RLM/
sudo chmod -R 777 /usr/local/foundry/
sudo echo "HOST 192.168.8.5 any 4101" >> /usr/local/foundry/RLM/foundry_client.lic
fi
}


#############   Resolve 15  ###############
{
if [ ! -e "$RESOLVEDIR" ]; then
sudo echo "#######  Instalando Resolve 15.3  #########" ##### 
sudo cp -f $SOURCEDIR/DaVinci_Resolve_15.3.1_Linux.run $INSTALLDIR/DaVinci_Resolve_15.3.1_Linux.run
cd $INSTALLDIR
sudo chmod 777 DaVinci_Resolve_15.3.1_Linux.run
sudo -u $USERNAME  -H sh -c "./DaVinci_Resolve_15.3.1_Linux.run -i -y"
fi
}

############   Fusion 9  ###############
if [ ! -d "$FUSIONDIR" ]; then
sudo echo "#######  Instalando Fusion 9  #########" ##### 
sudo cp -f $SOURCEDIR/Blackmagic_Fusion_Studio_Linux_9.0.2.tar $INSTALLDIR/Blackmagic_Fusion_Studio_Linux_9.0.2.tar
cd $INSTALLDIR
tar -xvf $INSTALLDIR/Blackmagic_Fusion_Studio_Linux_9.0.2.tar
sudo chmod 777 Blackmagic_Fusion_Studio_Linux_9.0.2_installer.run
sudo chmod 777 Blackmagic_Fusion_Render_Node_Linux_9.0.2_installer.run
./Blackmagic_Fusion_Studio_Linux_9.0.2_installer.run -i -y
fi


############   Fusion 9 Render ###############
if [ ! -d "$FUSIONRENDER" ]; then
sudo echo "#######  Instalando Fusion REnder 9  #########" ##### 
sudo cp -f $SOURCEDIR/Blackmagic_Fusion_Studio_Linux_9.0.2.tar $INSTALLDIR/Blackmagic_Fusion_Studio_Linux_9.0.2.tar
cd $INSTALLDIR
tar -xvf $INSTALLDIR/Blackmagic_Fusion_Studio_Linux_9.0.2.tar
sudo chmod 777 Blackmagic_Fusion_Studio_Linux_9.0.2_installer.run
sudo chmod 777 Blackmagic_Fusion_Render_Node_Linux_9.0.2_installer.run
./Blackmagic_Fusion_Render_Node_Linux_9.0.2_installer.run -i -y
fi


#############   PFTRACK 2017  ###############
if [ ! -e "$PFTRACKFILE" ]; then
sudo echo "#######  Instalando PFTRACK 2017  #########" ##### 
sudo cp -f $SOURCEDIR/pftrack-2017.05.19-1.x86_64.rpm $INSTALLDIR/pftrack-2017.05.19-1.x86_64.rpm
cd $INSTALLDIR
sudo chmod 777 pftrack-2017.05.19-1.x86_64.rpm
sudo rpm -Uvh pftrack-2017.05.19-1.x86_64.rpm
fi



#############   Mocha  ###############
if [ ! -d "$MOCHADIR" ]; then
sudo echo "#######  Instalando Mocha   #########" ##### 
sudo cp -f $SOURCEDIR/mochapro-5.5.1-13127.x86_64.rpm $INSTALLDIR/mochapro-5.5.1-13127.x86_64.rpm
cd $INSTALLDIR
sudo chmod 777 mochapro-5.5.1-13127.x86_64.rpm
sudo rpm -Uvh --replacefiles --nodeps mochapro-5.5.1-13127.x86_64.rpm
fi

##############   Mocha VR  ###############
if [ ! -d "$MOCHAVR" ]; then
sudo echo "#######  Instalando Mocha VR  #########" ##### 
sudo cp -f $SOURCEDIR/mochaVR-5.5.1-13127.x86_64.rpm $INSTALLDIR/mochaVR-5.5.1-13127.x86_64.rpm
cd $INSTALLDIR
sudo chmod 777 mochaVR-5.5.1-13127.x86_64.rpm
sudo rpm -Uvh --replacefiles --nodeps mochaVR-5.5.1-13127.x86_64.rpm
fi

############   Lic Mocha ###############
{
if [ ! -e "$MOCHALIC" ]; then
sudo echo "#######  Instalando Mocha lic  #########" ##### 
sudo mkdir /etc/opt/bis/
sudo mkdir /etc/opt/isl/
sudo mkdir /etc/opt/bis/licences/
sudo mkdir /etc/opt/bis/licenses/
sudo mkdir /etc/opt/isl/licences/
sudo mkdir /etc/opt/isl/licenses/
sudo chmod -R 777 /etc/opt/*
sudo echo "SERVER Atlas 000C46CDED80" >> /etc/opt/bis/licences/client.lic
sudo echo "USE_SERVER" >> /etc/opt/bis/licences/client.lic
sudo echo "SERVER Atlas 000C46CDED80" >> /etc/opt/bis/licenses/client.lic
sudo echo "USE_SERVER" >> /etc/opt/bis/licenses/client.lic
sudo echo "SERVER Atlas 000C46CDED80" >> /etc/opt/isl/licences/client.lic
sudo echo "USE_SERVER" >> /etc/opt/isl/licences/client.lic
sudo echo "SERVER Atlas 000C46CDED80" >> /etc/opt/isl/licenses/client.lic
sudo echo "USE_SERVER" >> /etc/opt/isl/licenses/client.lic
fi
}

#############   Blender  ###############
if [ ! -d "$BLENDERDIR" ]; then
sudo echo "#######  Instalando Blender #########" ##### 
sudo cp -f $SOURCEDIR/blender-2.80-linux-glibc217-x86_64.tar.bz2 $INSTALLDIR/blender-2.80-linux-glibc217-x86_64.tar.bz2
cd $INSTALLDIR
tar -xvf $INSTALLDIR/blender-2.80-linux-glibc217-x86_64.tar.bz2
sudo chmod -R 777 blender-2.80-linux-glibc217-x86_64
mv blender-2.80-linux-glibc217-x86_64 /opt/blender-2.80
fi


#############   Black Magic Desktop Video  ###############
if [ ! -e "$BMDFILE" ]; then
sudo echo "#######  Instalando Black Magic Desktop Video  #########" ##### 
sudo cp -f $SOURCEDIR/desktopvideo-11.2a8.x86_64.rpm $INSTALLDIR/desktopvideo-11.2a8.x86_64.rpm
sudo cp -f $SOURCEDIR/desktopvideo-gui-11.2a8.x86_64.rpm $INSTALLDIR/desktopvideo-gui-11.2a8.x86_64.rpm
sudo cp -f $SOURCEDIR/desktopvideo-scanner-11.2a8.x86_64.rpm $INSTALLDIR/desktopvideo-scanner-11.2a8.x86_64.rpm
sudo cp -f $SOURCEDIR/mediaexpress-3.5.9a10.x86_64.rpm $INSTALLDIR/mediaexpress-3.5.9a10.x86_64.rpm
cd $INSTALLDIR
sudo chmod 777 desktopvideo-11.2a8.x86_64.rpm
sudo chmod 777 desktopvideo-gui-11.2a8.x86_64.rpm
sudo chmod 777 desktopvideo-scanner-11.2a8.x86_64.rpm
sudo chmod 777 mediaexpress-3.5.9a10.x86_64.rpm
sudo rpm -Uvh --replacefiles desktopvideo-11.2a8.x86_64.rpm
sudo rpm -Uvh --replacefiles desktopvideo-gui-11.2a8.x86_64.rpm
sudo rpm -Uvh --replacefiles desktopvideo-scanner-11.2a8.x86_64.rpm
sudo rpm -Uvh --replacefiles mediaexpress-3.5.9a10.x86_64.rpm
fi



########## Disabling Auto Login KDE ##########
#sudo sed -i 's/AutoLoginEnable=true/#AutoLoginEnable=true/g' /usr/share/config/kdm/kdmrc
#sudo sed -i 's/AutoLoginUser=o2/#AutoLoginUser=o2/g' /usr/share/config/kdm/kdmrc
#sudo sed -i 's/AutoLoginPass=o2/#AutoLoginPass=o2/g' /usr/share/config/kdm/kdmrc


########## Disabling Gnome Auto Login ##########
mv -f /etc/gdm/custom.bkp /etc/gdm/custom.conf


########## Removing user from sudores ##########
sudo mv -f /etc/sudores.bkp /etc/sudores

##########Enabling service on restart ############
#systemctl enable update2.service


########## Removing root permissions form user ##########
sudo gpasswd -d $USERNAME wheel

########## Removing Install Dir  ##########
rm -rf $INSTALLDIR

sudo echo "Workstation updated"
exit


