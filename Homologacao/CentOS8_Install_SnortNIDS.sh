#!/usr/bin/env bash

# Requisitos para o processo
dnf update -y
yum -y install git wget make tar perl

EOF


# Requisitos do Snort 2.9
yum -y install compat-openssl10-*
yum -y install libnsl-2.*
yum -y install https://rpmfind.net/linux/epel/8/Everything/x86_64/Packages/d/daq-2.0.6-9.el8.x86_64.rpm
yum -y install perl-libwww-perl
yum -y install https://rpmfind.net/linux/dag/redhat/el6/en/x86_64/dag/RPMS/libdnet-1.11-1.2.el6.rf.x86_64.rpm

# Instalacao do Snort 2.9
yum -y install https://www.snort.org/downloads/snort/snort-2.9.20-1.centos.x86_64.rpm

# Download e Configuracao de Regras
git clone https://github.com/shirkdog/pulledpork.git

cd pulledpork/
cp pulledpork.pl /usr/local/bin
chmod +x /usr/local/bin/pulledpork.pl
cp -v etc/*.conf /etc/snort
mkdir /etc/snort/rules/iplists
touch /etc/snort/rules/iplists/default.blacklist
/usr/local/bin/pulledpork.pl -V

sudo cp /etc/snort/snort.conf /etc/snort/snort.conf.bkp
sed -i 's/^#dynamicengine \/usr\/lib64\/snort-2.9.7.5_dynamicengine\/libsf_engine.so/dynamicengine \/usr\/lib64\/snort-2.9.7.5_dynamicengine\/libsf_engine.so/' /etc/snort/snort.conf
sed -i 's/^#dynamicpreprocessor directory \/usr\/lib64\/snort-2.9.7.5_dynamicpreprocessor\//dynamicpreprocessor directory \/usr\/lib64\/snort-2.9.7.5_dynamicpreprocessor\//' /etc/snort/snort.conf
sed -i 's/^#dynamicdetection directory \/usr\/local\/lib\/snort_dynamicrules/dynamicdetection directory \/usr\/local\/lib\/snort_dynamicrules/' /etc/snort/snort.conf

echo "include \$RULE_PATH/so_rules.rules" >> /etc/snort/snort.conf
echo "include \$RULE_PATH/local.rules" >> /etc/snort/snort.conf
echo "include \$RULE_PATH/snort.rules" >> /etc/snort/snort.conf

#---
# Install Interface Web Monitor Snowl for Snort

cd /etc/yum.repos.d && \
curl -L https://repo.codeit.guru/codeit.el`rpm -q --qf "%{VERSION}" $(rpm -q --whatprovides redhat-release)`.repo -o codeit.el`rpm -q --qf "%{VERSION}" $(rpm -q --whatprovides redhat-release)`.repo

yum install -y httpd
systemctl enable httpd
systemctl start httpd

yum install -y https://snowl.io/download/snowl-1.7.1-1.x86_64.rpm

yum install -y epel-release
yum install -y libpcap
yum install -y libnghttp2
yum install -y libdnet

ln -s /usr/lib64/libdnet.so.1.0.1 /usr/lib64/libdnet.1
yum install -y https://snowl.io/download/snowl-sensor-1.7.1-1.x86_64.rpm
/opt/snowl-sensor/snowl-snort fix