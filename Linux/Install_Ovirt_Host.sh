# Como instalar o Ovirt Host em uma maquina normal
# Instalar o CentOS 7 em versão "Minimal" sem interface de video, somente em modo terminal.
# Rode os comandos na mesma ordem e adaptando a essa necessidade.

hostnamectl set-hostname o2node1.o2pos.com.br
yum upgrade -y
yum update -y
yum install gcc wget nss dkms git dnf snapd vim ansible libselinux-python nfs-utils tcsh libXext libSM libXrender Xvfb xorg-x11-server-Xorg xorg-x11-xauth xorg-x11-apps unzip mesa-libGL mesa-libGL-devel ntfs-3g.x86_64 nss dkms git dnf snapd vim ansible libselinux-python vlc smplayer ffmpeg HandBrake-{gui,cli} libdvdcss gstreamer{,1}-plugins-ugly gstreamer-plugins-bad-nonfree gstreamer1-plugins-bad-freeworld -y
yum install bash-completion -y 
yum -y groupinstall "X Window System"
yum -y groupinstall "Fonts"
yum -y install ipa-client chrony
yum -y install http://resources.ovirt.org/pub/yum-repo/ovirt-release43.rpm
yum clean all && yum update -y
export FONTCONFIG_PATH=/etc/fonts
#su - -c "yum install perl-version"
#su - -c "yum --enablerepo=updates install libxcb libxcb-devel xcb-util xcb-util-devel xcb-util-*-devel libX11-devel libXrender-devel libxkbcommon-devel libXi-devel"
yum -y install cockpit
systemctl enable --now cockpit.socket
firewall-cmd --permanent --zone=public --add-service=cockpit
firewall-cmd --reload

reboot

nmcli con show
nmcli connection modify ens3f1 ipv4.method manual ipv4.address 192.168.9.1/16 ipv4.dns 192.168.8.100,192.168.8.110 ipv4.dns-search o2pos.com.br ipv4.gateway 192.168.8.1
nmcli connection up ens3f1 

reboot

# Verificar o DNS no resolve.conf se o DNS esta no 8.100 e 8.110
# yum -y install ipa-client chrony
# vim /etc/chrony.conf
#    server ipa.o2pos.com.br iburst
#    server ipa2.o2pos.com.br iburst
#    server pool.ntp.br iburst

# systemctl enable --now chronyd
# Verificar horário
# timedatectl
# O horario em UTC tem deve está igual ao meridiano 0

# yum -y install http://resources.ovirt.org/pub/yum-repo/ovirt-release43.rpm
# yum clean all && yum update -y
# yum install -y vdsm-gluster

ipa-client-install --mkhomedir --no-ntp --force-join
# yes
# admin
# senha de admin do IPA no 1password


