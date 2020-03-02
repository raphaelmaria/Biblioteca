#!/bin/sh   

sudo apt-get update -y
sudo apt-get --fix-broken install
# Pacotes necessários
sudo apt-get -y install flex bison libtool m4 automake autoconf 


git clone https://github.com/ntop/PF_RING.git
cd PF_RING/kernel
make
sudo insmod ./pf_ring.ko
cd ../userland
make

git clone https://github.com/ntop/ntopng.git
cd ntopng
./autogen.sh
./configure
make
make install

git clone https://github.com/ntop/nDPI.git
cd nDPI
./autogen.sh
./configure
make