Para instalar o **Whisper** como um serviço no Linux e garantir que ele esteja sempre rodando em segundo plano, siga este guia:

---

### **1. Instalar o Whisper e Dependências**
Antes de configurar como serviço, instale o **Whisper** e suas dependências:

```bash
sudo apt update && sudo apt install -y python3 python3-pip ffmpeg
pip3 install --upgrade pip
pip3 install openai-whisper
```

Teste se a instalação está funcionando corretamente:
```bash
whisper --help
```

---

### **2. Criar um Script para Executar o Whisper**
Crie um script em `/usr/local/bin/whisper_service.sh`:

```bash
sudo nano /usr/local/bin/whisper_service.sh
```

Adicione o seguinte conteúdo (modifique conforme necessário para sua aplicação):

```bash
#!/bin/bash

# Caminho da pasta onde os áudios serão processados
INPUT_DIR="/mnt/hd/audios"
OUTPUT_DIR="/mnt/hd/transcricoes"

# Garante que a pasta de saída existe
mkdir -p "$OUTPUT_DIR"

# Loop infinito para monitorar novos arquivos
while true; do
    for file in "$INPUT_DIR"/*.mp3 "$INPUT_DIR"/*.wav; do
        [ -e "$file" ] || continue  # Se não houver arquivos, continue

        echo "Processando: $file"
        whisper "$file" --model medium --output_dir "$OUTPUT_DIR"

        # Mover ou deletar arquivo processado para evitar reprocessamento
        mv "$file" "$OUTPUT_DIR/"
    done

    sleep 10  # Evita alto consumo de CPU
done
```

Salve (`CTRL+X`, `Y`, `ENTER`) e torne o script executável:

```bash
sudo chmod +x /usr/local/bin/whisper_service.sh
```

---

### **3. Criar um Serviço Systemd**
Agora, crie um arquivo de serviço no **systemd**:

```bash
sudo nano /etc/systemd/system/whisper.service
```

Adicione o seguinte conteúdo:

```ini
[Unit]
Description=Whisper Transcription Service
After=network.target

[Service]
ExecStart=/usr/local/bin/whisper_service.sh
Restart=always
User=root
WorkingDirectory=/usr/local/bin
StandardOutput=append:/var/log/whisper.log
StandardError=append:/var/log/whisper_error.log

[Install]
WantedBy=multi-user.target
```

Salve (`CTRL+X`, `Y`, `ENTER`).

---

### **4. Ativar e Iniciar o Serviço**
Agora, ative e inicie o serviço:

```bash
sudo systemctl daemon-reload
sudo systemctl enable whisper
sudo systemctl start whisper
```

Para verificar se está rodando corretamente:

```bash
sudo systemctl status whisper
```

Caso precise parar ou reiniciar:

```bash
sudo systemctl stop whisper
sudo systemctl restart whisper
```

---

### **5. Monitorar Logs**
Se precisar verificar logs:

```bash
tail -f /var/log/whisper.log
```

Se houver erros:

```bash
tail -f /var/log/whisper_error.log
```

---

### **Conclusão**
Agora o **Whisper** está configurado como um serviço, rodando automaticamente no boot e processando arquivos de áudio na pasta definida. 🚀