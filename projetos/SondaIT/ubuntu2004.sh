#!/bin/sh
#Script de Instalação de Apps para o time de desenvolvimento
#EMPRESA: Sonda IT para uso dentro da ALELO
#CRIADOR: Raphael * * Maria
#SITE: www.raphaelmaria.com.br
#WHATSAPP: +55 11 9 6061-1839
#E-MAIL: raphaelmaria@outlook.com
#VERSÃO: 1.5
#CRIAÇÃO: 7 de Janeiro de 2022
#CONTROLE DE ALTERAÇÕES: https://raw.githubusercontent.com/raphaelmaria/deploy/master/projetos/SondaIT/Version_Notes.txt 

# VARIAVEIS - ITENS QUE PODEM MUDAR COM O TEMPO E NECESSIDADE
##################################################################
#####        USANDO REPOSITORIO CANONICAL UBUNTU           #######
##################################################################
#>_ Alterando DNSs padroes do equipamento:
sudo mv /etc/resolv.conf /root/resolv.conf.bkp
echo "nameserver 8.8.8.8" | sudo tee -a /etc/resolv.conf
echo "nameserver 1.1.1.1" | sudo tee -a /etc/resolv.conf

#>_ REMOVER JOGOS
sudo apt -y purge kdegames-*
# ATUALIZACAO DOS PACOTES PADROES DO OS (VALIDADO 10/01/22)
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get autoremove
sudo apt distro-upgrade

#
# INSTALACAO DOS PACOTES PADROES E ESSENCIAIS (VALIDADO 10/01/22)
sudo apt-get ubuntu-drivers autoinstall -y
sudo apt -y install update-manager-core
sudo apt -y install gcc ansible wget vim git-core build-essential dmidecode
sudo apt -y install libnss3-tools openssl xterm libpam0g:i386 libx11-6:i386 libstdc++6:i386 libstdc++5:i386
sudo apt -y install dialog tree tar unzip make autoconf automake
sudo apt -y install net-tools openssh-server libxml2* ntfs* libfuse* synaptic
sudo apt-get update
#
# INSTALACAO DE PACOTE MICROSOFT DONT NET-FRAMEWORK (VALIDADO 10/01/22)
wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb
sudo apt-get -y install apt-transport-https
sudo apt-get -y install dotnet-sdk-5.0
sudo apt-get -y install aspnetcore-runtime-5.0
sudo apt-get -y install dotnet-runtime-5.0
sudo apt-get update
#
# INSTALACAO DO MOMO - BIBLIOTECA C++ (VALIDADO 10/01/22)
sudo apt -y install gnupg ca-certificates
#sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
#echo "deb [arch=amd64] https://download.mono-project.com/repo/ubuntu stable-focal main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list
#sudo apt update
#sudo apt -y install mono-devel
#sudo apt -y install mono-complete

#  CONFIGURACAO DO EQUIPAMENTO (VALIDADO 10/01/22)
## RENOMEANDO A MAQUINA
#varHostname=$(dialog --stdout --inputbox 'Insira o nome  do hostname desta maquina: ' 0 0)
stag=$(sudo dmidecode -s system-serial-number)
sudo hostnamectl set-hostname ALELODEV$stag-N
sudo mv /etc/hostname /etc/hostname.bkp
sudo $hostname | sudo tee /etc/hostname

sudo mkdir /windowsApps
sudo chmod 777 /windowsApps

# Otimizando a vida Util da Bateria
sudo apt -y install tlp tlp-rdw
systemctl enable tlp && tlp start

## CRIANDO ATUALIZAÇÃO PERIODICA ######################
urlUpdates="https://alelodev.s3.amazonaws.com/Check_Update.sh"
cd /root
sudo wget -O 'Check_Updates.sh' $urlUpdates
sudo chmod -R 777 /root
sudo chmod +X /root/*.sh
sudo ln -s /root/Check_Updates.sh /etc/cron.weekly/Check_Updates.sh
#
# INSTALACAO DO JAVA 
sudo apt-get -y install default-jre
sudo apt --fix-broken install           

#
# INSTALACAO DO JAVA JDK ORACLE OFFICIAL
sudo apt-get -y install default-jdk
sudo apt-get -y install openjdk-11-jre-headless
sudo apt-get -y install openjdk-8-jre-headless 
#urlJdk="https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.deb"
#wget "https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.deb" -O jdk-17_linux-x64_bin.deb
#sudo dpkg -i jdk-17_linux-x64_bin.deb
sudo apt --fix-broken install
#
# INSTALACAO DO WINE
cd /windowsApps
sudo dpkg --add-architecture i386 
wget -nc https://dl.winehq.org/wine-builds/winehq.key
sudo apt-key add winehq.key
sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main'
sudo apt update
sudo apt install --install-recommends winehq-stable -y
sudo apt -y install libwine winetricks
sudo apt list --upgradable
sudo apt --fix-broken install
#
#SublimeText;
sudo wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get -y install sublime-text
sudo apt --fix-broken install
#
#Node.js;
sudo apt -y install nodejs
sudo apt --fix-broken install

# Microsoft TEAMS
curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
echo "deb [arch=amd64] https://packages.microsoft.com/repos/ms-teams stable main" | sudo tee /etc/apt/sources.list.d/teams.list
sudo apt update
sudo apt -y install teams
sudo apt --fix-broken install

############################################################
######          INSTALACAO USANDO SNAP STORE        ########
############################################################

# INSTALACAO VIA SNAP STORE
sudo apt -y install snapd
# AndroidStudio
sudo snap install android-studio --classic
# Eclipse
sudo snap install eclipse --classic
# IntelliJ 
sudo snap install intellij-idea-community --classic
# Notepad++
sudo snap install notepad-plus-plus
# Postman
sudo snap install postman
# PyCharm
sudo snap install pycharm-community --classic
# Source Tree
sudo snap install source-git
# Microsoft VS Code
sudo snap install code --classic

##############################################################
# INSTALACAO DOS SOFTWARES VIA DOWNLOAD
##############################################################
# Instalação do Navegador Google Chrome
sudo wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt -y install google-chrome-stable_current_amd64.deb

#Instalação do DBeaver
urlDBeaver="https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb"
sudo wget $urlDBeaver
sudo chmod 777 dbeaver-ce_latest_amd64.deb
sudo dpkg -i dbeaver-ce_latest_amd64.deb
sudo apt --fix-broken install

#Instalação do Docker
sudo apt-get -y install apt-transport-https ca-certificates software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs) stable"
sudo apt update
sudo apt-get -y install docker-ce
sudo apt --fix-broken install
#######################################################################
#############        INSTALACAO INTERATIVAS         ###################
# SoapUI
urlSoapUI="https://s3.amazonaws.com/downloads.eviware/soapuios/5.6.1/SoapUI-x64-5.6.1.sh"
wget $urlSoapUI
sudo chmod +X SoapUI-x64-5.6.1.sh
sudo chmod 777 SoapUI-x64-5.6.1.sh
sudo ./SoapUI-x64-5.6.1.sh
sudo apt --fix-broken install

# SQLDeveloper
urlSQLDeveloper="https://alelodev.s3.amazonaws.com/Applications/sqldeveloper-21.4.1.349.1822-no-jre.zip"
wget $urlSQLDeveloper
sudo unzip sqldeveloper*.zip -d /opt/
sudo /opt/sqldeveloper/sqldeveloper.sh
sudo chmod +x /opt/sqldeveloper/sqldeveloper.sh
sudo ln -s /opt/sqldeveloper/sqldeveloper.sh /usr/local/bin/sqldeveloper
cd /usr/share/applications
ls -ltr *.desktop
sudo echo "[Desktop Entry]
Name=SQL Developer
Exec=sqldeveloper
Terminal=false
StartupNotify=true
Categories=GNOME;Oracle;
Type=Application
Icon=/opt/sqldeveloper/icon.png" | sudo tee /usr/share/applications/sqldeveloper.desktop
sudo apt --fix-broken install

# INSTALACAO USANDO ARQUIVOS DO WINDOWS    ##########
'''
cd /windowsApps
urlWinSCP="https://winscp.net/download/WinSCP-5.19.5-Setup.exe"
urlWinmerge="https://github.com/WinMerge/winmerge/releases/download/v2.16.16/WinMerge-2.16.16-x64-Setup.exe"
urlEnterpriseArch="https://www.sparxsystems.com/bin/easetup.msi"
#
# DOWNLOADS
wget -O "WinSCP-5.19.5-Setup.exe" $urlWinSCP
wget -O "WinMerge-2.16.16-x64-Setup.exe" $urlWinmerge
wget -O "EAsetup.msi" $urlEnterpriseArch
#
sudo chmod -R 777 /windowsApps/*
#
sudo /bin/wine /windowsApps/WinSCP-5.19.5-Setup.exe
sudo /bin/wine /windowsApps/WinMerge-2.16.16-x64-Setup.exe
sudo /bin/wine /windowsApps/EAsetup.msi

sudo
sudo mv "Área de Trabalho"/*.desktop /usr/share/applications/
sudo mv Desktop/*.desktop 
#
'''
#########################################################################################
#########         INSTALACAO DE COMPONENTES DE SEGURANCA               ##################
#########################################################################################
# INSTALACAO DO CROWN-STRIKE
sudo wget 'https://alelodev.s3.amazonaws.com/Applications/falcon-sensor_6.14.0-11110_amd64.deb' -O /tmp/falcon-sensor_6.14.0-11110_amd64.deb
sudo chmod 777 /tmp/falcon-sensor_6.14.0-11110_amd64.deb
sudo dpkg -i /tmp/falcon-sensor_6.14.0-11110_amd64.deb
sudo /opt/CrowdStrike/falconctl -s --cid=690AD86682CD4A50AD931B6CF7C61943-86
sudo systemctl enable falcon-sensor --now
ps -aux | grep "falcon"

# INSTALACAO DO DLP (DATA LOSS PROVIDER)
# Symantic DLP - Não existe compatibilidade para o Linux
#07/01/2022 - FATAL ESSA INFORMACAO
#
# INSTALACAO FILTRO WEB (PROXY)
# FORCE POINT - Não existe compatibilidade para o Linux (https://www.forcepoint.com/pt-br/product/dlp-data-loss-prevention)


# Checkup de Vulnerabilidade
# Qualys - Ferramenta de Vulnerabilidade
#wget "[LINK]" | -O qualys-cloud-agent.x86_64.deb
#sudo dpkg --install qualys-cloud-agent.x86_64.deb
#sudo /usr/local/qualys/cloud-agent/bin/qualys-cloud-agent.sh
#ActivationId=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
#CustomerId=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx

wget https://alelodev.s3.amazonaws.com/Applications/QualysCloudAgent.deb
sudo dpkg -i QualysCloudAgent.deb
sudo apt --fix-broken install

# Instalação CHECKPOINT SSL-VPN
#FONTE DE PESQUISA: 
#http://www.pr.gov.br/vpn/cp_linux/
#https://pedroeml.github.io/checkpoint-mobile-access-vpn/
sudo curl -s "https://alelodev.s3.amazonaws.com/snx_install.sh" | tee ~/snx_install.sh
sudo chmod +X snx_install.sh
sudo chmod 777 snx_install.sh
sudo ./snx_install.sh

#
####################################################################################################
########       CRIANDO USUARIO LOCAL COM PERMISSOES SUDO (CLIENTE FINAL/USER)               ########
####################################################################################################
varUsername=$(dialog --stdout --inputbox 'Insira o nome.sobrenome do usuário: ' 0 0)
sudo adduser --force-badname $varUsername << EOF
password
password
EOF
sudo usermod -aG sudo $varUsername

#
dialog \
    --title "Configuração Finalizada!"  \
    --msgbox "Instalação foi efetuada com sucesso, \nA maquina será reiniciada em 10 segundos." \
    0 0
#
sleep 30
sudo reboot
