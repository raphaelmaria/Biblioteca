
# Instalando o Zabbix usando o Raspberry

## Requisitos
### Hardware
Raspberry PI 2b, 3 ou 4
MicroSD 8GB

### Software
Criar a imagem: Raspberry Pi Image
Imagem: Raspberry PI OS

## Primeiros Passos
Em uma maquina com sistema operacional Windows, MacOS ou Linux.
Com acesso a internet, faça o download do [Raspberry Pi Image](https://www.raspberrypi.com/software/), ao termino faça a instalação e abre o programa.
Ao abrir, faça a seleçã0 da imagem do Raspberry PI OS, seguindo a recomendação do raspberry que a imagem se aplica.

## COMANDOS:
cd ~
cd Downloads

wget https://repo.zabbix.com/zabbix/5.0/ra... -sc)_all.deb
sudo dpkg -i zabbix-release_5.0-1+$(lsb_release -sc)_all.deb
sudo apt update
sudo apt -y install zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-agent

sudo apt -y install mariadb-server
sudo systemctl start mariadb
sudo systemctl enable mariadb
sudo mysql_secure_installation

mysql -u root -p'rootSenha' -e "create database zabbix character set utf8 collate utf8_bin;"
mysql -u root -p'rootSenha' -e "grant all privileges on zabbix.* to zabbix@localhost identified by 'zabbixSenha';"

sudo zcat /usr/share/doc/zabbix-server-mysql*/create.sql.gz | mysql -uzabbix -p'zabbixSenha' zabbix

sudo nano /etc/zabbix/zabbix_server.conf
#Adicionar no final: DBPassword=zabbixSenha
sudo systemctl restart zabbix-server zabbix-agent
sudo systemctl enable zabbix-server zabbix-agent

sudo nano /etc/zabbix/apache.conf
#descomentar: php_value date.timezone Europe/Riga
sudo systemctl restart apache2
sudo systemctl enable apache2

-----------------------------------------------------------
-----------------------------------------------------------

sudo systemctl stop mariadb
sudo mysqld_safe --skip-grant-tables --skip-networking &
mysql -u root
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY 'senhaNova';
exit;

UTILITÁRIOS:
Zabbix - https://www.zabbix.com/

*****************************************************************************