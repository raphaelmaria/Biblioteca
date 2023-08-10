#!/bin/bash

# Configurações
bot_token="SEU_TOKEN_DO_BOT"
chat_id="SEU_CHAT_ID"
mensagem="Sua mensagem aqui"

# Envio da mensagem
curl -s -X POST "https://api.telegram.org/bot$bot_token/sendMessage" -d "chat_id=$chat_id" -d "text=$mensagem"


