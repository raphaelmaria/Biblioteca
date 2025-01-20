O **Autopsy** é uma ferramenta forense digital usada para analisar discos, recuperar arquivos e investigar incidentes cibernéticos. Aqui está um guia completo sobre como instalar e usar o Autopsy em sistemas Linux (como Ubuntu/Debian) e Windows.

---

## **1. Instalação no Linux**

### **Passo 1: Atualize o sistema**
```bash
sudo apt update && sudo apt upgrade -y
```

### **Passo 2: Instale as dependências necessárias**
```bash
sudo apt install openjdk-11-jdk maven tcl8.6 libtsk13 sleuthkit tcllib git -y
```

### **Passo 3: Baixe o Autopsy**
Clone o repositório oficial do Autopsy:
```bash
git clone https://github.com/sleuthkit/autopsy.git
```

### **Passo 4: Compile o Autopsy**
Entre no diretório do Autopsy e compile o código:
```bash
cd autopsy
sudo ./unix_setup.sh
```

### **Passo 5: Inicie o Autopsy**
Depois de instalado, inicie o Autopsy com o comando:
```bash
./bin/autopsy
```

---

## **2. Instalação no Windows**

1. **Baixe o instalador oficial do Autopsy**:
   - Acesse [https://www.autopsy.com/download/](https://www.autopsy.com/download/).
   - Baixe a versão mais recente do instalador.

2. **Execute o instalador**:
   - Dê um duplo clique no arquivo baixado e siga as instruções na tela.

3. **Complete a instalação**:
   - Escolha o diretório de instalação e finalize o processo.

4. **Inicie o Autopsy**:
   - Abra o aplicativo pelo atalho criado no menu Iniciar.

---

## **3. Usando o Autopsy**

### **Passo 1: Criar um Caso**
- Ao abrir o Autopsy, escolha **"Create New Case"**.
- Insira um nome para o caso, um diretório para armazenar os dados e outras informações necessárias.

### **Passo 2: Adicionar uma Imagem ou Disco**
- Após criar o caso, clique em **"Add Data Source"**.
- Escolha o tipo de fonte de dados:
  - **Image File**: Arquivos como `.dd`, `.img`, ou `.iso`.
  - **Local Disk**: Um disco físico conectado ao sistema.
  - **Logical Files**: Pastas ou arquivos específicos.

### **Passo 3: Configurar a Análise**
- Selecione os módulos que deseja executar, como:
  - **Keyword Search**: Busca por palavras-chave.
  - **Hash Lookup**: Identificação de arquivos conhecidos (como malwares).
  - **File Type Identification**: Classificação de arquivos por tipo.
  - **Email Parser**: Análise de e-mails.

### **Passo 4: Analisar os Resultados**
- Após a execução dos módulos, navegue pelos resultados na interface.
- Use as seções, como **File Types**, **Keyword Hits**, e **Deleted Files**, para explorar os dados.

### **Passo 5: Gerar Relatórios**
- Após concluir a análise, você pode gerar relatórios clicando em **"Generate Report"**.
- Escolha o formato (HTML, PDF, CSV) e as informações a incluir.

---

## **4. Dicas e Boas Práticas**

- **Permissões Adequadas**: Certifique-se de rodar o Autopsy com permissões administrativas, especialmente ao acessar discos físicos.
- **Armazenamento Suficiente**: O diretório do caso pode crescer rapidamente dependendo do tamanho da imagem e dos módulos usados.
- **Atualizações**: Mantenha o Autopsy e o Sleuth Kit atualizados para obter suporte às últimas funcionalidades e formatos de arquivos.
- **Exporte Logs**: Sempre salve os logs e relatórios para referência futura.
- **Use em Ambiente Controlado**: Evite usar o Autopsy em sistemas que possam interferir na integridade das evidências.

---

Com o **Autopsy**, é possível realizar investigações robustas de discos, analisar sistemas de arquivos e descobrir evidências digitais de forma eficiente e detalhada.