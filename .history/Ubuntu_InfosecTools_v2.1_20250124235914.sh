#!/bin/bash
# Revisado pelo CHAT
# Saída em caso de erro
set -e

# Variáveis
UBUNTU_PRO_KEY="C12wuWBwsaqFpf636EhNB61H9wkmQy"
KALI_REPO="http://http.kali.org/kali"
KALI_KEY="https://archive.kali.org/archive-key.asc"

echo "### Iniciando script de configuração ###"

# Registrar o Ubuntu PRO
if ! pro status &>/dev/null; then
    echo "Registrando Ubuntu PRO..."
    sudo pro attach "$UBUNTU_PRO_KEY"
fi

# Atualização inicial e repositórios essenciais
echo "Atualizando sistema e configurando repositórios..."
sudo apt update && sudo apt upgrade -y
sudo apt install -y software-properties-common curl apt-transport-https gnupg

# Ativando repositório Universe
sudo add-apt-repository -y universe

# Adicionando repositório Kali
if ! grep -q "kali.org" /etc/apt/sources.list; then
    echo "Adicionando repositório Kali..."
    echo "deb $KALI_REPO kali-rolling main contrib non-free" | sudo tee -a /etc/apt/sources.list
    curl -fsSL $KALI_KEY | sudo gpg --dearmor -o /usr/share/keyrings/kali-archive-keyring.gpg
fi

# Atualizando novamente após adicionar repositórios
sudo apt update

# Instalação de pacotes essenciais
echo "Instalando pacotes essenciais..."
sudo apt install -y vim git terminator glances gcc unzip wget ansible \
    openssh-server make gpg dnsutils net-tools python3 python3-pip python3-venv \
    dkms tar dialog xz-utils tshark wireshark sqlmap aircrack-ng hashcat nmap metasploit-framework

# Remoção de Snapd
if command -v snap &>/dev/null; then
    echo "Removendo Snapd..."
    sudo apt -y remove snapd && sudo apt autoremove -y
fi

# Configuração do Flatpak
if ! command -v flatpak &>/dev/null; then
    echo "Instalando Flatpak..."
    sudo apt install -y flatpak gnome-software-plugin-flatpak
    sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
fi

# Instalação de ferramentas de segurança (Kali Tools)
echo "Instalando ferramentas de segurança..."
sudo apt install -y hydra ncat nmap sqlmap aircrack-ng ettercap-text-only wifite nikto \
    netdiscover crunch wpscan john tcpdump bettercap gobuster subfinder dirb dnsrecon \
    masscan yara crackmapexec theharvester recon-ng medusa burpsuite

# Limpeza de pacotes desnecessários
echo "Limpando pacotes desnecessários..."
sudo apt autoremove -y && sudo apt clean

# Log final
echo "### Configuração concluída com sucesso! ###"
