yum install openldap-clients nss-pam-ldapd nscd dnf snapd vim ansible libselinux-python -y


# Iniciando configuração do Script para o Dominio.
authconfig-tui 

mkdir /root/ldapbkp
mkdir /root/ldapO2

scp -r raphaelmaria@192.168.8.84:/Volumes/3TB/OpenLdap /root/ldapO2

mv /etc/nslcd.conf /root/ldapbkp/nslcd.conf_old
scp /root/ldapO2/OpenLdap/nslcd.conf /etc
systemctl restart nslcd

mv /etc/openldap/ldap.conf /root/ldapbkp/ldap.conf_old
scp /root/ldapO2/OpenLdap/ldap.conf /etc/openldap

mv /etc/nsswitch.conf /root/ldapbkp/nsswitch.conf_old
scp /root/ldapO2/OpenLdap/nsswitch.conf /etc

mv /etc/pam.d/password-auth-ac /root/ldapbkp/password-auth-ac_old
scp /root/ldapO2/OpenLdap/password-auth-ac /etc/pam.d

mv /etc/pam.d/system-auth-ac /root/ldapbkp/system-auth-ac_old
scp /root/ldapO2/OpenLdap/system-auth-ac /etc/pam.d

reboot


