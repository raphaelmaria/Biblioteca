#!/usr/bin/bash

#!/usr/bin/env bash

# Atualizar repositórios e instalar dependências
sudo apt update && sudo apt upgrade -y

# Instalar XFCE e XRDP
sudo apt install -y xfce4 xfce4-goodies xrdp

# Adicionar o usuário xrdp ao grupo ssl-cert para permitir o acesso ao certificado TLS
sudo adduser xrdp ssl-cert

# Configurar o XFCE como a interface padrão para o xrdp
echo "xfce4-session" | sudo tee /etc/skel/.xsession

# Configurar o XFCE para o usuário atual (opcional)
echo "xfce4-session" > ~/.xsession

# Ajustar as configurações do xrdp para usar o XFCE
sudo sed -i.bak '/^#XRDP_XORG|^#startwm.sh|/d' /etc/xrdp/startwm.sh
sudo tee -a /etc/xrdp/startwm.sh <<EOL
# Usar XFCE como interface
if [ -r /etc/X11/Xsession ]; then
  exec /usr/bin/xfce4-session
else
  exec /usr/bin/xfce4-session
fi
EOL

# Reiniciar o serviço XRDP para aplicar as configurações
sudo systemctl restart xrdp

# Informações para o usuário
echo "Instalação do XRDP e configuração do XFCE concluídas."
echo "Agora você pode se conectar ao servidor usando o IP do sistema na porta 3389."
