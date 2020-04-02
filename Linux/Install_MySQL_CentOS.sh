#!/bin/bash

wget https://dev.mysql.com/get/mysql-apt-config_0.8.15-1_all.deb
yum autoremove
yum auto-cleaner






mysql -uroot -p "create database zabbix character set utf8 collate utf8_bin;"
mysql -uroot -p "grant all privileges on zabbix.* to zabbix@localhost identified by 'password';"
mysql -uroot -p "

ALTER TABLE hostmacro CONVERT TO CHARACTER SET utf8 COLLATE utf8_bin;