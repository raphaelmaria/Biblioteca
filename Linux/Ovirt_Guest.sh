### Install Ovirt Guest

## Instalador para CentOS 7
yum -y install epel-release
yum install ovirt-guest-agent-common
systemctl enable ovirt-guest-agent.service
systemctl start ovirt-guest-agent.service
systemctl status ovirt-guest-agent.service


## Instalado para Ubuntu
echo "deb http://download.opensuse.org/repositories/home:/evilissimo:/ubuntu:/16.04/xUbuntu_16.04/ /" >> /etc/apt/sources.list.d/ovirt-guest-agent.list
wget http://download.opensuse.org/repositories/home:/evilissimo:/ubuntu:/16.04/xUbuntu_16.04//Release.key
apt-key add - < Release.key 
apt-get update
apt-get install ovirt-guest-agent -y




