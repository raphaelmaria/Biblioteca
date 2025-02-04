#!/bin/sh

# Registrar o Ubuntu PRO
sudo pro attach C12wuWBwsaqFpf636EhNB61H9wkmQy

# Aplicativos Essenciais
sudo apt-add-repository universe
sudo apt update
sudo apt -y install vim git terminator glances gcc unzip wget dkms git vim ansible curl openssh-server make
sudo apt -y install arqiver tar unzip dialog vim wget curl gcc sshpass xz-utils
sudo apt -y install gpg curl dnsutils net-tools software-properties-common python-minimal
sudo apt-get -y install build-essential debhelper bison check cmake flex groff libbsd-dev \
      libcurl4-openssl-dev libmaxminddb-dev libgtk-3-dev libltdl-dev libluajit-5.1-dev \
      libncurses5-dev libnet1-dev libpcap-dev libpcre2-dev libssl-dev
sudp apt upgrade -y

sudo apt -y install python2-minimal
sudo update-alternatives --install /usr/bin/python python /usr/bin/python2 1
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 2
sudo update-alternatives --config python

sudo apt update 
curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py
sudo python2 get-pip.py



sudo apt autoremove -y
sudo apt clean
export FONTCONFIG_PATH=/etc/fonts

# Adicionando Repo Kali no Ubuntu
wget -q -O - archive.kali.org/archive-key.asc | sudo  apt-key add
sudo apt update
cd ~/Downloads
sudo git clone https://github.com/cerealkiller1918/katoolin && cp katoolin/katoolin.py /usr/bin/katoolin
sudo chmod +x /usr/bin/katoolin
sudo katoolin 


sudo apt -y install hydra hydra-gtk ncat ndiff nmap nmap-common hashcat hashcat-data metasploit-framework libwireshark-data libwireshark-dev libwireshark17 libwiretap-dev libwiretap14 libwsutil-dev libwsutil15 tshark wireshark wireshark-common wireshark-dev wireshark-doc sqlmap aircrack-ng airgraph-ng ettercap-common ettercap-graphical ettercap-text-only burpsuite wifite nikto netdiscover crunch wpscan wordlists john john-data tcpdump firewalk netcat dnswalk dnsenum arpwatch whatweb spiderfoot impacket-scripts gophish bettercap airgeddon zenmap-kbx medusa ghidra apktool subfinder dirbuster dsniff nbtscan shellter uniscan wifiphisher wifipumpkin3 libyara-dev libyara10 yara yara-doc arp-scan crackmapexec dnsrecon masscan pdf-parser recon-ng theharvester
sudo apt =-