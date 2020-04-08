#!/bin/bash
# For Installation Script Render Farm VM

#Instalação de pacotes
apt-get -y update
apt-get -y install ntfs-3g.x86_64  nss dkms git dnf snapd vim ansible libselinux-python vlc smplayer ffmpeg HandBrake-{gui,cli} libdvdcss gstreamer{,1}-plugins-ugly gstreamer-plugins-bad-nonfree gstreamer1-plugins-bad-freeworld wget nss dkms git dnf snapd vim ansible libselinux-python nfs-utils tcsh libXext libSM libXrender Xvfb xorg-x11-server-Xorg xorg-x11-xauth xorg-x11-apps nss-pam-ldapd nscd
su - -c "apt-get install perl-version"
su - -c "apt-get --enablerepo=updates install libxcb libxcb-devel xcb-util xcb-util-devel xcb-util-*-devel libX11-devel libXrender-devel libxkbcommon-devel libXi-devel"


apt-get -y groupinstall "X Window System"
apt-get -y groupinstall "Fonts"
export FONTCONFIG_PATH=/etc/fonts

# Install Cockpit
apt-get -y install cockpit
systemctl enable --now cockpit.socket
firewall-cmd --permanent --zone=public --add-service=cockpit
firewall-cmd --reload

# Install Python 2.7
apt-get -y install gcc openssl-devel bzip2-devel 
cd /usr/src
wget https://www.python.org/ftp/python/2.7.16/Python-2.7.16.tgz
tar xzf Python-2.7.16.tgz
cd Python-2.7.16
./configure --enable-optimizations
make altinstall
curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"
python2.7 get-pip.py

# Install LDAP
authconfig-tui
scp -r raphaelmaria@192.168.8.84:/Volumes/3TB/scripts/ldap /root/Downloads
mkdir /root/Downloads/ldap/bkps

mkdir -p /root/Downloads/ldap/bkps
# arquivo /etc/nslcd.conf
mv /etc/nslcd.conf /root/Downloads/ldap/bkps
cp /root/Downloads/ldap/nslcd.conf /etc

# /etc/openldap/ldap.conf
mv /etc/openldap/ldap.conf /root/Downloads/ldap/bkps
cp /root/Downloads/ldap/ldap.conf /etc/openldap

# /etc/nsswitch.conf
mv /etc/nsswitch.conf /root/Downloads/ldap/bkps
cp /root/Downloads/ldap/nsswitch.conf /etc

# /etc/pam.d/password-auth-ac
mv /etc/pam.d/password-auth-ac /root/Downloads/ldap/bkps
cp /root/Downloads/ldap/password-auth-ac /etc/pam.d

# /etc/pam.d/system-auth-ac
mv /etc/pam.d/system-auth-ac /root/Downloads/ldap/bkps
cp /root/Downloads/ldap/system-auth-ac /etc/pam.d

#Instalação Zabbix
rpm -ivh http://repo.zabbix.com/zabbix/2.4/rhel/6/x86_64/zabbix-release-2.4-1.el6.noarch.rpm
apt-get -y install zabbix-agent.x86_64
service zabbix-agent stop
sed -i 's/^Server=127.0.0.1/Server=192.168.8.4/' /etc/zabbix/zabbix_agentd.conf
sed -i 's/^Hostname=Zabbix server/Hostname=Athena/' /etc/zabbix/zabbix_agentd.conf
chkconfig zabbix on
chkconfig zabbix-agent on
mkdir /var/run/zabbix
chown zabbix.zabbix /var/run/zabbix/
zabbix_agentd -c /etc/zabbix/zabbix_agentd.conf
service zabbix-agent start
systemctl enable zabbix-agent

sed -i 's/^Domain = localdomain/Domain = o2pos.com/' /etc/idmapd.conf

# Montagem de servidores
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
mkdir /mnt/oldhome
chmod 777 /mnt/oldhome


echo "# Servidor Royal Render" >> /etc/fstab
echo "192.168.8.200:/mnt/RRender /mnt/RRender nfs defaults 0 0" >> /etc/fstab

echo "# Diretorios de servidores" >> /etc/fstab
echo "192.168.8.2:/Storage/Library            /mnt/Library            nfs     defaults        0 0" >> /etc/fstab
echo "192.168.8.48:/Storage/Library2          /mnt/Library2           nfs     defaults        0 0" >> /etc/fstab
echo "192.168.8.19:/Storage/RAW1              /mnt/RAW1               nfs     defaults        0 0" >> /etc/fstab
echo "192.168.8.32:/Storage/RAW2              /mnt/RAW2               nfs     defaults        0 0" >> /etc/fstab
echo "192.168.8.38:/Storage/RAW3              /mnt/RAW3               nfs     defaults        0 0" >> /etc/fstab
echo "192.168.8.86:/Storage/RAWADV            /mnt/RAWADV             nfs     defaults        0 0" >> /etc/fstab
echo "192.168.8.14:/Storage/Publicidade       /mnt/Publicidade        nfs     defaults        0 0" >> /etc/fstab
echo "192.168.8.31:/Storage/Entretenimento    /mnt/Entretenimento     nfs     defaults        0 0" >> /etc/fstab
echo "192.168.8.22:/Storage/Entretenimento2   /mnt/Entretenimento2    nfs     defaults        0 0" >> /etc/fstab
echo "192.168.8.25:/Storage/Entretenimento3   /mnt/Entretenimento3    nfs     defaults        0 0" >> /etc/fstab
echo "192.168.8.39:/Storage/Entretenimento4   /mnt/Entretenimento4    nfs     defaults        0 0" >> /etc/fstab

echo "# Servidores auxiliares" >> /etc/fstab
echo "#192.168.8.33:/opt                       /opt                    nfs     defaults        0 0" >> /etc/fstab
echo "192.168.8.2:/Storage/Onix               /mnt/Onix               nfs     defaults        0 0" >> /etc/fstab
echo "#192.168.8.7:/Storage/Install            /mnt/Install            nfs     defaults        0 0" >> /etc/fstab
echo "#192.168.8.11:/Storage/Homes             /mnt/oldhome                   nfs     defaults        0 0" >> /etc/fstab