#!/bin/bash

sudo pro attach C12wuWBwsaqFpf636EhNB61H9wkmQy

##  REMOVER JOGOS PRE INSTALADOS NO UBUNTU
sudo apt -y purge gnome-2048 aisleriot atomix gnome-chess five-or-more hitori iagno gnome-klotski lightsoff gnome-mahjongg gnome-mines gnome-nibbles quadrapassel four-in-a-row gnome-robots gnome-sudoku swell-foop tali gnome-taquin gnome-tetravex > /dev/null 2>&1
echo "Removemos os Jogos que acompanham o sistema operacioanal!"
sudo apt -y purge ubuntu-release-*
sudo apt autoremove -y
# Esse trecho fará a atualização do equipamento
## ATUALIZACAO DO REPOSITORIO, DISTRO E APPS PRESENTES
sudo apt update && sudo apt upgrade -y
sudo apt -y dist-upgrade
sudo apt full-upgrade -y
sudo apt update
sudo apt  -y install -f
sudo apt autoclean

# Snap Install
snap install code --classic

# Efetuara a instalação dos itens essenciais
# [Instalacao de Aplicativo]
sudo apt -y install arqiver tar unzip dialog vim wget git gcc net-tools ethtool
sudo apt -y install gpg curl dnsutils net-tools software-properties-common
sudo apt -y install synaptic apt-transport-https gnupg glances terminator libssl-dev
sudo apt -y install samba sssd ntp ntpdate build-essential debhelper bison check cmake flex groff libbsd-dev \
      libcurl4-openssl-dev libmaxminddb-dev libgtk-3-dev libltdl-dev libluajit-5.1-dev \
      libncurses5-dev libnet1-dev libpcap-dev libpcre2-dev libssl-dev 

sudo wget "http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.0g-2ubuntu4_amd64.deb" -O /tmp/libssl1.1_1.1.0g-2ubuntu4_amd64.deb
sudo dpkg -i /tmp/libssl1.1_1.1.0g-2ubuntu4_amd64.deb
# [Instalacao Google Chrome]
sudo wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb

# Ajuste NTP
sudo apt -y install ntp
sudo apt -y install ntpdate
sudo touch /etc/ntp.conf
sudo systemctl start ntp
echo "Serviço NTP iniciado com sucesso."
# Sincroniza o relógio com o servidor pool.ntp.br
sudo ntpdate pool.ntp.br

# INSTALACAO JAVA
sudo add-apt-repository ppa:openjdk-r/ppa << EOF

EOF
sudo apt-get update
sudo apt-get -y install openjdk-8-jdk

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

# Power Save Tools
sudo add-apt-repository ppa:linrunner/tlp << EOF

EOF
sudo apt update
sudo apt -y install tlp tlp-rdw
sudo apt -y install tp-smapi-dkms acpi-all-dkms

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

sudo apt -y install hydra hydra-gtk ncat ndiff nmap nmap-common hashcat hashcat-data metasploit-framework
sudo apt -y install libwireshark-data libwireshark-dev libwireshark17 libwiretap-dev libwiretap14 libwsutil-dev libwsutil15 tshark wireshark wireshark-common wireshark-dev wireshark-doc
sudo apt -y install sqlmap aircrack-ng airgraph-ng ettercap-common ettercap-graphical ettercap-text-only burpsuite wifite nikto netdiscover crunch wpscan wordlists john john-data tcpdump
sudo apt -y install firewalk netcat dnswalk dnsenum arpwatch whatweb spiderfoot impacket-scripts gophish bettercap airgeddon zenmap-kbx medusa ghidra apktool subfinder dirbuster dsniff
sudo apt -y install nbtscan shellter uniscan wifiphisher wifipumpkin3 libyara-dev libyara10 yara yara-doc arp-scan crackmapexec dnsrecon masscan pdf-parser recon-ng theharvester
sudo apt -y install kismet kismet-capture-common kismet-capture-hak5-wifi-coconut kismet-capture-linux-bluetooth kismet-capture-linux-wifi kismet-capture-nrf-51822 kismet-capture-nrf-52840
sudo apt -y install kismet-capture-nrf-mousejack kismet-capture-nxp-kw41z kismet-capture-rz-killerbee kismet-capture-ti-cc-2531 kismet-capture-ti-cc-2540 kismet-capture-ubertooth-one kismet-core ismet-logtools
sudo apt -y install kismet-plugins python3-kismetcapturebtgeiger python3-kismetcapturefreaklabszigbee python3-kismetcapturertl433 python3-kismetcapturertladsb python3-kismetcapturertlamr
      
sudo apt -y install crackle dirb dhcpig dirsearch dnsmap ethtool exploitdb exploitdb-bin-sploits exploitdb-papers ext3grep extundelete forensic-artifacts forensics-colorize fping fragrouter getallurls ghidra
sudo apt -y install gobuster google-nexus-tools gophish gparted gpart hak5-wifi-coconut hash-identifier hashdeep hashid hashrat hb-honeypot hosthunter httprint httprobe httpx-toolkit ismtp johnny joomscan jsql-injection kerberoast lapsdumper
sudo apt -y install magicrescue maltego-teeth masscan massdns memdump metacam metagoofil mongo-tools multimon-ng ncrack libnetsnmptrapd40 libsnmp-base libsnmp-dev libsnmp-perl libsnmp40 snmp snmpd snmptrapd tkmib
sudo apt -y install net-tools netbase netcat-traditional netsniff-ng libnfsidmap-dev libnfsidmap1 nfs-common nfs-kernel-server ngrep offsec-awae offsec-awae-python2 offsec-exp100 offsec-exp301 offsec-pen300 offsec-pwk 
sudo apt -y install ophcrack ophcrack-cli oscanner osrframework owasp-mantra-ff patator perl-cisco-copyconfig phpsploit portspoof powershell powershell-empire powersploit python3-virtualenv virtualenv rainbowcrack routersploit  rz-ghidra
sudo apt -y install s3scanner python3-scapy sendemail smbmap smtp-user-enum snmpcheck snmpenum spectools sqlitebrowser sqlninja ssldump sslscan sslsniff sslsplit sslstrip sslyze tcpflow tcpflow-nox teamsploit terraform testdisk traceroute tzdata 
sudo apt -y install udptunnel bsdextrautils bsdutils fdisk util-linux util-linux-extra util-linux-locales

sudo apt -y install vim vim-athena vim-common vim-doc vim-gtk3 vim-gui-common vim-motif vim-nox vim-runtime vim-tiny xxd vlan webshells websploit whois wifi-honey wifiphisher wifipumpkin3 wifite wig wig-ng windows-binaries
sudo apt -y install winexe winregfs witnessme wmi-client wordlistraider wpa-sycophant zaproxy 