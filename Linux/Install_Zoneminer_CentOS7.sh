#Configuração do BigBrother

# Sistema operacional: CentOS 7

# Update
apt-get -y update

# Instalação Basica
apt-get -y install gcc unzip wget mesa-libGL mesa-libGL-devel ntfs-3g.x86_64 nss dkms git dnf snapd vim ansible libselinux-python vlc smplayer ffmpeg HandBrake-{gui,cli} libdvdcss gstreamer{,1}-plugins-ugly gstreamer-plugins-bad-nonfree gstreamer1-plugins-bad-freeworld
apt-get -y install wget nss dkms git dnf snapd vim ansible libselinux-python nfs-utils tcsh libXext libSM libXrender Xvfb xorg-x11-server-Xorg xorg-x11-xauth xorg-x11-apps
apt-get -y install freeipa-client
apt-get -y groupinstall "X Window System"
apt-get -y groupinstall "Fonts"
export FONTCONFIG_PATH=/etc/fonts
su -c 'rpm -Uvh https://download.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm'
su -c 'apt-get install foo'

# Configuração de CentOS
package-cleanup --oldkernels --count=2
hostnamectl set-hostname bigbrother.o2pos.com.br

nmcli connection modify eno2 ipv4.method manual ipv4.addresses 192.168.8.24 ipv4.gateway 192.168.8.1 ipv4.dns 192.168.8.100,192.168.8.110 ipv4.dns-search o2pos.com.br
nmcli connection up eno2

apt-get -y install cockpit
systemctl enable --now cockpit.socket
firewall-cmd --permanent --zone=public --add-service=cockpit
firewall-cmd --reload

su - -c "apt-get install perl-version"
su - -c "apt-get --enablerepo=updates install libxcb libxcb-devel xcb-util xcb-util-devel xcb-util-*-devel libX11-devel libXrender-devel libxkbcommon-devel libXi-devel"

mv /etc/resolv.conf /etc/resolv.conf.old
echo "search o2pos.com.br
nameserver 192.168.8.100
nameserver 192.168.8.110" >> /etc/resolv.conf

rpm -ivh http://repo.zabbix.com/zabbix/2.4/rhel/6/x86_64/zabbix-release-2.4-1.el6.noarch.rpm
apt-get -y install zabbix-agent.x86_64
service zabbix-agent stop
sed -i 's/^Server=127.0.0.1/Server=192.168.8.4/' /etc/zabbix/zabbix_agentd.conf
sed -i 's/^Hostname=Zabbix server/Hostname=BigBrother/' /etc/zabbix/zabbix_agentd.conf
chkconfig zabbix on
chkconfig zabbix-agent on
mkdir /var/run/zabbix
chown zabbix.zabbix /var/run/zabbix/
zabbix_agentd -c /etc/zabbix/zabbix_agentd.conf
service zabbix-agent start
systemctl enable zabbix-agent
firewall-cmd --add-service=zabbix-agent
firewall-cmd --add-service=zabbix-agent  --permanent
service zabbix-agent restart

# Restaurando um RAID presente na maquina com 3 discos
mkdir -p /mnt/storage
echo "/dev/md127 /mnt/storage xfs defaults 0 0" >> /etc/fstab
chmod -R 777 /mnt/storage
mount -a
df -h


# Instalação do ZoneMinder Security System Cam
apt-get install rpm-build
apt-get install redhat-rpm-config
apt-get localinstall --nogpgcheck https://download1.rpmfusion.org/free/el/rpmfusion-free-release-7.noarch.rpm https://download1.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-7.noarch.rpm -y
dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin -y
dnf install rpmfusion-free-release-tainted -y
dnf install libdvdcss -y
dnf install zoneminder-httpd


dnf install mariadb-server
systemctl enable mariadb
systemctl start  mariadb.service
mysql_secure_installation

# Mysql configuration
mysql -uroot -p < /usr/share/zoneminder/db/zm_create.sql
mysql -uroot -p -e "grant all on zm.* to \
                        'zmuser'@localhost identified by 'zmpass';"
mysqladmin -uroot -p reload
mysql -uroot -p -e "show grants for zmuser@localhost;"

# zmuser/zmpass
/etc/zm/conf.d
echo" ZM_DB_USER = zmuser
ZM_DB_PASS = zmpass" >> /etc/zm/conf.d/zm-db-user.conf
# ZM_DB_USER = {username of the sql account you want to use}
# ZM_DB_PASS = {password of the sql account you want to use}

chown root:apache /etc/zm/conf.d/*.conf
chmod 640 /etc/zm/conf.d/*.conf 


Colocar a Time Zone date.timezone= "America/Sao_Paulo" no arquivo /etc/php.ini >> http://php.net/date.timezone

cat /etc/zm/www/zoneminder.httpd.conf
ln -sf /etc/zm/www/zoneminder.httpd.conf /etc/httpd/conf.d/
dnf install mod_ssl
systemctl enable httpd
systemctl start httpd
systemctl enable zoneminder
systemctl start zoneminder
firewall-cmd --permanent --zone=public --add-service=http
firewall-cmd --permanent --zone=public --add-service=https
firewall-cmd --permanent --zone=public --add-port=3702/udp
firewall-cmd --reload
