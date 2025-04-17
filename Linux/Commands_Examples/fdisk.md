O `fdisk` é uma ferramenta de manipulação de tabelas de partição disponível em sistemas Linux. Na área de **forense digital**, o `fdisk` é frequentemente usado como uma ferramenta inicial para coletar informações sobre a estrutura das partições de um dispositivo de armazenamento suspeito, sem fazer alterações nos dados.

### **1. O que é o `fdisk`?**
O `fdisk` é usado para gerenciar tabelas de partição em discos. Ele suporta formatos de tabela de partição como MBR (Master Boot Record) e GPT (GUID Partition Table). No contexto forense, o foco é explorar e documentar o layout do disco.

---

### **2. Uso Forense do `fdisk`**
No trabalho forense, `fdisk` é usado principalmente para **analisar** (não modificar) as informações do disco. Aqui estão os passos típicos:

#### **a. Listar os discos disponíveis**
```bash
sudo fdisk -l
```

Este comando exibe:
- Tamanho total de cada disco.
- Layout das partições (início, fim, tamanho, tipo de partição).
- Sistema de arquivos usado em cada partição.

#### **b. Examinar um disco específico**
```bash
sudo fdisk /dev/sdX
```
Substitua `/dev/sdX` pelo disco que deseja investigar. No modo interativo, você pode digitar `p` para **imprimir** a tabela de partições.

---

### **3. Informações Coletadas com o `fdisk`**
Ao usar o `fdisk`, você pode coletar:
- **Lista de partições:** Identifica quais partições estão no disco e seus tipos.
- **Offsets das partições:** Onde cada partição começa e termina.
- **Tipos de partição:** Como NTFS, FAT32, ext4, etc., que ajudam a determinar o uso e o tipo de sistema de arquivos.
- **Tamanho das partições:** Para identificar possíveis áreas não alocadas.
- **Informações sobre tabelas de partição corrompidas ou suspeitas:** Se o `fdisk` detectar inconsistências, isso pode ser um sinal de manipulação ou dano ao disco.

---

### **4. Vantagens do `fdisk` na Forense**
- **Leitura-Only (por padrão):** Desde que você não execute comandos de escrita, o `fdisk` é seguro para coletar informações sem alterar dados.
- **Compatibilidade Universal:** Funciona com a maioria dos discos e tipos de partições.
- **Simplicidade:** Fácil de usar para visualização rápida de informações.

---

### **5. Limitações do `fdisk`**
- **Não fornece detalhes sobre os arquivos:** Apenas lida com tabelas de partição e não inspeciona sistemas de arquivos ou dados armazenados.
- **Incompatibilidade com discos virtuais:** Não suporta completamente discos de máquinas virtuais.
- **Riscos de escrita acidental:** Se comandos de modificação forem usados por engano (como criar ou excluir partições), podem causar danos.

---

### **6. Uso Prático em um Cenário Forense**
Imagine um analista investigando um disco suspeito:
1. **Identificar o layout de partição:**
   ```bash
   sudo fdisk -l /dev/sdX
   ```
2. **Registrar informações críticas:**
   - Registrar os offsets das partições para análise posterior com ferramentas como `dd` ou `sleuthkit`.
3. **Analisar partições desconhecidas:**
   Após identificar uma partição, o analista pode usar outras ferramentas, como `fsstat` ou `file`, para inspecionar os sistemas de arquivos e dados contidos.

---

### **Conclusão**
O `fdisk` é uma ferramenta essencial para iniciar a análise forense de discos em Linux. Ele oferece uma visão detalhada da estrutura de partições, ajudando analistas a mapear o disco sem alterar os dados. Quando combinado com outras ferramentas, como `dd` para cópia bit a bit ou `sleuthkit` para análise de sistemas de arquivos, o `fdisk` se torna uma parte crucial do conjunto de ferramentas forenses.


No Linux, o uso do `fdisk` em relação a **offsets** está principalmente relacionado à identificação e gerenciamento de partições. No entanto, para manipular ou investigar uma partição a partir de um **offset** específico, o `fdisk` pode ajudar a identificar os offsets das partições. Depois, você pode usar outras ferramentas, como `dd` ou `losetup`, para trabalhar diretamente com esses offsets.

---

### **1. Como Identificar Offsets com `fdisk`**

O comando `fdisk -l` exibe informações sobre partições, incluindo seus **setores de início** e **tamanhos**. 

#### **Comando básico:**
```bash
sudo fdisk -l /dev/sdX
```

#### **Exemplo de saída:**
```plaintext
Disk /dev/sda: 128 GB, 128849018880 bytes, 251658240 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 512 bytes / 4096 bytes
Disklabel type: dos
Disk identifier: 0x12345678

Device     Boot  Start       End   Sectors   Size Id Type
/dev/sda1  *     2048    999423    997376   487M 83 Linux
/dev/sda2       999424 251658239 250658816 119.6G 83 Linux
```

Na saída:
- **Start** indica o **offset inicial** de cada partição, em setores.
- **Sectors** indica o tamanho da partição, também em setores.

O **offset em bytes** pode ser calculado como:
```plaintext
Offset (bytes) = Start (setores) × Tamanho do setor (em bytes)
```

No exemplo:
- A partição `/dev/sda1` começa no setor `2048`.
- Tamanho do setor = 512 bytes.
- Offset em bytes = `2048 × 512 = 1048576` bytes (1 MiB).

---

### **2. Trabalhando com o Offset**

Depois de identificar o offset, você pode usar ferramentas para trabalhar com ele:

#### **a. Montar diretamente uma partição a partir do offset**
1. **Criar um loop device usando `losetup`:**
   ```bash
   sudo losetup --offset $((2048 * 512)) --show -f /dev/sda
   ```
   Isso cria um dispositivo de loop a partir do offset específico da partição.

2. **Montar o dispositivo de loop:**
   ```bash
   sudo mount /dev/loopX /mnt
   ```
   Substitua `/dev/loopX` pelo dispositivo retornado pelo `losetup`.

#### **b. Extrair dados de uma partição com `dd`:**
1. **Extrair a partição para análise:**
   ```bash
   sudo dd if=/dev/sda of=particao_sda1.img bs=512 skip=2048 count=997376
   ```
   - `if=/dev/sda`: Disco de entrada.
   - `of=particao_sda1.img`: Arquivo de saída.
   - `bs=512`: Tamanho do setor.
   - `skip=2048`: Pular os primeiros 2048 setores (offset).
   - `count=997376`: Quantidade de setores a copiar (tamanho da partição).

2. **Analisar a imagem extraída com ferramentas forenses, como `fsstat` ou `strings`:**
   ```bash
   fsstat particao_sda1.img
   ```

---

### **3. Modificando Tabelas de Partição com Offsets**

Se você precisa **modificar tabelas de partição** com base em offsets, `fdisk` oferece comandos interativos:

1. **Iniciar o `fdisk` em um disco:**
   ```bash
   sudo fdisk /dev/sdX
   ```

2. **Comandos úteis:**
   - `p`: Exibir a tabela de partição atual.
   - `d`: Excluir uma partição.
   - `n`: Criar uma nova partição (você pode definir o setor inicial manualmente).
   - `w`: Salvar as alterações e sair.

---

### **4. Caso de Uso Forense**

Na análise forense:
- O `fdisk` é usado para documentar a estrutura do disco e os offsets das partições.
- Ferramentas como `dd` e `losetup` são usadas para isolar e examinar partições específicas sem alterar os dados originais.

Exemplo de fluxo forense:
1. Identificar partições com `fdisk -l`.
2. Isolar partições por offset usando `dd` ou `losetup`.
3. Montar ou analisar os dados usando ferramentas de análise.

---

### **Conclusão**

Embora o `fdisk` não manipule diretamente os dados em um offset específico, ele é fundamental para identificar a estrutura do disco e calcular offsets para análises mais profundas. Com ferramentas complementares, como `dd` e `losetup`, você pode trabalhar diretamente com os offsets para montagem, cópia e investigação de partições em casos forenses.