Aqui está um guia completo para rodar o **Whisper ASR** como um endpoint HTTP usando **Docker**. Isso permitirá que você acesse o Whisper via API em qualquer máquina conectada à rede.

---

## **1. Criar o Dockerfile**
Crie um diretório para o projeto e entre nele:

```bash
mkdir whisper-asr-docker && cd whisper-asr-docker
```

Crie um arquivo chamado `Dockerfile`:

```bash
nano Dockerfile
```

Adicione o seguinte conteúdo:

```dockerfile
FROM python:3.10

# Instala dependências
RUN apt update && apt install -y ffmpeg && rm -rf /var/lib/apt/lists/*

# Define o diretório de trabalho
WORKDIR /app

# Instala as dependências do Whisper
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copia o código da API para o container
COPY whisper_api.py .

# Expõe a porta do serviço
EXPOSE 9000

# Executa o servidor
CMD ["python", "whisper_api.py"]
```

---

## **2. Criar o arquivo de dependências**
Crie um arquivo `requirements.txt`:

```bash
nano requirements.txt
```

Adicione:

```
flask
flask-cors
openai-whisper
```

---

## **3. Criar o código da API**
Agora, crie o arquivo `whisper_api.py`:

```bash
nano whisper_api.py
```

Adicione o seguinte código:

```python
from flask import Flask, request, jsonify
import whisper
import os

app = Flask(__name__)

# Carrega o modelo do Whisper
model = whisper.load_model("medium")

@app.route("/transcribe", methods=["POST"])
def transcribe():
    if "file" not in request.files:
        return jsonify({"error": "Nenhum arquivo enviado"}), 400

    file = request.files["file"]
    filepath = f"/tmp/{file.filename}"
    file.save(filepath)

    # Transcreve o áudio
    result = model.transcribe(filepath)

    # Remove o arquivo temporário
    os.remove(filepath)

    return jsonify({"text": result["text"]})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=9000)
```

---

## **4. Construir e Rodar o Container**
Agora, construa a imagem Docker:

```bash
docker build -t whisper-asr .
```

Depois, execute o container na porta **9000**:

```bash
docker run -d -p 9000:9000 --name whisper_api whisper-asr
```

---

## **5. Testar o Endpoint**
Agora você pode enviar um arquivo de áudio para transcrição via **cURL**:

```bash
curl -X POST -F "file=@audio.mp3" http://localhost:9000/transcribe
```

Se estiver acessando de outro computador na rede, substitua `localhost` pelo IP da máquina que está rodando o Docker.

---

## **6. Parar e Remover o Container**
Para parar o serviço:

```bash
docker stop whisper_api
```

Para remover o container:

```bash
docker rm whisper_api
```

Para remover a imagem:

```bash
docker rmi whisper-asr
```

---

Agora você tem o **Whisper rodando como um endpoint HTTP via Docker**! 🚀