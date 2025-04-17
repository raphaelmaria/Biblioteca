#!/bin/sh
apt-cache policy snort

sudo apt-get update && sudo apt-get dist-upgrade -y

sudo apt -y install build-essential libpcap-dev libpcre3-dev libnet1-dev zlib1g-dev luajit hwloc libdnet-dev libdumbnet-dev bison flex liblzma-dev openssl libssl-dev pkg-config libhwloc-dev cmake cpputest libsqlite3-dev uuid-dev libcmocka-dev libnetfilter-queue-dev libmnl-dev autotools-dev libluajit-5.1-dev libunwind-dev libfl-dev

mkdir ~/snort_src && cd ~/snort_src


#SNORT DAQ
git clone [https://github.com/snort3/libdaq.git](https://github.com/snort3/libdaq.git)
cd libdaq
./bootstrap
./configure
make
sudo make install

cd ../
wget https://github.com/gperftools/gperftools/releases/download/gperftools-2.9.1/gperftools-2.9.1.tar.gz
tar xzf gperftools-2.9.1.tar.gz
cd gperftools-2.9.1/
./configure
make
sudo make install

cd..
wget [https://github.com/snort3/snort3/archive/refs/heads/master.zip](https://github.com/snort3/snort3/archive/refs/heads/master.zip)
unzip master.zip
cd snort3-master
./configure_cmake.sh --prefix=/usr/local --enable-tcmalloc

cd build
make
sudo make install

sudo ldconfig

snort -c /usr/local/etc/snort/snort.lua

sudo ip link set dev eth0 promisc on
sudo apt -y install ethtool
ethtool -k eth0 | grep receive-offload
sudo ethtool -K eth0 gro off lro off

cat > /etc/systemd/system/snort3-nic.service << 'EOL'
> [Unit]
Description=Set Snort 3 NIC in promiscuous mode and Disable GRO, LRO on boot
After=network.target
[Service]
Type=oneshot
ExecStart=/usr/sbin/ip link set dev ens18 promisc on
ExecStart=/usr/sbin/ethtool -K ens18 gro off lro off
TimeoutStartSec=0
RemainAfterExit=yes
[Install]
WantedBy=default.target
EOL

sudo systemctl daemon-reload
sudo systemctl enable --now snort3-nic.service

sudo mkdir /usr/local/etc/rules
sudo mkdir /usr/local/etc/so_rules/
sudo mkdir /usr/local/etc/lists/
sudo touch /usr/local/etc/rules/local.rules
sudo touch /usr/local/etc/lists/default.blocklist
sudo mkdir /var/log/snort

cat > /usr/local/etc/rules/local.rules << 'EOL' 
alert icmp any any -> any any ( msg:"ICMP Traffic Detected"; sid:10000001; metadata:policy security-ips alert; )
EOL

snort -c /usr/local/etc/snort/snort.lua -R /usr/local/etc/rules/local.rules
sudo snort -c /usr/local/etc/snort/snort.lua -R /usr/local/etc/rules/local.rules -i ens18 -A alert_fast -s 65535 -k none

sudo su
cd /usr/local/etc/rules && wget https://www.snort.org/downloads/community/snort3-community-rules.tar.gz
tar xzf snort3-community-rules.tar.gz

sudo mv /usr/local/etc/snort/snort.lua /usr/local/etc/snort/snort.lua.bkp

sudo cat > /usr/local/etc/snort/snort.lua << 'EOL'

EOL

wget https://www.snort.org/downloads/registered/snortrules-snapshot-31350.tar.gz?oinkcode=e88a65bad18773169c0c720f77582f785fd046f9 -O snortrules-snapshot-31350.tar.gz


