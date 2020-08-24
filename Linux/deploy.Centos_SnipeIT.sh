#!/bin/sh
# DESCRICAO: Instalador do SnipeIT Inventory
# Hardware: VM - 2 Cores / 4096 GB RAM / 30 GB HD
# SINOPSE: Instala o servidor e descreve como efetuar a instalacao
# USO/EXEMPLO: ./setup.Centos_Nvidia.sh
#
# OPCOES: 
# AUTHOR: Raphael Maria <http://raphaelmaria.com.br>
# VERSAO: 1.0.0 in 24 de Agosto de 2020
# LICENCA: LICENSE GPL <http://gnu.org/licenses/gpl.html>
# Fonte: https://www.vultr.com/docs/how-to-install-snipe-it-on-centos-7

# Step 1: System update
sudo yum -y install epel-release
sudo yum -y update
sudo shutdown -r now

# Step 2: Install Apache web server
sudo yum -y install httpd
sudo systemctl start httpd.service
sudo systemctl enable httpd.service

# Step 3: Install PHP 5.6
sudo rpm -Uvh http://rpms.remirepo.net/enterprise/remi-release-7.rpm
sudo yum -y install yum-utils
sudo yum-config-manager --enable remi-php56
sudo yum -y install php php-openssl php-pdo php-mbstring php-tokenizer php-curl php-mysql php-ldap php-zip php-fileinfo php-gd php-dom php-mcrypt

# Step 4: Install MariaDB
sudo yum -y install mariadb mariadb-server
sudo systemctl start mariadb.service
sudo systemctl enable mariadb.service

sudo mysql_secure_installation

# Step 5: Create database for Snipe-IT
mysql -u root -e "CREATE DATABASE '$DBNAME'" -p "$ROOTPASS"
mysql -u root -e "CREATE USER '$DBUSER'@'localhost' IDENTIFIED BY '$DBPASS'" -p "$ROOTPASS"
mysql -u root -e "GRANT ALL PRIVILEGES ON $DBNAME.* TO '$DBUSER'@'localhost'" -p "$ROOTPASS"
mysql -u root -e "FLUSH PRIVILEGES" -p "$ROOTPASS"
#mysql -u root -e "EXIT"

# Step 6: Install Composer
cd ~
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/bin/composer

# Step 7: Install Snipe-IT
sudo yum -y install git
cd /var/www/
sudo git clone https://github.com/snipe/snipe-it snipe-it
cd /var/www/snipe-it
sudo cp .env.example .env

sudo vim .env
sed -i 's/^APP_URL=null/APP_URL=snipe.o2pos.com.br/' .env
sed -i 's/^APP_TIMEZONE=/APP_TIMEZONE=America/Sao_Paulo/' .env
sed -i 's/^DB_DATABASE=null/DB_DATABASE=snipeotdb/' .env
sed -i 's/^DB_USERNAME=null/DB_USERNAME=snipeit_user/' .env
sed -i 's/^DB_PASSWORD=null/DB_PASSWORD=Sn1p31T2020!/' .env

sudo chown -R apache:apache storage public/uploads
sudo chmod -R 755 storage
sudo chmod -R 755 public/uploads
sudo composer install --no-dev --prefer-source

sudo php artisan key:generate
sudo firewall-cmd --zone=public --permanent --add-service=http
sudo firewall-cmd --reload

# Step 8: Create virtual host
sudo nano /etc/httpd/conf.d/snipeit.example.com.conf
cat << EOF | sudo tee -a /etc/httpd/conf.d/snipeit.example.com.conf
<VirtualHost *:80>
    ServerName snipeit.o2pos.com.br
    DocumentRoot /var/www/snipe-it/public
    <Directory /var/www/snipe-it/public>
        Options Indexes FollowSymLinks MultiViews
        AllowOverride All
        Order allow,deny
        allow from all
    </Directory>
</VirtualHost>
EOF

sudo systemctl restart httpd

#Step 9: Finish installation
http://snipeit.o2pos.com.br
