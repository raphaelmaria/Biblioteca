O comando `fsstat` faz parte do conjunto de ferramentas **The Sleuth Kit (TSK)**, utilizadas para análise forense de sistemas de arquivos. Para instalá-lo em sistemas baseados em Linux, como Ubuntu ou Debian, siga estas etapas:

---

### **1. Instalar o The Sleuth Kit**
O `fsstat` está incluído no pacote `sleuthkit`. Para instalá-lo:

#### Comando de instalação:
```bash
sudo apt update
sudo apt install sleuthkit -y
```

---

### **2. Verificar a instalação**
Após a instalação, verifique se o comando `fsstat` foi instalado corretamente:

```bash
fsstat --version
```

Isso deve exibir a versão do `The Sleuth Kit` ou uma mensagem de ajuda do comando.

---

### **3. Usar o fsstat**
O `fsstat` é usado para exibir informações detalhadas sobre o layout de um sistema de arquivos. Por exemplo:

```bash
fsstat /dev/sdX1
```

Substitua `/dev/sdX1` pelo caminho do dispositivo ou da partição que deseja analisar.

---

Se você estiver em um sistema onde o pacote `sleuthkit` não está disponível nos repositórios padrão, é possível instalá-lo manualmente a partir do código-fonte.

### **Instalação a partir do código-fonte (opcional)**
1. **Baixar o código-fonte do Sleuth Kit:**
   ```bash
   wget https://github.com/sleuthkit/sleuthkit/releases/download/sleuthkit-X.X.X/sleuthkit-X.X.X.tar.gz
   ```
   Substitua `X.X.X` pela versão mais recente disponível no [repositório oficial](https://github.com/sleuthkit/sleuthkit/releases).

2. **Extrair o arquivo e compilar:**
   ```bash
   tar -xzf sleuthkit-X.X.X.tar.gz
   cd sleuthkit-X.X.X
   ./configure
   make
   sudo make install
   ```

3. **Verificar a instalação:**
   ```bash
   fsstat --version
   ```

Com isso, o `fsstat` estará disponível para uso.