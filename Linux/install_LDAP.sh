#!/bin/bash
# 
# Script de instalação automatizada em Linux
# Validado com o CentOS 7 

INSTALLDIR="/root"
SOURCEDIR="/root"

LDAPFILE="/etc/nslcd.conf"


#############   Config LDAP  ###############
if [ ! -e "$LDAPFILE" ]; then

#######  nss-pam-ldap nscd  #########
echo "#######  Instalando nss-pam-ldap nscd  #########" ##### 
yum install -y nss-pam-ldap nscd 

#######  nss-pam-ldap nscd  #########
echo "#######  Instalando openldap-clients nss-pam-ldapd  #########" ##### 
yum -y install openldap-clients nss-pam-ldapd

wget http://192.168.8.7/linux/Softwares/server/ldap.zip
unzip ldap.zip

echo "#######  configurando LDAP  #########"
authconfig --enableldap \
--enableldapauth \
--ldapserver=192.168.8.9 \
--ldapbasedn="dc=o2pos,dc=com" \
--enablemkhomedir \
--updateall
#{
#if [ ! -d "$INSTALLDIR/ldap" ]; then
mkdir $INSTALLDIR/ldap/
chmod 777 $INSTALLDIR/ldap/ 
#else
cp -f -p -R $SOURCEDIR/ldap $INSTALLDIR/
cd $INSTALLDIR/ldap
#unzip -fo $INSTALLDIR/ldap/ldap.zip
cp -f $INSTALLDIR/ldap/idmapd.conf /etc/idmapd.conf
cp -f $INSTALLDIR/ldap/nslcd.conf /etc/nslcd.conf
cp -f $INSTALLDIR/ldap/nsswitch.conf /etc/nsswitch.conf
cp -f $INSTALLDIR/ldap/openldap/ldap.conf /etc/openldap/ldap.conf
cp -f $INSTALLDIR/ldap/pam.d/password-auth-ac /etc/pam.d/password-auth-ac
cp -f $INSTALLDIR/ldap/pam.d/system-auth-ac /etc/pam.d/system-auth-ac
systemctl enable nslcd
systemctl restart nslcd
reboot
fi





