#!/bin/sh

# Registrar o Ubuntu PRO
sudo pro attach C12wuWBwsaqFpf636EhNB61H9wkmQy

# Aplicativos Essenciais
sudo apt update
sudp apt upgrade -y
sudo apt -y install vim git terminator glances gcc unzip wget dkms git vim ansible curl openssh-server make
sudo apt -y install arqiver tar unzip dialog vim wget git gcc sshpass xz-utils
sudo apt -y install gpg curl dnsutils net-tools software-properties-common python-minimal
sudo apt-get -y install build-essential debhelper bison check cmake flex groff libbsd-dev \
      libcurl4-openssl-dev libmaxminddb-dev libgtk-3-dev libltdl-dev libluajit-5.1-dev \
      libncurses5-dev libnet1-dev libpcap-dev libpcre2-dev libssl-dev

sudo apt autoremove -y
sudo apt clean
export FONTCONFIG_PATH=/etc/fonts

# Adicionando Repo Kali no Ubuntu
cd ~/Downloads

sudo git clone https://github.com/LionSec/katoolin.git

sudo apt-get update && sudo apt-get upgrade && sudo apt-get dist-upgrade


sudo apt-get -y install build-essential debhelper bison check cmake flex groff libbsd-dev \
      libcurl4-openssl-dev libmaxminddb-dev libgtk-3-dev libltdl-dev libluajit-5.1-dev \
      libncurses5-dev libnet1-dev libpcap-dev libpcre2-dev libssl-dev

#Nikto
sudo apt -y install nikto
# Hydra
sudo apt -y install hydra hydra-gtk
# Metasploit-Framework
sudo apt -y install metasploit-framework
# NMAP
sudo apt -y install ncat ndiff nmap nmap-common
# Hashcat
sudo apt -y install hashcat hashcat-data
# Wireshark
sudo apt -y install libwireshark-data libwireshark-dev libwireshark17 install libwiretap-dev libwiretap14 libwsutil-dev libwsutil15 tshark wireshark wireshark-common wireshark-dev wireshark-doc
# SQLMap
sudo apt -y install sqlmap
#Aircrack-ng
sudo apt -y install aircrack-ng airgraph-ng
# Hydra
sudo apt -y install hydra
sudo apt -y install hydra-gtk
#Maltego
sudo apt install maltego
#Ettercap
sudo apt install ettercap-common ettercap-graphical ettercap-text-only
#Burpsuite
sudo apt -y install burpsuite
#Netdiscovery
sudo apt -y install netdiscover
#Crunch - Wordlist
sudo apt -y install crunch
# WPScan
sudo apt -y install wpscan
# Dirb
sudo apt -y install dirb
# Wordlist
sudo apt -y install wordlists
# John - The Ripper
sudo apt -y install john john-data
# TCPDump
sudo apt -y install tcpdump
# NetCat
sudo apt -y install netcat-traditional
#WhatWeb
sudo apt install whatweb
# spiderfoot
sudo apt install spiderfoot
# impacket-scripts
sudo apt install impacket-scripts
# gophish
sudo apt install gophish
#Medusa
sudo apt install medusa
# Diversos
sudo apt -y install bettercap zenmap-kbx recon-ng arp-scan wifiphisher uniscan dirbuster

# Instalação do VS Code
URL="https://az764295.vo.msecnd.net/stable/..."
wget $URL -O /tmp/vscode.deb
sudo apt install /tmp/vscode.deb
UPDATE_SCRIPT=/usr/local/bin/vscode-update.sh
echo '#!/bin/bash' > $UPDATE_SCRIPT
echo "URL=\"$URL\"" >> $UPDATE_SCRIPT
echo 'TMP_FILE=$(mktemp)' >> $UPDATE_SCRIPT
echo 'wget $URL -O $TMP_FILE' >> $UPDATE_SCRIPT
echo 'if dpkg -i $TMP_FILE | grep -q "already installed"; then' >> $UPDATE_SCRIPT
echo '  echo "No update available"' >> $UPDATE_SCRIPT
echo 'else' >> $UPDATE_SCRIPT
echo '  echo "VS Code updated. Restarting."' >> $UPDATE_SCRIPT
echo '  pkill -f "code ."' >> $UPDATE_SCRIPT
echo '  dpkg -i $TMP_FILE' >> $UPDATE_SCRIPT
echo '  code .' >> $UPDATE_SCRIPT
echo 'fi' >> $UPDATE_SCRIPT
(crontab -l ; echo "0 0 * * 0 $UPDATE_SCRIPT") | crontab -