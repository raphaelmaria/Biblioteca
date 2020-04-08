# Como instalar o Ovirt Host em uma maquina normal
# Instalar o CentOS 7 em versão "Minimal" sem interface de video, somente em modo terminal.
# Rode os comandos na mesma ordem e adaptando a essa necessidade.

hostnamectl set-hostname o2box01.o2pos.com.br
apt-get upgrade -y
apt-get update -y
apt-get install gcc wget nss dkms git dnf snapd vim ansible libselinux-python nfs-utils tcsh libXext libSM libXrender Xvfb xorg-x11-server-Xorg xorg-x11-xauth xorg-x11-apps unzip mesa-libGL mesa-libGL-devel ntfs-3g.x86_64 nss dkms git dnf snapd vim ansible libselinux-python vlc smplayer ffmpeg HandBrake-{gui,cli} libdvdcss gstreamer{,1}-plugins-ugly gstreamer-plugins-bad-nonfree gstreamer1-plugins-bad-freeworld -y
apt-get install bash-completion -y 
apt-get -y groupinstall "X Window System"
apt-get -y groupinstall "Fonts"
apt-get -y install ipa-client chrony
apt-get -y install http://resources.ovirt.org/pub/apt-get-repo/ovirt-release43.rpm
apt-get clean all && apt-get update -y
export FONTCONFIG_PATH=/etc/fonts
#su - -c "apt-get install perl-version"
#su - -c "apt-get --enablerepo=updates install libxcb libxcb-devel xcb-util xcb-util-devel xcb-util-*-devel libX11-devel libXrender-devel libxkbcommon-devel libXi-devel"
apt-get -y install cockpit
systemctl enable --now cockpit.socket
firewall-cmd --permanent --zone=public --add-service=cockpit
firewall-cmd --reload
apt-get remove cloud-init -y

reboot

nmcli con show
nmcli connection modify ens1f0np0 ipv4.method manual ipv4.address 192.168.8.119/16 ipv4.dns 192.168.8.100,192.168.8.110 ipv4.dns-search o2pos.com.br ipv4.gateway 192.168.8.1
nmcli connection up ens1f0np0 

reboot

# Verificar o DNS no resolve.conf se o DNS esta no 8.100 e 8.110
# apt-get -y install ipa-client chrony
# vim /etc/chrony.conf
#    server ipa.o2pos.com.br iburst
#    server ipa2.o2pos.com.br iburst
#    server pool.ntp.br iburst

# systemctl enable --now chronyd
# Verificar horário
# timedatectl
# O horario em UTC tem deve está igual ao meridiano 0

# apt-get -y install http://resources.ovirt.org/pub/apt-get-repo/ovirt-release43.rpm
# apt-get clean all && apt-get update -y
# apt-get install -y vdsm-gluster

ipa-client-install --mkhomedir --no-ntp --force-join
# yes
# admin
# senha de admin do IPA no 1password


