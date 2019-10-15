#!/bin/bash
# Script para configuração Inicial de Servidores
# Criado por Raphael Maria
# Versão 1.0

### VARIAVEIS
IPADDRESS= '()'
HOSTNAME = '()'
INTERFACE = '(nmcli con show | awk 1git)'

# Atualização de OS
yum check-update
yum update -y
#Instalação ansible
yum -y install wget nss dkms git dnf snapd vim ansible libselinux-python nfs-utils tcsh libXext libSM libXrender Xvfb xorg-x11-server-Xorg xorg-x11-xauth xorg-x11-apps
yum -y groupinstall "X Window System"
yum -y groupinstall "Fonts"
export FONTCONFIG_PATH=/etc/fonts

# Instalar Python 3
yum install centos-release-scl
yum install rh-python36
scl enable rh-python36 bash


su - -c "yum install perl-version"
su - -c "yum --enablerepo=updates install libxcb libxcb-devel xcb-util xcb-util-devel xcb-util-*-devel libX11-devel libXrender-devel libxkbcommon-devel libXi-devel"

hostnamectl set-hostname bigbrother

# Install Cockpit
yum -y install cockpit
systemctl enable --now cockpit.socket
firewall-cmd --permanent --zone=public --add-service=cockpit
firewall-cmd --reload
echo " Cockpit instalado com sucesso" /
echo " Abra um navegador e digite https://<IP da maquina>:9090" /

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

#Acertos
echo "O servidor é 192.168.8.63"
/opt/hfs17.0/bin/hkey
rm -rf /usr/local/foundry/RLM
rm -rf 

mount -a
df -h

# Instalando VNC SERVER 
yum -y install tigervnc-server xorg-x11-fonts-Type1
cp /lib/systemd/system/vncserver@.service /etc/systemd/system/vncserver@:3.service
echo "Insira a senha para acesso"
vncserver

#Instalação Zabbix
rpm -ivh http://repo.zabbix.com/zabbix/2.4/rhel/6/x86_64/zabbix-release-2.4-1.el6.noarch.rpm
yum -y install zabbix-agent.x86_64
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
exit


#sed -i 's/^Domain = localdomain/Domain = o2pos.com/' /etc/idmapd.conf

ipa-client-install --mkhomedir --no-ntp --force-join
ipa-client-install --mkhomedir --force --fixed-primary

/etc/init.d/rrAutostart restart


### Configuracao de rede do CentOS / Fedora
nmcli con show
nmcli connection modify eno2 ipv4.method manual ipv4.addresses 192.168.8.24/16 ipv4.gateway 192.168.8.1 ipv4.dns 192.168.8.15,192.168.8.16 ipv4.dns-search o2pos.com
nmcli connection up eno2

sed -i 's/^IPADDR=x.x.x.x/IPADDR=$ipaddress' /etc/sysconfig/network-scripts/$interface
sed -i 's/^Domain = localdomain/Domain = o2pos.com/' /etc/idmapd.conf

reboot

/opt/hfs17.0/bin/hkey
/opt/hfs17.5/bin/hkey

rpm -ivh [pacote]


# Instanado o Royal Render
echo "Configuração terminada com sucesso"



# Desativar o Firewall completo (para LIC SRV Houdini
systemctl stop firewall
systemctl disable firewall

# Desativar firewallD ou configurar portas
systemctl start firewalld
firewall-cmd --get-default-zone
firewall-cmd --set-default-zone=public
firewall-cmd --permanent --add-port=5432/tcp
firewall-cmd --permanent --add-port=5432/tcp
firewall-cmd --reload
firewall-cmd --list-all



print('Entre com o nome do usuário')
$user=
su $user
echo "HOUDINI_DSO_ERROR = 2
PATH = "/usr/redshift/bin:$PATH"
HOUDINI_PATH = "/usr/redshift/redshift4houdini/17.0.416;&

HOUDINI_DSO_ERROR = 2
PATH = "/usr/redshift/bin:$PATH"
HOUDINI_PATH = "/usr/redshift/redshift4houdini/17.0.459;&

HOUDINI_DSO_ERROR = 2
PATH = "/usr/redshift/bin:$PATH"
HOUDINI_PATH = "/usr/redshift/redshift4houdini/17.5.173;& " >> /home/$user/houdini17.0/houdini.env