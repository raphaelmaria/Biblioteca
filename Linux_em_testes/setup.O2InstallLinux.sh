#!/bin/sh
# DESCRICAO: Script de Instalação e configuração de Softwares  Linux
# SINOPSE: Efetua a instalação e configuração de softwares Linux
# USO/EXEMPLO: ./setup.Centos_InstallZabbix5Lts.sh
#
# OPCOES: NÃO POSSUI OPÇÃO
# AUTHOR: Raphael Maria <http://raphaelmaria.com.br>
# VERSAO: 0.0.1
# LICENCA: LICENSE GPL <http://gnu.org/licenses/gpl.html>

#!/bin/sh
# DESCRICAO: Efetua a configuração inicial do host CentOS 7 ou 8
# SINOPSE: Efetua a configuração inicial do host CentOS 7 ou 8
# USO/EXEMPLO: ./setup.Centos_StartConfig.sh
#
# OPCOES: 
# AUTHOR: Raphael Maria <http://raphaelmaria.com.br>
# VERSAO: 1.0.1 in 17 de Junho de 2020
# LICENCA: LICENSE GPL <http://gnu.org/licenses/gpl.html>

# Instalação de softwares básicos.
yum -y install dialog tree wget tar unzip tcsh vim make gcc dnf autoconf automake epel-release 

##### VARIAVEIS
VARHOSTNAME=$(dialog --stdout --inputbox 'Insira o nome  do hostname desta maquina: ' 0 0)
VARIPADDRESS=$(dialog --stdout --inputbox 'Insira o IP ADDRESS do hostname desta maquina: ' 0 0)
hostnamectl set-hostname $VARHOSTNAME

# Altera somente o IP Address de DHCP para FIXO com o ip designado anterimente.
VARINTERFACE=$(nmcli con show | tail -1 | awk '{print $1}')
nmcli con modify $VARINTERFACE ipv4.method manual ipv4.addresses $VARIPADDRESS/24 ipv4.gateway 192.168.8.1 ipv4.dns 192.168.8.15,192.168.8.100,8.8.8.8
nmcli con up $VARINTERFACE

# INSTALACOES COMPLEMENTARES E UPDATES
yum -y install ansible
yum provides pip
yum install python2-pip -y
pip2 install pip --upgrade
pip2 install ansible
pip2 install ansible --upgrade
yum check-update
yum update -y

# Fazendo update de todo os sistema operacional
yum -y upgrade
yum -y update

# Instala o Dashboard WEB Red Hat Cockpit
yum -y install cockpit
systemctl enable --now cockpit.socket
firewall-cmd --permanent --zone=public --add-service=cockpit
firewall-cmd --reload

# Variaveis de Origem de Instalacao
SOURCEINSTALL="/mnt/deploy/Installers"
INSTALLDIR="/mnt/installers"

# Variaveis de Destino de Instalacoes
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
HOUDINIDIR="/opt/hfs17.5.460"
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
NVINSTALLEDDIR="/usr/src/nvidia-440.100/"
NTFS3G="/usr/lib64/libntfs-3g.so.88.0.0"
DATE=` ( date '+%Y''%m''%d' ) `
BKPFILES="/mnt/backup_files"
VLC="/usr/bin/svlc"
PAUTA="/usr/local/o2pauta"
SLACKDIR="/usr/bin/slack"
KRITA="/usr/bin/krita"
GNOMEBKP="/etc/gdm/custom.bkp"
GNOMECONF=` ( cat /etc/gdm/custom.conf ) `
SUDORES="/etc/sudores.bkp"
AUTOSTARTFI="/home/o2/.config/autostart/update.desktop"
AUTOSTARTFO="/home/o2/.config/autostart/"
LIBGBDM="/usr/lib64/libgbm.so.1.0.0"
SNAPD="/var/lib/snapd/snap"
SPOTIFY="Spotify version 1.1.10.546.ge08ef575, Copyright (c) 2019, Spotify Ltd"
PAUDIOVRSINST=` ( pulseaudio --version ) `
PAUDIOVRSNEW="pulseaudio 10.0"
rm -rf /tmp/paudio.txt
echo $PAUDIOVRSINST >> /tmp/paudio.txt
PAUDIO=` (  grep -o '^[^[:space:]]\+' /tmp/paudio.txt ) `

# SET TIMEZONE 
timedatectl set-timezone America/Sao_Paulo

# Criando User O2 Admin Local
useradd o2
passwd o2 << EOF
o2
o2
EOF
usermod -a -G wheel o2
# Criando User Render Admin Local
useradd render
passwd render << EOF
o22009render
o22009render
EOF
usermod -a -G wheel render

#########  Adding User in sudores #####
if [ ! -e "$SUDORES" ]; then
 cp -f /etc/sudores /etc/sudores.bkp
echo "$USERNAME ALL=(ALL) ALL" >> /etc/sudores
fi

##########  Install Dir ##########
if [ ! -d "$INSTALLDIR" ]; then
 echo "Creating ${INSTALLDIR}..."
 mkdir $INSTALLDIR/
 chmod 777 $INSTALLDIR/  
fi

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
fi

##########  FSTAB  ##########
umount -a
mkdir -p /mnt/cache
ln -s /mnt/cache /mnt/Cache_Nuke
ln -s /mnt/cache /mnt/cache_nuke
mkdir -p /opt2
mkdir -p /mnt/{RAW1,RAW2,RAW3,RAW4,RAWADV,Publicidade,Onix,Entretenimento,Entretenimento2,Entretenimento3,Entretenimento4,RRender,deploy,Library,Library2,Install}
chmod 777 /mnt/*
chmod 777 /opt2
echo "192.168.8.33:/opt                       /opt2                   nfs     defaults,nofail        0 0" >> /etc/fstab
echo "192.168.8.24:/deploy                    /mnt/deploy             nfs     defaults,nofail        0 0" >> /etc/fstab
echo "192.168.8.2:/Storage/Onix               /mnt/Onix               nfs     defaults,nofail        0 0" >> /etc/fstab
echo "192.168.8.2:/Storage/Library            /mnt/Library            nfs     defaults,nofail        0 0" >> /etc/fstab
echo "192.168.8.14:/mnt/storage/Publicidade   /mnt/Publicidade        nfs     defaults,nofail        0 0" >> /etc/fstab
echo "192.168.8.31:/Storage/Entretenimento    /mnt/Entretenimento     nfs     defaults,nofail         0 0" >> /etc/fstab
echo "192.168.8.22:/Storage/Entretenimento2   /mnt/Entretenimento2    nfs     defaults,nofail         0 0" >> /etc/fstab
echo "192.168.8.25:/Storage/Entretenimento3   /mnt/Entretenimento3    nfs     defaults,nofail         0 0" >> /etc/fstab
echo "192.168.8.39:/Storage/Entretenimento4   /mnt/Entretenimento4    nfs     defaults,nofail         0 0" >> /etc/fstab
echo "192.168.8.200:/mnt/RRender              /mnt/RRender            nfs     defaults,nofail         0 0" >> /etc/fstab
echo "192.168.8.19:/Storage/RAW1              /mnt/RAW1               nfs     defaults,nofail         0 0" >> /etc/fstab
echo "192.168.8.32:/Storage/RAW2              /mnt/RAW2               nfs     defaults,nofail         0 0" >> /etc/fstab
echo "192.168.8.38:/Storage/RAW3              /mnt/RAW3               nfs     defaults,nofail         0 0" >> /etc/fstab
echo "192.168.8.81:/mnt/storage/RAW4          /mnt/RAW4               nfs     defaults,nofail         0 0" >> /etc/fstab
echo "192.168.8.86:/Storage/RAWADV            /mnt/RAWADV             nfs     defaults,nofail         0 0" >> /etc/fstab
echo "192.168.8.48:/Storage/Library2          /mnt/Library2           nfs     defaults,nofail         0 0" >> /etc/fstab
echo "192.168.8.7:/Storage/install            /mnt/install            nfs     defaults,nofail         0 0" >> /etc/fstab
mount -a
fi


###########  Criar link simbolico do MNT para Volume #################
echo "Link /Volume =>> /mnt"
ln -s /mnt /Volumes

################### Instala Copilador de Pacotes SNAP ################
if [ ! -d "$SNAPD" ]; then
yum -y install snapd
systemctl enable --now snapd.socket
ln -s /var/lib/snapd/snap /snap
fi

# Instala o drive Atualizado da NVIDIA 
if [ ! -d "$NVINSTALLEDDIR" ]; then
grubby --update-kernel=ALL   --args="rd.driver.blacklist=nouveau nouveau.modeset=0"
cp -f $SOURCEDIR/NVIDIA.run $INSTALLDIR/NVIDIA.run
cd $INSTALLDIR
chmod 777 NVIDIA.run
cp -f $SOURCEDIR/nvinstall.service $INSTALLDIR/nvinstall.service
chmod 777 nvinstall.service
cp -f $INSTALLDIR/nvinstall.service /etc/systemd/system/nvinstall.service
/bin/systemctl enable nvinstall.service

###### change Default Desktop #######
sed -i 's/XSession=gnome/XSession=kde/g' /var/lib/AccountsService/users/$USERNAME
reboot
fi

#############   Config LDAP  ###############
if [ ! -e "$LDAPFILE" ]; then

#######  nss-pam-ldap nscd  #########
echo "#######  Instalando nss-pam-ldap nscd  #########"  
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
mkdir $INSTALLDIR/ldap/
chmod 777 $INSTALLDIR/ldap/ 
cp -f -p -R $SOURCEDIR/ldap $INSTALLDIR/
cd $INSTALLDIR/ldap
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

#####################  yum INSTALL ####################


#######  Pulse Audio / PAVU Control  #########
if [ "$PAUDIO" != "pulseaudio" ]; then 
 echo "#######  Instalando Pulse Audio e Pavu Control #########" ##### 
 yum -y install pulseaudio pavucontrol
fi

####### Cockpit #############
echo "Install Cockpit"
yum -y install cockpit
systemctl enable --now cockpit.socket
firewall-cmd --permanent --zone=public --add-service=cockpit
firewall-cmd --reload
echo " Cockpit instalado com sucesso"

#######  GBDM  #########
if [ ! -e "$LIBGBDM"  ]; then
 echo "#######  Instalando GBDM  #########" ##### 
 yum -y -q install gdbm-devel
fi
 
 ############   Vlc  ###############
if [ ! -e "$VLC" ]; then
 echo "#######  Instalando VLC  #########" #####
 yum -y install http://repo.okay.com.mx/centos/7/x86_64/release/okay-release-1-1.noarch.rpm
 yum -y install vlc
fi

#######  NTFS3G  #########
if [ ! -e "$NTFS3G" ]; then
yum -y install cinnamon gcc unzip wget mesa-libGL mesa-libGL-devel ntfs-3g.x86_64 nss dkms git dnf snapd vim ansible libselinux-python smplayer ffmpeg HandBrake-{gui,cli} libdvdcss gstreamer{,1}-plugins-ugly gstreamer-plugins-bad-nonfree gstreamer1-plugins-bad-freeworld
fi

######  EXFAT  #########

yum install -y -q http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm
yum install -y -q exfat-utils fuse-exfat

#############   cinnamon  ###############
CINNAMONVRSINST=` ( cinnamon --version ) `
CINNAMONVRSNEW="Cinnamon 3.6.7"
rm -rf /tmp/cinnamon.txt
echo $CINNAMONVRSINST >> /tmp/cinnamon.txt
CINNAMON=` (  grep -o '^[^[:space:]]\+' /tmp/cinnamon.txt ) `

if [ "$CINNAMONVRSINST" != "$CINNAMONVRSNEW" ]; then
 echo "#######  Atualizando Cinnamon  #########" ##### 
 yum -y -q update cinnamon
fi

#######  Pulse Audio / PAVU Control  #########
if [ "$PAUDIOVRSINST" != "$PAUDIOVRSNEW" ]; then
 echo "#######  Atualizando Pulse Audio e Pavu Control #########" ##### 
 yum -y -q update pulseaudio pavucontrol
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

###########   Pauta  ###############
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
cp -f $SOURCEDIR/slack-4.2.0-0.1.fc21.x86_64.rpm $INSTALLDIR/slack-4.2.0-0.1.fc21.x86_64.rpm
cd $INSTALLDIR
chmod 777 slack-4.2.0-0.1.fc21.x86_64.rpm
rpm -Uvh --replacefiles slack-4.2.0-0.1.fc21.x86_64.rpm
fi

############   krita  ###############
{
if [ ! -e "$KRITA" ]; then
 echo "#######  Instalando Krita  #########" ##### 
yum -y install calligra-krita.x86_64
fi
}

############   NUKE 10.5  ###############
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

#############   Resolve 16.1.2  ###############
{
if [ ! -e "$RESOLVEDIR" ]; then
echo "#######  Instalando Resolve 16.1.2  #########" ##### 
cp -f $SOURCEDIR/DaVinci_Resolve_16.1.2_Linux.run $INSTALLDIR/DaVinci_Resolve_16.1.2_Linux.run
cd $INSTALLDIR
chmod 777 DaVinci_Resolve_16.1.2_Linux.run
sudo -u $USERNAME  -H sh -c "./DaVinci_Resolve_16.1.2_Linux.run -i -y"
fi
}

############   Fusion 16.1.1  ###############
if [ ! -d "$FUSION16DIR" ]; then
echo "#######  Instalando Fusion 16.1.1  #########" ##### 
cp -f $SOURCEDIR/Blackmagic_Fusion_Studio_16.1.1_Linux.tar $INSTALLDIR/Blackmagic_Fusion_Studio_16.1.1_Linux.tar
cd $INSTALLDIR
tar -xvf $INSTALLDIR/Blackmagic_Fusion_Studio_16.1.1_Linux.tar
chmod 777 Blackmagic_Fusion_Studio_Linux_16.1.1_installer.run
chmod 777 Blackmagic_Fusion_Render_Node_Linux_16.1.1_installer.run
./Blackmagic_Fusion_Studio_Linux_16.1.1_installer.run -i -y
./Blackmagic_Fusion_Render_Node_Linux_16.1.1_installer.run -i -y
fi

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
cp -f $SOURCEDIR/desktopvideo-11.4a14.x86_64.rpm $INSTALLDIR/desktopvideo-11.4a14.x86_64.rpm
cp -f $SOURCEDIR/desktopvideo-gui-11.4a14.x86_64.rpm $INSTALLDIR/desktopvideo-gui-11.4a14.x86_64.rpm
cp -f $SOURCEDIR/desktopvideo-scanner-11.4a14.x86_64.rpm $INSTALLDIR/desktopvideo-scanner-11.4a14.x86_64.rpm
cp -f $SOURCEDIR/mediaexpress-3.6a13.x86_64.rpm $INSTALLDIR/mediaexpress-3.6a13.x86_64.rpm
cd $INSTALLDIR
chmod 777 desktopvideo-11.4a14.x86_64.rpm
chmod 777 desktopvideo-gui-11.4a14.x86_64.rpm
chmod 777 desktopvideo-scanner-11.4a14.x86_64.rpm
chmod 777 mediaexpress-3.6a13.x86_64.rpm
rpm -Uvh --replacefiles desktopvideo-11.4a14.x86_64.rpm
rpm -Uvh --replacefiles desktopvideo-gui-11.4a14.x86_64.rpm
rpm -Uvh --replacefiles desktopvideo-scanner-11.4a14.x86_64.rpm
rpm -Uvh --replacefiles mediaexpress-3.6a13.x86_64.rpm
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
echo "#######  Instalando Vray Next for MAYA 17  #########" ##### 
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

###################### HOUDINI 17.5.460 ########################

if [ ! -d "$HOUDINIDIR" ]; then
echo "#######  Instalando houdini-17.5.460  #########" ##### 
cp -f $SOURCEDIR/houdini-17.5.460-linux_x86_64_gcc6.3.tar.gz $INSTALLDIR/houdini-17.5.460-linux_x86_64_gcc6.3.tar.gz
cd $INSTALLDIR
tar -xvf $INSTALLDIR/houdini-17.5.460-linux_x86_64_gcc6.3.tar.gz
chmod -R 777 houdini-17.5.460-linux_x86_64_gcc6.3
cd houdini-17.5.460-linux_x86_64_gcc6.3
./houdini.install --make-dir --install-houdini --auto-install --accept-EULA 
rm -rf /home/$USERNAME/.sesi_licenses.pref
echo "serverhost=192.168.8.63" >> /home/$USERNAME/.sesi_licenses.pref
/opt/hfs17.5/bin/hserver -S 192.168.8.63
fi

############### HP RGS Sender ###############
RGSS="/opt/hpremote/rgsender/"

if [ ! -d "$RGSS" ]; then
echo "#######  Instalando RGS 7.7.0  #########" ##### 
cp -f $SOURCEDIR/rgsender_linux_64-7.6.1.19438-1.el7.x86_64.rpm $INSTALLDIR/rgsender_linux_64-7.6.1.19438-1.el7.x86_64.rpm
cp -f $SOURCEDIR/rgsender_config_64-7.6.1.19438-1.x86_64.rpm $INSTALLDIR/rgsender_config_64-7.6.1.19438-1.x86_64.rpm
cp -f $SOURCEDIR/libxcb-damage0-1.11.1-9.1.x86_64.rpm $INSTALLDIR/libxcb-damage0-1.11.1-9.1.x86_64.rpm
cd $INSTALLDIR
   rpm -ivh rgsender_linux_64-7.6.1.19438-1.el7.x86_64.rpm --force --replacefiles --nodeps
   rpm -ivh rgsender_config_64-7.6.1.19438-1.x86_64.rpm --force --replacefiles --nodeps
   rpm -Uvh libxcb-damage0-1.11.1-9.1.x86_64.rpm --force --replacefiles --nodeps
   rgsFlexServer="27000@192.168.10.19"
   if [ -f /etc/opt/hpremote/rgsender/.rgslm ] ; then
   rm -f /etc/opt/hpremote/rgsender/.rgslm
   fi
   echo -n "export LM_LICENSE_FILE="$rgsFlexServer>/etc/opt/hpremote/rgsender/.rgslm
   echo "">>/etc/opt/hpremote/rgsender/.rgslm
   chmod 600 /etc/opt/hpremote/rgsender/.rgslm
   echo    "RGS Installation complete - please restart your X server to access"
   sh /opt/hpremote/rgsender/rgsender.sh
cat  $SOURCEDIR/trial.lic >> /etc/opt/hpremote/rgsender/trial.lic
fi

###################Spotify###################
SPOTIFY2=` ( spotify --version ) `
if [ "$SPOTIFY" != "$SPOTIFY2" ]; then
snap install spotify
fi

########## Disabling Gnome Auto Login ##########
mv -f /etc/gdm/custom.bkp /etc/gdm/custom.conf

########## Removing user from sudores ##########
 mv -f /etc/sudores.bkp /etc/sudores

########## Removing root permissions form user ##########
 gpasswd -d $USERNAME wheel

########## Removing Install Dir  ##########
rm -rf $INSTALLDIR

    dialog --stdout --msgbox "A Instalacao e configuracao foram executadas com sucesso" 0 0

    else

dialog --stdout --msgbox "Você precisa ser ROOT para executar esse script!" 0 0
dialog --stdout --msgbox "Maquina não teve alterações" 0 0

fi


dialog --msgbox "Sua configuração iniciar foi concluida \nAcesse este dispositivo através do endereço \nhttps://$VARIPADDRESS:9090  \nusando o usuário de logado desta sessão do shell" 0 0
