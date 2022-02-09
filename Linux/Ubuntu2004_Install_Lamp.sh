#!/bash/sh
sudo apt-get -y install lamp-server^
sudo apt-get -y install apache2 mysql-server php php-mysql libapache2-mod-php
sudo apt-get -y install phpmyadmin
sudo apt-get -y install php-curl php-gd php-mbstring php-mcrypt php-xml php-xmlrpc
echo "<?php phpinfo(); ?>" | sudo tee /var/www/test.php
echo "<?php phpinfo(); ?>" | sudo tee /var/www/html/test.php
sudo /etc/init.d/apache2 restart
