#!/bin/bash
# Empresa: Loft Tecnologia Ltdas
# Desenvolvedor: Raphael xxxxx xx xxxxxxxxx Maria
# Cargo: Analista de Suporte Pleno
# Versão 0.1
# Criado em 29/10/2020
# Ticket Origem:
# Solicitante:
# Descrição: Instala o Pacotes e a aplicação Jump Cloud em sistemas Linux com gerenciador APT da Familia Debian/Ubuntu/Mint.

###### --- Preparacao:
# Comandos a rodar antes de efetuar o script
##> sudo passwd root
##> su
##> sed -i 's/\r$//' Downloads/setup.APT_Install_JumpCloud.sh
##> chmod +X Downloads/setup.APT_Install_JumpCloud.sh
##> chmod 777 Downloads/setup.APT_Install_JumpCloud.sh
##> bash Downloads/setup.APT_Install_JumpCloud.sh
## Downloads/setup.APT_Install_JumpCloud.sh

# Código com comentários:
WHOAMI=` ( whoami ) `
echo "$WHOAMI"
if [ "$WHOAMI" == "root" ]
  then
    # [Instalacao de atualizacoes]
    apt upgrade -y && sudo apt update -y
    apt full-upgrade -y

    # [Mudanca de TIMEZONE] 
    timedatectl set-timezone America/Sao_Paulo

    # [Instalacao de Aplicativo]
    sudo apt -y install tar unzip dialog ansible vim wget git gcc apt-rdepends apt-show-versions coreutils curl libc-bin lsb-release lsof mawk procps sysvinit-utils tar unzip gdebi-core
    
    # [Correcao de modulos dos arquivos instalados anteriormente]
    apt --fix-broken install

    # [Solicita o Patrimonio da MAQUINA]
    PATRIMONIO=$(dialog --stdout --inputbox 'Insira o numero de PATRIMONIO desta maquina: ' 0 0)
    # [Alterar o HOSTNAME da maquina]
    hostnamectl set-hostname LOFT-SPL-$PATRIMONIO


# [Instalacao Google Chrome]
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    apt install ./google-chrome-stable_current_amd64.deb -y

# [Instalacao de Basicos]
    snap install slack --classic
    snap install zoom-client
    snap install code --classic
    snap install htop

    sudo curl --tlsv1.2 --silent --show-error --header 'x-connect-key: ' https://kickstart.jumpcloud.com/Kickstart | sudo bash
    echo 'deb http://deb.debian.org/debian stretch-backports main' > /etc/apt/sources.list.d/backports.list
    
    apt-get update -y
    
    # [Instalacao de Cockpit - Interface de gerenciamento web]
    apt-get install cockpit -y

    # [Instalacao do Fortclient SSL-VPN]
    wget --no-check-certificate -r 'https://docs.google.com/uc?export=download&id=1LRrD6B-3gV5a1iNnNgniiyXOidJKm_yk' -O /tmp/Loft_FortClient_apps.zip
    cd /tmp
    unzip Loft_FortClient_apps.zip
    chmod -R 777 *.deb
    #dpkg -i forticlient_6.2.1.0272_amd64.deb
    apt --fix-broken install -y
    dpkg -i forticlient-sslvpn_4.4.2333-1_amd64.deb
    apt autoremove -y

    # [Instalacao do ]
    wget --no-check-certificate -r 'https://drive.google.com/file/d/1tL4P--RsCaQqicYDZum93VzC4x85NZ1r'  -O /tmp/falcon-sensor_6.14.0-11110_amd64.deb
    cd /tmp
    chmod 777 falcon-sensor_6.14.0-11110_amd64.deb
    dpkg -i falcon-sensor_6.14.0-11110_amd64.deb
    sudo /opt/CrowdStrike/falconctl -s --cid= *******-**
    service falcon-sensor start
    systemctl enable falcon-sensor --now
    ps -e | grep falcon-sensor

    wget https://download.teamviewer.com/download/linux/teamviewer_amd64.deb
    chmod 777 teamviewer_amd64.deb
    dpkg -i teamviewer_amd64.deb
    systemctl enable teamviewerd --now
    apt --fix-broken install -y

else
    echo "Please,run as root!"
    echo "Workstation NOT updated"
fi
