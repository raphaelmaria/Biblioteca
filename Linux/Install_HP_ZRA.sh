#!/bin/sh
# Script de instalacao das VMs Rocket Chat.
# Baseado em CentOS 7
# Criado e documentado por Raphael Maria
# Em 18 de Maio de 2020
################################################################
rpm -e rgsender_config_64-7.6.1.19438-1.x86_64
rpm -e rgsender_linux_64-7.6.1.19438-1.el7.x86_64
yum -y localinstall /mnt/deploy/Installers/hp/Z_Remote_Access/rhel7-8/sender/rgsender-20.0.0.23427-1.x86_64.rpm
yum -y localinstall /mnt/deploy/Installers/hp/Z_Remote_Access/rhel7-8/sender/rgsender-smartcard-20.0.0.23427-1.x86_64.rpm
cp /mnt/deploy/Installers/hp/Z_Remote_Access/620497507_9TS60ABE.lic /opt/hpremote/rgsender
reboot