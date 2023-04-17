#!/bin/bash

# Define a URL do VS Code
URL="https://az764295.vo.msecnd.net/stable/..."
# A URL pode ser encontrada em https://code.visualstudio.com/download

# Faz o download do pacote .deb do VS Code
wget $URL -O /tmp/vscode.deb

# Instala o pacote .deb do VS Code
sudo apt install /tmp/vscode.deb

# Define o caminho do script de atualização
UPDATE_SCRIPT=/usr/local/bin/vscode-update.sh

# Cria o script de atualização
echo '#!/bin/bash' > $UPDATE_SCRIPT
echo "URL=\"$URL\"" >> $UPDATE_SCRIPT
echo 'TMP_FILE=$(mktemp)' >> $UPDATE_SCRIPT
echo 'wget $URL -O $TMP_FILE' >> $UPDATE_SCRIPT
echo 'if dpkg -i $TMP_FILE | grep -q "already installed"; then' >> $UPDATE_SCRIPT
echo '  echo "No update available"' >> $UPDATE_SCRIPT
echo 'else' >> $UPDATE_SCRIPT
echo '  echo "VS Code updated. Restarting."' >> $UPDATE_SCRIPT
echo '  pkill -f "code ."' >> $UPDATE_SCRIPT
echo '  dpkg -i $TMP_FILE' >> $UPDATE_SCRIPT
echo '  code .' >> $UPDATE_SCRIPT
echo 'fi' >> $UPDATE_SCRIPT

# Define a tarefa para atualizar o VS Code semanalmente
(crontab -l ; echo "0 0 * * 0 $UPDATE_SCRIPT") | crontab -

# Abre o VS Code
code .
