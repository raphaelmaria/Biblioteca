apt update -y && apt install gcc wget dkms git snapd vim ansible chrony -y
apt upgrade -y
apt install network-manager -y
hostnamectl set-hostname camstorage.o2pos.com.br
export PATH="$PATH:/sbin"
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

nmcli connection modify "Wired connection 1" ipv4.method manual ipv4.address 192.168.8.195/16 ipv4.dns 192.168.8.100,192.168.8.110 ipv4.dns-search o2pos.com.br ipv4.gateway 192.168.8.1
nmcli connection up "Wired connection 1"

vim /etc/chrony/chrony.conf




sudo apt install bind9utils certmonger freeipa-common libnss3-tools libnss-sss libpam-sss libsss-sudo libxmlrpc-core-c3 oddjob-mkhomedir python-dnspython python-ipaclient python-ldap python-sss sssd libbasicobjects0 libcollection4 libcom-err2 libini-config5 libnspr4 libnss3 libref-array1 libsasl2-2 -y
wget http://ftp.br.debian.org/debian/pool/main/f/freeipa/freeipa-client_4.7.2-3_amd64.deb
chmod 777 freeipa-client_4.7.2-3_amd64.deb
dpkg -i freeipa-client_4.7.2-3_amd64.deb
sed -i 's/^PATH="/usr/local/bin:/usr/bin:/bin:/usr/games" PATH="/usr/local/bin:/usr/bin:/bin:/usr/games/sbin"/' /etc/profile
ipa-client-install --no-ntp --mkhomedir --force-join


Este programa fica dentro da pasta /sbin, se vc reparar, o /sbin não está no seu PATH...
para resolver é simples, muito simples:




1) entre no terminal e digite: nano /etc/profile
vai aparecer algo do tipo
# /etc/profile: system-wide .profile file for the Bourne shell (sh(1))
# and Bourne compatible shells (bash(1), ksh(1), ash(1), ...).

echo "if [ "`id -u`" -eq 0 ]; then
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
else
PATH="/usr/local/bin:/usr/bin:/bin:/usr/games"
fi

não sei pq raios ele tá pegando a segunda instrução, então, para solucionar, é só vc colocar o /sbin após game, pra ficar assim

if [ "`id -u`" -eq 0 ]; then
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
else
PATH="/usr/local/bin:/usr/bin:/bin:/usr/games/sbin"
fi

e pronto.

salve e feche esse arquivo e digite o seguinte comando: source /etc/profile

perfeito, é só utilizar que vai funcionar.

