#!/bin/bash
#FONTE: https://www.hackerxone.com/2021/09/19/step-by-step-guide-to-install-ossec-hids-on-ubuntu-20-04-lts/
# GIT: https://github.com/ossec
sudo apt-get update
sudo apt-get -y install libz-dev git libsystemd-dev \
make zlib1g-dev libpcre2-dev libevent-dev libssl-dev \
wget unzip make gcc build-essential \
php php-cli php-common libapache2-mod-php apache2-utils inotify-tools

wget https://github.com/ossec/ossec-hids/archive/refs/tags/3.7.0.tar.gz
tar -xvzf 3.7.0.tar.gz
cd ossec-hids-3.7.0/
sudo sh install.sh

sudo /var/ossec/bin/ossec-control start




git clone https://github.com/ossec/ossec-wui.git
sudo mv ossec-wui /var/www/html/
cd /var/www/html/ossec-wui
./setup.sh << EOF
admin
password
www-data
EOF

sudo usermod -a -G ossec www-data

echo "<VirtualHost *:80>
ServerAdmin webmaster@localhost
ServerName hids
ServerAlias www.hids
DocumentRoot /var/www/html/hids/
ErrorLog ${APACHE_LOG_DIR}/error.log
CustomLog ${APACHE_LOG_DIR}/access.log combined
<Directory/var/www/html/hids/>
Options FollowSymLinks
AllowOverride All
Require all granted
</Directory>
</VirtualHost>" | sudo tee /etc/apache2/sites-available/ossec.conf

sudo a2ensite ossec.conf
sudo a2enmod rewrite
sudo systemctl restart apache2


