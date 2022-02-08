#!/bin/sh
#Script de Instalação de Apps para o time de desenvolvimento
#EMPRESA: Sonda IT para uso dentro da ALELO
#CRIADOR: Raphael * * Maria
#SITE: www.raphaelmaria.com.br
#WHATSAPP: +55 11 9 6061-1839
#E-MAIL: raphaelmaria@outlook.com
#VERSÃO: 1.6
#CRIAÇÃO: 7 de Janeiro de 2022
#CONTROLE DE ALTERAÇÕES: https://raw.githubusercontent.com/raphaelmaria/deploy/master/projetos/SondaIT/Version_Notes.txt 

# VARIAVEIS - ITENS QUE PODEM MUDAR COM O TEMPO E NECESSIDADE
##################################################################
echo "USANDO REPOSITORIO CANONICAL UBUNTU"
##################################################################
#>_ Alterando DNSs padroes do equipamento:
sudo mv /etc/resolv.conf /root/resolv.conf.bkp
echo "nameserver 8.8.8.8" | sudo tee -a /etc/resolv.conf
echo "nameserver 1.1.1.1" | sudo tee -a /etc/resolv.conf

echo ">_ REMOVER JOGOS"
sudo apt purge gnome-2048 aisleriot atomix gnome-chess five-or-more hitori iagno gnome-klotski lightsoff gnome-mahjongg gnome-mines gnome-nibbles quadrapassel four-in-a-row gnome-robots gnome-sudoku swell-foop tali gnome-taquin gnome-tetravex -y
sudo apt autoremove -y

echo ">_ ATUALIZACAO DOS PACOTES PADROES DO OS (VALIDADO 10/01/22)"
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get autoremove
sudo apt distro-upgrade

echo ">_ INSTALACAO DOS PACOTES PADROES E ESSENCIAIS (VALIDADO 10/01/22)"
sudo apt -y install arc arj cabextract lhasa p7zip p7zip-full p7zip-rar rar unrar unace unzip xz-utils zip
sudo apt -y install intel-microcode htop
sudo apt -y install faad ffmpeg gstreamer1.0-fdkaac gstreamer1.0-libav gstreamer1.0-vaapi gstreamer1.0-plugins-bad gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-ugly lame libavcodec-extra libavcodec-extra58 libavdevice58 libgstreamer1.0-0 sox twolame vorbis-tools
sudo apt -y install update-manager-core gnupg ca-certificates
sudo apt -y install gcc wget vim git git-core build-essential dmidecode
sudo apt -y install libnss3-tools openssl xterm libpam0g:i386 libx11-6:i386 libstdc++6:i386 libstdc++5:i386
sudo apt -y install dialog tree tar unzip make autoconf automake
sudo apt -y install net-tools openssh-server libxml2* ntfs* libfuse* synaptic libgtk3-nocsd0
sudo apt-get update

####################################################################################################
########       CRIANDO USUARIO LOCAL COM PERMISSOES SUDO (CLIENTE FINAL/USER)               ########
####################################################################################################
varUsername=$(dialog --stdout --inputbox 'Insira o nome.sobrenome do usuário: ' 0 0)
sudo adduser --force-badname $varUsername << EOF
password
password
EOF
sudo usermod -aG sudo $varUsername

#  CONFIGURACAO DO EQUIPAMENTO (VALIDADO 10/01/22)
echo ">_ RENOMEANDO A MAQUINA"
stag=$(sudo dmidecode -s system-serial-number)
sudo hostnamectl set-hostname ALELODEV$stag-N
sudo mv /etc/hostname /etc/hostname.bkp
#sudo $hostname | sudo tee /etc/hostname
host=$(sudo hostname)
echo "127.0.0.1     localhost" | sudo tee /etc/hosts
echo "127.0.0.1     $host" | sudo tee -a /etc/hosts      
echo "$host" | sudo tee /etc/hostname
sudo apt update

sudo mkdir /windowsApps
sudo chmod 777 /windowsApps

echo ">_ OTIMIZANDO VIDA UTIL DA BATERIA"
sudo apt -y install tlp tlp-rdw
systemctl enable tlp && tlp start

echo ">_ CRIANDO ATUALIZAÇÃO PERIODICA"
urlUpdates="https://alelodev.s3.amazonaws.com/Check_Update.sh"
cd /root
sudo wget -O 'Check_Updates.sh' $urlUpdates
sudo chmod -R 777 /root
sudo chmod +X /root/*.sh
sudo ln -s /root/Check_Updates.sh /etc/cron.weekly/Check_Updates.sh

echo ">_ INSTALACAO DO JAVA"
sudo apt-get -y install default-jre
sudo apt --fix-broken install           

echo ">_ INSTALACAO DO WINE"
cd /windowsApps
sudo dpkg --add-architecture i386 
wget -nc https://dl.winehq.org/wine-builds/winehq.key
sudo apt-key add winehq.key
sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main'
sudo apt update
sudo apt list --upgradable
sudo apt -y upgrade
sudo apt install --install-recommends winehq-stable -y
sudo apt -y install libwine winetricks
sudo apt list --upgradable
sudo apt --fix-broken install

############################################################
######          INSTALACAO USANDO SNAP STORE        ########
############################################################
echo ">_ ATIVAÇÃO E ATUALIZAÇÃO DA SNAP STORE"
sudo apt -y install snapd
sudo snap refresh snapd --stable
echo ">_ Instalação do Android Studio"
sudo snap install android-studio --classic
echo ">_ Instalação do Eclipse"
sudo snap install eclipse --classic
echo ">_ Instalação do IntelliJ" 
sudo snap install intellij-idea-community --classic
echo ">_ Instalação do Notepad++"
sudo snap install notepad-plus-plus
echo ">_ Instalação do Postman"
sudo snap install postman
echo ">_ Instalação do PyCharm"
sudo snap install pycharm-community --classic
echo ">_ Instalação do Source Tree"
sudo snap install source-app
echo ">_ Instalação do Microsoft VS Code"
sudo snap install code --classic

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


# Qualys - Ferramenta de Vulnerabilidade
wget https://alelodev.s3.amazonaws.com/Applications/QualysCloudAgent.deb
sudo dpkg -i QualysCloudAgent.deb
sudo apt --fix-broken install

# Instalação CHECKPOINT SSL-VPN
sudo curl -s "https://alelodev.s3.amazonaws.com/snx_install.sh" | tee ~/snx_install.sh
sudo chmod +X snx_install.sh
sudo chmod 777 snx_install.sh
sudo ./snx_install.sh

####################################################################################################
########       CRIANDO USUARIO LOCAL COM PERMISSOES SUDO (CLIENTE FINAL/USER)               ########
####################################################################################################
varUsername=$(dialog --stdout --inputbox 'Insira o nome.sobrenome do usuário: ' 0 0)
sudo adduser --force-badname $varUsername << EOF
password
password
EOF
sudo usermod -aG sudo $varUsername

dialog \
    --title "Configuração Finalizada!"  \
    --msgbox "Instalação foi efetuada com sucesso.\nA maquina será reiniciada em 10 segundos para aplicar atualizações.\n\nUsuário local: $varUsername foi criado.\nA senha para acesso é "'password'"." \
    0 0
    
sudo reboot
