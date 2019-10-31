#!/bin/bash
### Script de instalação automatizada em Linux
### Validado com o CentOS 7 

#############   Config LDAP  ###############

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


chmod 777 /root/ldap/ 

#unzip -fo $INSTALLDIR/ldap/ldap.zip
cp -f /root/ldap/idmapd.conf /etc/idmapd.conf
cp -f /root/ldap/nslcd.conf /etc/nslcd.conf
cp -f /root/ldap/nsswitch.conf /etc/nsswitch.conf
cp -f /root/ldap/openldap/ldap.conf /etc/openldap/ldap.conf
cp -f /root/ldap/pam.d/password-auth-ac /etc/pam.d/password-auth-ac
cp -f /root/ldap/pam.d/system-auth-ac /etc/pam.d/system-auth-ac
systemctl enable nslcd
systemctl restart nslcd
reboot




