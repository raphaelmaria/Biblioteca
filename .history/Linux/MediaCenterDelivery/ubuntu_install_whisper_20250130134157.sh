#!/bin/bash

# Atualiza o sistema e instala dependências
sudo apt update && sudo apt install -y python3 python3-pip ffmpeg

# Instala o Whisper
pip3 install --upgrade pip
pip3 install openai-whisper

# Verifica se a instalação foi bem-sucedida
if ! command -v whisper &> /dev/null; then
    echo "Erro: Whisper não foi instalado corretamente."
    exit 1
fi

# Define diretórios para áudios e transcrições
INPUT_DIR="/mnt/hd2/Temporario/lixeira/audios"
OUTPUT_DIR="/mnt/hd2/Temporario/lixeira/transcricoes"

# Cria os diretórios caso não existam
sudo mkdir -p "$INPUT_DIR" "$OUTPUT_DIR"

# Cria o script de execução do serviço
SERVICE_SCRIPT="/var/scripts/.sh"
echo "#!/bin/bash
while true; do
    for file in \"$INPUT_DIR\"/*.mp3 \"$INPUT_DIR\"/*.wav; do
        [ -e \"$file\" ] || continue  # Se não houver arquivos, continue
        echo \"Processando: $file\"
        whisper \"$file\" --model medium --output_dir \"$OUTPUT_DIR\"
        mv \"$file\" \"$OUTPUT_DIR/\"
    done
    sleep 10
done" | sudo tee "$SERVICE_SCRIPT" > /dev/null

# Torna o script executável
sudo chmod +x "$SERVICE_SCRIPT"

# Cria o arquivo de serviço do systemd
SERVICE_FILE="/etc/systemd/system/whisper.service"
echo "[Unit]
Description=Whisper Transcription Service
After=network.target

[Service]
ExecStart=$SERVICE_SCRIPT
Restart=always
User=root
WorkingDirectory=/usr/local/bin
StandardOutput=append:/var/log/whisper.log
StandardError=append:/var/log/whisper_error.log

[Install]
WantedBy=multi-user.target" | sudo tee "$SERVICE_FILE" > /dev/null

# Recarrega o systemd, ativa e inicia o serviço
sudo systemctl daemon-reload
sudo systemctl enable whisper
sudo systemctl start whisper

# Exibe status do serviço
sudo systemctl status whisper