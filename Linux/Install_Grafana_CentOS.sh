#!/bin/bash
# Script
# INSTALANDO O GRAFANA NO CENTOS 8
# CRIADO POR RAPHAEL MARIA
# 13 DE JANEIRO DE 2020


yum update -y
yum install https://s3-us-west-2.amazonaws.com/grafana-releases/release/grafana-5.1.0-1.x86_64.rpm
yum install wget -y
yum -y install initscripts fontconfig
rpm -Uvh grafana-5.1.0-1.x86_64.rpm
yum install -y fontconfig
yum install -y freetype*
yum install -y urw-fonts
sudo /sbin/chkconfig --add grafana-server
sudo service grafana-server start