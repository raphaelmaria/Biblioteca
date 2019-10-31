#!/bin/sh
# Install Time Machine service on CentOS 7
# fonte: https://gist.github.com/darcyliu/f3db52d6d60ef4f4f4ef
# http://netatalk.sourceforge.net/wiki/index.php/Netatalk_3.1.7_SRPM_for_Fedora_and_CentOS
# http://confoundedtech.blogspot.com/2011/07/draft-draft-ubuntu-as-apple-time.html

yum install -y rpm-build gcc make wget
yum install -y avahi-devel cracklib-devel dbus-devel dbus-glib-devel libacl-devel libattr-devel libdb-devel libevent-devel libgcrypt-devel krb5-devel mysql-devel openldap-devel openssl-devel pam-devel quota-devel systemtap-sdt-devel tcp_wrappers-devel libtdb-devel tracker-devel


wget http://192.168.8.7/linux/Softwares/server/netatalk-3.1.12.zip
yum install unzip -y
chmod 777 netatalk-3.1.12.zip
unzip netatalk-3.1.12.zip
rm -rf "__MACOSX"
cd netatalk-3.1.12
./configure
make install




yum install netatalk -y

mv /etc/netatalk/afp.conf /etc/netatalk/afp.conf.bkp
touch /etc/netatalk/afp.conf

echo "[Global]

log file = /var/log/afpd.log
log level = default:error
uam list = uams_dhx.so,uams_dhx2.so
afpstats = yes
mimic model = RackMac
map acls = mode

[Dados]

path = /mnt/storage/dados
valid users = acesso 
file perm = 0664
directory perm = 2775" >> /etc/netatalk/afp.conf

firewall-cmd --zone=public --permanent --add-port=548/tcp
firewall-cmd --zone=public --permanent --add-port=548/udp
firewall-cmd --zone=public --permanent --add-port=5353/tcp
firewall-cmd --zone=public --permanent --add-port=5353/udp
firewall-cmd --zone=public --permanent --add-port=49152/tcp
firewall-cmd --zone=public --permanent --add-port=49152/udp
firewall-cmd --zone=public --permanent --add-port=52883/tcp
firewall-cmd --zone=public --permanent --add-port=52883/udp
firewall-cmd --reload

systemctl enable avahi-daemon
systemctl enable netatalk
systemctl start avahi-daemon
systemctl start netatalk