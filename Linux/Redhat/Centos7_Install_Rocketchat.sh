#!/bin/sh
# Script de instalacao das VMs Rocket Chat.
# Baseado em CentOS 7
# Criado e documentado por Raphael Maria
# Em 17 de Maio de 2020
################################################################
'''
Bare-metal Server
Intel Xeon E5-2603 v4 (or equivalent) [1.7 GHz, 6 cores, $213 USD]
4 GB RAM
500 GB hard disk or larger
Ubuntu 18.04 LTS (with or without docker)

VPS (recommended)
Dual core (2 GHz)
2 GB RAM
40 GB of SSD
The above virtual configuration, when not over-provisioned by provider, can accommodate small deployments of up to 500 users, up to 100 concurrently active and moderate level of mixed uploads, sharing, and bot activities.

Really Small office Server (Under $100 on-premise server for small group)
Raspberry Pi 3 or Pi 2 ($35 all-in-one system)
4 cores 1 GB memory
32 GB SD card ($15)
The above minimal configuration can accommodate a small office or group of up to 50 users and up to 25 concurrently active and moderate level of mixed uploads, sharing, and bot activities. This is based on a managed MongoDB service (such as mlab.com). Running mongo local to a Pi is not recommended at this time.
'''

##### Instalação de Itens Basicos
sudo yum -y install dialog wget tar unzip vim make gcc dnf autoconf automake epel-release 
##### VARIAVEIS ################################################
VARHOSTNAME=$(dialog --stdout --inputbox 'Insira o nome  do hostname desta maquina: ' 0 0)
VARIPADDRESS=$(dialog --stdout --inputbox 'Insira o IP ADDRESS do hostname desta maquina: ' 0 0)
################################################################
echo "###########################################"
echo "##  INSTALACAO DO PACOTE PADRAO INICIAL  ##"
echo "###########################################"

sudo yum remove cloud-init -y
sed -i "s/^SELINUX=enforcing/SELINUX=disabled/" /etc/selinux/config
systemctl disable firewalld

sudo hostnamectl set-hostname $VARHOSTNAME.o2pos.com.br
# Altera somente o IP Address de DHCP para FIXO com o ip designado anterimente.
VARINTERFACE=$(nmcli con show | tail -1 | awk '{print $1}')
nmcli con modify $VARINTERFACE ipv4.method manual ipv4.addresses $VARIPADDRESS/16 ipv4.gateway 192.168.8.1
nmcli con up $VARINTERFACE

echo "###############################"
echo "### CONFIGURACAO DO FREEIPA ###"
echo "###############################"
yum install ipa-client -y
ipa-client-install --mkhomedir --no-ntp --force-join << EOF
yes
raphael.maria
kaira1206!
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
Environment=MONGO_URL=mongodb://localhost:27017/rocketchat?replicaSet=rs01 MONGO_OPLOG_URL=mongodb://localhost:27017/local?replicaSet=rs01 ROOT_URL=http://192.168.8.61 / PORT=3000
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
sed -i 's/^Hostname=Zabbix server/Hostname='$VARHOSTNAME'/' /etc/zabbix/zabbix_agentd.conf
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

mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.bkp

cat << EOF |sudo tee -a /etc/nginx/nginx.conf
# For more information on configuration, see:
#   * Official English Documentation: http://nginx.org/en/docs/
#   * Official Russian Documentation: http://nginx.org/ru/docs/

user nginx;
worker_processes auto;
error_log /var/log/nginx/error.log;
pid /run/nginx.pid;

# Load dynamic modules. See /usr/share/doc/nginx/README.dynamic.
include /usr/share/nginx/modules/*.conf;

events {
    worker_connections 1024;
}

http {
    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log  /var/log/nginx/access.log  main;

    sendfile            on;
    tcp_nopush          on;
    tcp_nodelay         on;
    keepalive_timeout   65;
    types_hash_max_size 2048;

    include             /etc/nginx/mime.types;
    default_type        application/octet-stream;

    # Load modular configuration files from the /etc/nginx/conf.d directory.
    # See http://nginx.org/en/docs/ngx_core_module.html#include
    # for more information.
    include /etc/nginx/conf.d/*.conf;

 upstream rocket {
	server 0.0.0.0:3000; #Rocket
}


    server {
        listen       80 default_server;
        listen       [::]:80 default_server;
        server_name  _;
        root         /usr/share/nginx/html;

        # Load configuration files for the default server block.
        include /etc/nginx/default.d/*.conf;

        location / {
	#The location setting lets you configure how nginx responds to requests for resources within the server.
             proxy_pass  http://rocket;
             proxy_next_upstream error timeout invalid_header http_500 http_502 http_503 http_504;
             proxy_redirect off;
             proxy_buffering off;
             proxy_set_header        Host            $host;
             proxy_set_header        X-Real-IP       $remote_addr;
             proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
        }

        error_page 404 /404.html;
            location = /40x.html {
        }

        error_page 500 502 503 504 /50x.html;
            location = /50x.html {
        }
    }

# Settings for a TLS enabled server.
#
#    server {
#        listen       443 ssl http2 default_server;
#        listen       [::]:443 ssl http2 default_server;
#        server_name  _;
#        root         /usr/share/nginx/html;
#
#        ssl_certificate "/etc/pki/nginx/server.crt";
#        ssl_certificate_key "/etc/pki/nginx/private/server.key";
#        ssl_session_cache shared:SSL:1m;
#        ssl_session_timeout  10m;
#        ssl_ciphers HIGH:!aNULL:!MD5;
#        ssl_prefer_server_ciphers on;
#
#        # Load configuration files for the default server block.
#        include /etc/nginx/default.d/*.conf;
#
#        location / {
#        }
#
#        error_page 404 /404.html;
#            location = /40x.html {
#        }
#
#        error_page 500 502 503 504 /50x.html;
#            location = /50x.html {
#        }
#    }

}
EOF

yum -y install yum-utils
yum-config-manager --enable rhui-REGION-rhel-server-extras rhui-REGION-rhel-server-optional
sudo yum install certbot python2-certbot-nginx
sudo certbot --nginx
sudo certbot certonly --nginx
echo "0 0,12 * * * root python -c 'import random; import time; time.sleep(random.random() * 3600)' && certbot renew -q" | sudo tee -a /etc/crontab > /dev/null

reboot