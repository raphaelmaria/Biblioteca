#!/bin/bash

# Defina suas credenciais da API do WhatsApp Business
TOKEN="seu_token"
ID="seu_id"

# Função para enviar a mensagem
enviar_mensagem_whatsapp() {
    local nome="$1"
    local numero="$2"
    local apt="$3"
    local torre="$4"
    local vaga_sorteada="$5"
    local mensagem="Olá $nome, a vaga de moto $vaga_sorteada foi sorteada e atribuída para você. Seu apartamento é o $apt, torre $torre."
    
    # Substitua "mensagem" pela mensagem que você quer enviar
    mensagem_json=$(jq -n --arg msg "$mensagem" '{ "phone": "'$numero'", "message": "$msg" }')
    
    # Envie a mensagem usando a API do WhatsApp Business
    curl -X POST -H "Content-Type: application/json" -H "Authorization: Bearer $TOKEN" -d "$mensagem_json" "https://api.chat-api.com/instance/$ID/sendMessage"
}

# Ler o arquivo CSV e enviar mensagens
while IFS=, read -r nome numero apt torre vaga_sorteada; do
    enviar_mensagem_whatsapp "$nome" "$numero" "$apt" "$torre" "$vaga_sorteada"
done < dados.csv
