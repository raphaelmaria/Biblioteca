#!/bin/bash

# Certifique-se de rodar o script como root
if [ "$EUID" -ne 0 ]; then
  echo "Por favor, execute como root."
  exit
fi

echo "Atualizando repositórios..."
apt update -y && apt upgrade -y

echo "Instalando dependências básicas..."
apt install -y \
  build-essential \
  python3 \
  python3-pip \
  python3-venv \
  git \
  wget \
  curl \
  unzip \
  virtualenv \
  openjdk-11-jdk \
  libssl-dev \
  zlib1g-dev \
  libffi-dev \
  net-tools

echo "Instalando ferramentas forenses..."

# 1. Autopsy
echo "Instalando Autopsy..."
apt install -y sleuthkit
wget -qO- https://downloads.autopsy.com/autopsy-4.21.0.zip -O autopsy.zip
unzip autopsy.zip -d /opt/autopsy
rm autopsy.zip
chmod +x /opt/autopsy/autopsy

# 2. FTK (Necessita download manual e licença)
echo "FTK não pode ser instalado automaticamente. Visite https://accessdata.com para download."

# 3. EnCase (Necessita download manual e licença)
echo "EnCase não pode ser instalado automaticamente. Visite https://encase.com para download."

# 4. X-Ways (Necessita download manual e licença)
echo "X-Ways não pode ser instalado automaticamente. Visite https://x-ways.net para download."

# 5. Wireshark
echo "Instalando Wireshark..."
apt install -y wireshark
usermod -aG wireshark $USER

# 6. NetworkMiner (Necessita Wine para rodar no Linux)
echo "Instalando Wine para NetworkMiner..."
apt install -y wine
wget -qO- https://www.netresec.com/?download=NetworkMiner | grep -oP 'https://netresec[^"]+' | head -1 | xargs wget -O /opt/networkminer.zip
unzip /opt/networkminer.zip -d /opt/networkminer
rm /opt/networkminer.zip

# 7. tcpdump
echo "Instalando tcpdump..."
apt install -y tcpdump

# 8. Volatility Framework
echo "Instalando Volatility Framework..."
pip3 install volatility3

# 9. Redline (Necessita Wine para rodar no Linux)
echo "Baixando Redline..."
wget -qO- https://www.mandiant.com/resources/redline-download | grep -oP 'https://dl.mandiant[^"]+' | xargs wget -O /opt/redline.zip
unzip /opt/redline.zip -d /opt/redline
rm /opt/redline.zip

# 10. Cuckoo Sandbox
echo "Instalando Cuckoo Sandbox..."
pip3 install cuckoo

# 11. Cellebrite UFED (Necessita licença)
echo "Cellebrite UFED não pode ser instalado automaticamente. Visite https://cellebrite.com para mais detalhes."

# 12. Magnet AXIOM (Necessita licença)
echo "Magnet AXIOM não pode ser instalado automaticamente. Visite https://www.magnetforensics.com para mais detalhes."

# 13. RegRipper
echo "Instalando RegRipper..."
git clone https://github.com/keydet89/RegRipper3.0.git /opt/regripper
chmod +x /opt/regripper/*.pl

# 14. Plaso (Log2Timeline)
echo "Instalando Plaso..."
pip3 install plaso

# 15. Bulk Extractor
echo "Instalando Bulk Extractor..."
apt install -y bulk-extractor

echo "Instalação concluída!"

echo "Algumas ferramentas requerem configuração ou licenças manuais. Consulte as instruções de cada uma."
