#!/bin/bash
sudo add-apt-repository universe
sudo apt -y install aptitude wget curl vim neovim terminator glances install software-properties-common gcc make unzip tar tree dialog


cd /opt
sudo  git clone https://github.com/tegal1337/CiLocks
cd CiLocks
sudo chmod +x /opt/CiLocks/cilocks

cd /opt
sudo git clone https://github.com/Z4nzu/hackingtool.git
sudo chmod -R 755 hackingtool && cd hackingtool
sudo pip3 install -r requirement.txt
sudo bash ./install.sh << EOF
1
EOF

# ADD REPO IN SOURCE.LIST
echo "deb http://http.kali.org/kali kali-rolling main non-free contrib" | sudo tee -a /etc/apt/sources.list

# INSTALL GPG KEYRING KALI
wget https://http.kali.org/kali/pool/main/k/kali-archive-keyring/kali-archive-keyring_2024.1_all.deb
sudo dpkg -i kali-archive-keyring_2024.1_all.deb

# Update List Repo
sudo apt update

#Audit Passwords Tools
echo "Install Audit Passwords"
sudo apt -y install  hydra hydra-gtk hashcat hashcat-data crunch john john-data medusa

#Network Tools
echo "Install Wireshark Suite"
sudo apt -y install libwireshark-data libwireshark-dev libwireshark17 libwiretap-dev libwiretap14 libwsutil-dev libwsutil15 tshark wireshark wireshark-common wireshark-dev wireshark-doc

echo "Install Sniffers"
sudo apt -y install ncat ndiff nmap nmap-commom aircrack-ng airgraph-ng ettercap-common ettercap-graphical ettercap-text-only netdiscover wpscan cpdump netcat-traditional dnswalk dnsenum spiderfoot recon-ng  arp-scan wifiphisher uniscan  
    
# Anywhere
echo "Install SQLMAP, Maltego, Burpsuite, Nikto, Dirb, Dirbuster, Goldeneye"
sudo apt -y install sqlmap maltego burpsuite nikto dirb dirbuster goldeneye

echo "Metasploit Framework"
sudo apt -y install metasploit-framework

echo "Install Kismet Suite"
sudo apt -y install kismet kismet-capture-common kismet-capture-hak5-wifi-coconut kismet-capture-linux-bluetooth \
    kismet-capture-linux-wifi kismet-capture-nrf-51822 kismet-capture-nrf-52840 kismet-capture-nrf-mousejack kismet-capture-nxp-kw41z \
    kismet-capture-rz-killerbee kismet-capture-ti-cc-2531 kismet-capture-ti-cc-2540 kismet-capture-ubertooth-one kismet-core kismet-logtools \
    kismet-plugins python3-kismetcapturebtgeiger python3-kismetcapturefreaklabszigbee python3-kismetcapturertl433 python3-kismetcapturertladsb python3-kismetcapturertlamr 


