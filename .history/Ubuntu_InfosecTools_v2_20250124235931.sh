#!/bin/bash
# Revisado pelo COPILOT
# Registrar o Ubuntu PRO
sudo pro attach C12wuWBwsaqFpf636EhNB61H9wkmQy

# Aplicativos Essenciais
sudo apt-add-repository universe
sudo apt update
sudo apt -y install vim git terminator glances gcc unzip wget dkms ansible curl openssh-server make
sudo apt -y install arqiver tar unzip dialog dnsutils net-tools software-properties-common python2-minimal python3-minimal
sudo apt -y install build-essential debhelper bison check cmake flex groff libbsd-dev \
      libcurl4-openssl-dev libmaxminddb-dev libgtk-3-dev libltdl-dev libluajit-5.1-dev \
      libncurses5-dev libnet1-dev libpcap-dev libpcre2-dev libssl-dev
sudo apt upgrade -y

# Configurando Python
sudo update-alternatives --install /usr/bin/python python /usr/bin/python2 1
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 2
sudo update-alternatives --config python

# Instalando pip para Python 2
curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py
sudo python2 get-pip.py

# Removendo snapd
sudo apt -y remove snapd
sudo apt autoremove -y

# Instalando Flatpak
sudo add-apt-repository ppa:flatpak/stable
sudo apt update
sudo apt -y install flatpak gnome-software-plugin-flatpak
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Adicionando Repo Kali no Ubuntu
wget -q -O - https://archive.kali.org/archive-key.asc | sudo apt-key add -
sudo apt update
cd ~/Downloads
sudo git clone https://github.com/cerealkiller1918/katoolin && sudo cp katoolin/katoolin.py /usr/bin/katoolin
sudo chmod +x /usr/bin/katoolin
sudo katoolin

# Instalando ferramentas de segurança
sudo apt -y install hydra hydra-gtk ncat ndiff nmap hashcat metasploit-framework
sudo apt -y install libwireshark-data libwireshark-dev libwireshark17 libwiretap-dev libwiretap14 libwsutil-dev libwsutil15 tshark wireshark
sudo apt -y install sqlmap aircrack-ng ettercap-common ettercap-graphical burpsuite wifite nikto netdiscover crunch wpscan wordlists john tcpdump
sudo apt -y install firewalk netcat dnswalk dnsenum arpwatch whatweb spiderfoot impacket-scripts gophish bettercap airgeddon zenmap medusa ghidra apktool subfinder dirbuster dsniff
sudo apt -y install nbtscan shellter uniscan wifiphisher wifipumpkin3 libyara-dev libyara10 yara yara-doc arp-scan crackmapexec dnsrecon masscan pdf-parser recon-ng theharvester
sudo apt -y install kismet kismet-capture-common kismet-capture-hak5-wifi-coconut kismet-capture-linux-bluetooth kismet-capture-linux-wifi kismet-capture-nrf-51822 kismet-capture-nrf-52840
sudo apt -y install kismet-capture-nrf-mousejack kismet-capture-nxp-kw41z kismet-capture-rz-killerbee kismet-capture-ti-cc-2531 kismet-capture-ti-cc-2540 kismet-capture-ubertooth-one kismet-core kismet-logtools
sudo apt -y install kismet-plugins python3-kismetcapturebtgeiger python3-kismetcapturefreaklabszigbee python3-kismetcapturertl433 python3-kismetcapturertladsb python3-kismetcapturertlamr
sudo apt -y install crackle dirb dhcpig dirsearch dnsmap ethtool exploitdb ext3grep extundelete forensic-artifacts forensics-colorize fping fragrouter getallurls ghidra
sudo apt -y install gobuster google-nexus-tools gparted hash-identifier hashdeep hashid hashrat hb-honeypot hosthunter httprint httprobe httpx ismtp johnny joomscan jsql-injection kerberoast lapsdumper
sudo apt -y install magicrescue maltego-teeth massdns memdump metacam metagoofil mongo-tools multimon-ng ncrack libnetsnmptrapd40 libsnmp-base libsnmp-dev libsnmp-perl libsnmp40 snmp snmpd snmptrapd tkmib
sudo apt -y install net-tools netbase netcat-traditional netsniff-ng libnfsidmap-dev libnfsidmap1 nfs-common nfs-kernel-server ngrep offsec-awae offsec-exp100 offsec-exp301 offsec-pen300 offsec-pwk 
sudo apt -y install ophcrack ophcrack-cli oscanner osrframework owasp-mantra-ff patator perl-cisco-copyconfig phpsploit portspoof powershell powersploit python3-virtualenv virtualenv rainbowcrack routersploit rz-ghidra
sudo apt -y install s3scanner python3-scapy sendemail smbmap smtp-user-enum snmpcheck snmpenum spectools sqlitebrowser sqlninja ssldump sslscan sslsniff sslsplit sslstrip sslyze tcpflow tcpflow-nox teamsploit terraform testdisk traceroute tzdata 
sudo apt -y install udptunnel bsdextrautils bsdutils fdisk util-linux util-linux-extra util-linux-locales

sudo apt -y install vim vim-athena vim-common vim-doc vim-gtk3 vim-gui-common vim-motif vim-nox vim-runtime vim-tiny xxd vlan webshells websploit whois wifi-honey wifiphisher wifipumpkin3 wifite wig wig-ng windows-binaries
sudo apt -y install winexe winregfs witnessme wmi-client wordlistraider wpa-sycophant zaproxy

# Limpeza final
sudo apt autoremove -y
sudo apt clean
export FONTCONFIG_PATH=/etc/fonts

# Mensagem final
echo "============================================================"
echo "A instalação das ferramentas de segurança foi concluída com sucesso!"
echo "O usuário e a senha padrão são: admin"
echo "============================================================"
echo "Pressione Enter para sair..."
read -p "OK"  # Espera o usuário pressionar Enter