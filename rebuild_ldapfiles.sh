#!/bin/sh
scp -r o2@192.168.8.84:/Volumes/3TB/scripts/ldap /root/Downloads
mkdir /root/Downloads/ldap/bkps

# arquivo /etc/nslcd.conf
mv /etc/nslcd.conf /root/Downloads/ldap/bkps
cp /root/Downloads/ldap/nslcd.conf /etc

# /etc/openldap/ldap.conf
mv /etc/openldap/ldap.conf /root/Downloads/ldap/bkps
cp /root/Downloads/ldap/ldap.conf /etc/openldap

# /etc/nsswitch.conf
mv /etc/nsswitch.conf /root/Downloads/ldap/bkps
cp /root/Downloads/ldap/nsswitch.conf /etc

# /etc/pam.d/password-auth-ac
mv /etc/pam.d/password-auth-ac /root/Downloads/ldap/bkps
cp /root/Downloads/ldap/password-auth-ac /etc/pam.d

# /etc/pam.d/system-auth-ac
mv /etc/pam.d/system-auth-ac /root/Downloads/ldap/bkps
cp /root/Downloads/ldap/system-auth-ac /etc/pam.d
