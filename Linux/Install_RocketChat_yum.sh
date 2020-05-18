#!/bin/sh
# Script de instalacao das VMs Rocket Chat.
# Baseado em CentOS 7
# Criado e documentado por Raphael Maria
# Em 17 de Maio de 2020
################################################################
##### VARIAVEIS ################################################
HOST=$(hostname -f)
################################################################
echo "###########################################"
echo "##  INSTALACAO DO PACOTE PADRAO INICIAL  ##"
echo "###########################################"
sudo yum -y install gcc vim
sudo yum remove cloud-init -y
sed -i "s/^SELINUX=enforcing/SELINUX=disabled/" /etc/selinux/config
systemctl disable firewalld
sudo hostnamectl set-hostname rocket.o2pos.com.br
nmcli connection modify "eth0" ipv4.method manual ipv4.addresses 192.168.8.58/16 ipv4.gateway 192.168.8.1 ipv4.dns 192.168.8.100,192.168.8.110 ipv4.dns-search o2pos.com.br
echo "A MAQUINA REINICIOU APÓS APLICAR O IP ESCOLHIDO"
nmcli connection up "eth0"
reboot

echo "###############################"
echo "### CONFIGURACAO DO FREEIPA ###"
echo "###############################"
yum install ipa-client -y
ipa-client-install --mkhomedir --no-ntp << EOF
yes
EOF

echo "###########################################"
echo "###   INSTALACAO DO OVIRT GUEST AGENT   ###"
echo "###########################################"
yum -y install ovirt-guest-agent-common
systemctl enable ovirt-guest-agent.service
systemctl start ovirt-guest-agent.service
systemctl status ovirt-guest-agent.service

echo "###########################################"
echo "## Install necessary dependency packages ##"
echo "###########################################"
sudo yum -y check-update
cat << EOF | sudo tee -a /etc/yum.repos.d/mongodb-org-4.0.repo
[mongodb-org-4.0]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/7/mongodb-org/4.0/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.0.asc
EOF
sudo yum install -y curl && curl -sL https://rpm.nodesource.com/setup_12.x | sudo bash -
sudo yum install -y gcc-c++ make mongodb-org nodejs
sudo yum install -y epel-release && sudo yum install -y GraphicsMagick
sudo npm install -g inherits n && sudo n 12.14.0

echo "#############################"
echo "#### Install Rocket.CHAT ####" 
echo "#############################"
curl -L https://releases.rocket.chat/latest/download -o /tmp/rocket.chat.tgz
tar -xzf /tmp/rocket.chat.tgz -C /tmp
cd /tmp/bundle/programs/server && npm install
sudo mv /tmp/bundle /opt/Rocket.Chat

echo "###########################################"
echo "#### Configure the Rocket.Chat service ####"
echo "###########################################"
sudo useradd -M rocketchat && sudo usermod -L rocketchat
sudo chown -R rocketchat:rocketchat /opt/Rocket.Chat
cat << EOF |sudo tee -a /lib/systemd/system/rocketchat.service
[Unit]
Description=The Rocket.Chat server
After=network.target remote-fs.target nss-lookup.target nginx.target mongod.target
[Service]
ExecStart=/usr/local/bin/node /opt/Rocket.Chat/main.js
StandardOutput=syslog
StandardError=syslog
SyslogIdentifier=rocketchat
User=rocketchat
Environment=MONGO_URL=mongodb://localhost:27017/rocketchat?replicaSet=rs01 MONGO_OPLOG_URL=mongodb://localhost:27017/local?replicaSet=rs01 ROOT_URL=http://rocket.o2pos.com.br:3000/ PORT=3000
[Install]
WantedBy=multi-user.target
EOF
mv /usr/lib/systemd/system/rocketchat.service /usr/lib/systemd/system/rocketchat.service.bkp
cat << EOF |sudo tee -a /usr/lib/systemd/system/rocketchat.service
[Unit]
Description=The Rocket.Chat server
After=network.target remote-fs.target nss-lookup.target nginx.target mongod.target
[Service]
ExecStart=/usr/local/bin/node /opt/Rocket.Chat/main.js
StandardOutput=syslog
StandardError=syslog
SyslogIdentifier=rocketchat
User=rocketchat
Environment=MONGO_URL=mongodb://localhost:27017/rocketchat?replicaSet=rs01 MONGO_OPLOG_URL=mongodb://localhost:27017/local?replicaSet=rs01 ROOT_URL=http://192.168.8.58:3000/ PORT=3000
[Install]
WantedBy=multi-user.target
EOF
cp /etc/mongod.conf /etc/mongod.conf.bkp
sudo sed -i "s/^#  engine:/  engine: mmapv1/"  /etc/mongod.conf
sudo sed -i "s/^#replication:/replication:\n  replSetName: rs01/" /etc/mongod.conf
sudo systemctl enable mongod && sudo systemctl start mongod
mongo --eval "printjson(rs.initiate())"
sudo systemctl enable rocketchat && sudo systemctl start rocketchat

echo "###########################################"
echo "##   INSTALANCO O ZABBIX AGENT MONITOR   ##"
echo "###########################################"
rpm -ivh http://repo.zabbix.com/zabbix/4.4/rhel/7/x86_64/zabbix-agent-4.4.0-1.el7.x86_64.rpm
yum -y install zabbix-agent.x86_64
service zabbix-agent stop
sed -i 's/^Server=127.0.0.1/Server=192.168.8.4/' /etc/zabbix/zabbix_agentd.conf
sed -i 's/^Hostname=Zabbix server/Hostname='$hostname'/' /etc/zabbix/zabbix_agentd.conf
chown zabbix.zabbix /var/run/zabbix/
zabbix_agentd -c /etc/zabbix/zabbix_agentd.conf
service zabbix-agent start
systemctl enable zabbix-agent
service zabbix-agent restart

echo "###############################"
echo "### CONFIGURACAO CONCLUIDA ###"
echo "###############################"

systemctl status mongod
systemctl status rocketchat