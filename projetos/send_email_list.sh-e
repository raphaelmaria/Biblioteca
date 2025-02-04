#!/bin/bash

# Verifica se o arquivo de lista de e-mails foi fornecido como argumento
if [ $# -ne 1 ]; then
  echo "Uso: $0 arquivo_de_emails.txt"
  exit 1
fi

# Nome do arquivo de lista de e-mails
email_list_file="$1"

# Verifica se o arquivo de lista de e-mails existe
if [ ! -f "$email_list_file" ]; then
  echo "Arquivo de lista de e-mails não encontrado: $email_list_file"
  exit 1
fi

# Loop para ler e-mails do arquivo e enviar a mensagem
while IFS= read -r email; do
  # Envia a mensagem para o e-mail atual
  echo "Testando o envio para: $email"
  echo "Teste de envio de e-mail." | mail -s "Teste de e-mail" "$email"
done < "$email_list_file"

echo "Envio de mensagens concluído."