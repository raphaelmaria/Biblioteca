#!\bin\bash
# Fonte de Pesquisa:https://www.vivaolinux.com.br/dica/Instalando-Microsoft-Edge-no-Debian-12


sudo apt update && sudo apt upgrade
sudo apt install wget software-properties-common apt-transport-https curl ca-certificates
echo 'deb [signed-by=/usr/share/keyrings/microsoft-edge.gpg] https://packages.microsoft.com/repos/edge stable main' | sudo tee /etc/apt/sources.list.d/microsoft-edge.list
curl -fSsL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /usr/share/keyrings/microsoft-edge.gpg > /dev/null
sudo apt update && sudo apt upgrade
sudo apt install microsoft-edge-stable
