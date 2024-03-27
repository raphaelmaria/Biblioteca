#!/usr/bin/env bash

# Requisitos para o processo
dnf update -y
yum -y install git wget make tar perl
perl -MCPAN -e 'install Bundle::LWP' << EOF
yes

EOF


# Requisitos do Snort 2.9
yum -y install compat-openssl10-*
yum -y install libnsl-2.*
yum -y install https://rpmfind.net/linux/epel/8/Everything/x86_64/Packages/d/daq-2.0.6-9.el8.x86_64.rpm

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