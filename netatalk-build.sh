#!/bin/bash

# Enable extended attributes on filesystem
# http://netatalk.sourceforge.net/wiki/index.php/Install_Netatalk_3.1.11_on_Ubuntu_18.04_Bionic

#add repository directory
echo "deb http://deb.debian.org/debian/ unstable main contrib non-free" >> /etc/apt/source.list
echo "deb-src http://deb.debian.org/debian/ unstable main contrib non-free" >> /etc/apt/source.list

# Get system to updated state and install required packages
apt update
apt full-upgrade -y
apt install -y build-essential libevent-dev libssl-dev libgcrypt-dev libkrb5-dev libpam0g-dev libwrap0-dev libdb-dev libtdb-dev libmysqlclient-dev avahi-daemon libavahi-client-dev libacl1-dev libldap2-dev libcrack2-dev systemtap-sdt-dev libdbus-1-dev libdbus-glib-1-dev libglib2.0-dev libio-socket-inet6-perl tracker libtracker-sparql-2.0-dev libtracker-miner-2.0-dev 

# Get code
cd ~
wget https://iweb.dl.sourceforge.net/project/netatalk/netatalk/3.1.11/netatalk-3.1.11.tar.bz2
tar xf netatalk-3.1.11.tar.bz2 && rm netatalk-3.1.11.tar.bz2
cd netatalk-3.1.11

# Build and install
./configure \
	--with-init-style=debian-systemd \
	--without-libevent \
	--without-tdb \
	--with-cracklib \
	--enable-krbV-uam \
	--with-pam-confdir=/etc/pam.d \
	--with-dbus-daemon=/usr/bin/dbus-daemon \
	--with-dbus-sysconf-dir=/etc/dbus-1/system.d \
	--with-tracker-pkgconfig-version=2.0
make -j $(grep -c ^processor /proc/cpuinfo)
# sudo make install # maybe unnecessary

# Add to /usr/local/etc/afp.conf (uncomment+add)
# [Global]
# appledouble = ea
#
# [Homes]
# basedir regex = /home

# Enable and start
systemctl enable netatalk
systemctl start netatalk

fdisk /dev/sdc -g -n -w
fdisk /dev/sdd -g -n -w
fdisk /dev/sde

mdadm -C /dev/md0 --level=raid0 --raid-devices=3 /dev/sdc1 /dev/sdd1 /dev/sde1
mkdir /mnt/raid0
chmod -R 777 /mnt/raid0
mkfs.ext4 /dev/md0
echo "/dev/md0 		/mnt/raid0 		ext4 		defaults 	0 0" >> /etc/fstab
mount -a
chmod -R 777 /mnt/raid0