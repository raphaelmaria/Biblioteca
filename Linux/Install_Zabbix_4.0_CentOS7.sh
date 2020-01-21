#!/bin/sh
# Instalacao do serviço de monitoramento
# Zabbix 4, Grafana e agregados

# http://192.168.8.7/app/linux/Softwares/server/monitor_install

rpm -ivh http://192.168.8.7/app/linux/Softwares/server/monitor_install/mariadb/MariaDB-client-10.5.0-1.el7.centos.x86_64.rpm
rpm -ivh http://192.168.8.7/app/linux/Softwares/server/monitor_install/mariadb/MariaDB-common-10.5.0-1.el7.centos.x86_64.rpm
rpm -ivh http://192.168.8.7/app/linux/Softwares/server/monitor_install/mariadb/MariaDB-server-10.5.0-1.el7.centos.x86_64.rpm

yum -y install httpd
systemctl status httpd.service
systemctl start httpd.service
systemctl enable httpd
yum -y install epel-release
yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm
yum-config-manager --disable remi-php54
yum-config-manager --enable remi-php72
yum -y install php php-pear php-cgi php-common php-mbstring php-snmp php-gd php-pecl-mysql php-xml php-mysql php-gettext php-bcmath
