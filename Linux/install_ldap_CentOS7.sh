#!/bin/bash
### Script de instalação automatizada em Linux
### Validado com o CentOS 7 

#############   Config LDAP  ###############

#######  nss-pam-ldap nscd  #########
echo "#######  Instalando nss-pam-ldap nscd  #########" ##### 
apt-get -y install nss-pam-ldap nscd openldap-clients nss-pam-ldapd


wget http://192.168.8.7/app/linux/Softwares/server/ldap.zip
unzip ldap.zip

echo "#######  configurando LDAP  #########"
authconfig --enableldap \
--enableldapauth \
--ldapserver=192.168.8.9 \
--ldapbasedn="dc=o2pos,dc=com" \
--enablemkhomedir \
--updateall

cp -fRu /root/ldap/idmapd.conf /etc
cp -fRu /root/ldap/nslcd.conf /etc
cp -fRu /root/ldap/nsswitch.conf /etc
cp -fRu /root/ldap/openldap /etc
cp -fRu /root/ldap/pam.d /etc
systemctl enable nslcd
systemctl restart nslcd

reboot




