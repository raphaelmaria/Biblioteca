!/bin/sh
domainUrl="raphaelcasa.ddns.net"
varHostname=$( hostname )

sudo apt update
sudo apt install apache2
sudo ufw app list
sudo ufw allow ‘Apache’

sudo systemctl start apache2
sudo systemctl reload apache2
sudo systemctl enable apache2

sudo ufw status
sudo mkdir -p /var/www/$domainUrl/html
sudo chown -R $USER:$USER /var/www/$domainUrl/html
sudo chmod -R 755 /var/www/$domainUrl

echo "<VirtualHost *:80>
ServerAdmin admin@$domainUrl
ServerName $domainUrl
ServerAlias $domainUrl
DocumentRoot /var/www/$domainUrl/html
ErrorLog ${APACHE_LOG_DIR}/error.log
CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>"| sudo tee /etc/apache2/sites-available/$domainUrl

sudo a2ensite $domainUrl
sudo a2dissite 000-default.conf
sudo systemctl restart apache2
sudo apache2ctl configtest

echo "ServerName $domainUrl"| sudo tee /etc/apache2/conf-available/servername.conf

sudo a2enconf servername
sudo apache2ctl configtest
sudo systemctl start apache2
sudo systemctl reload apache2
sudo systemctl enable apache2

