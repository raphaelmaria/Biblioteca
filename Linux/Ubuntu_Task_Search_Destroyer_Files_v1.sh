#!/bin/bash

# Caminho para a pasta que você deseja pesquisar
folder_to_search=$(dialog --stdout --inputbox "Qual o caminha da pasta que será analisado: " 0 0)
type_files=$(dialog --stdout --inputbox "Qual é a extensão do arquivo: " 0 0)

# Localizar todos os arquivos .nfo e listar seus caminhos
here_files=($(find "$folder_to_search" -type f -name "*.$type_files"))
if [ ${#here_files[@]} -eq 0 ]; then
    echo "Nenhum arquivo .$type_files encontrado."
    exit 0
fi

echo "Arquivos .nfo encontrados:"
for here_file in "${here_files[@]}"; do
    echo "$here_file"
done

# Solicitar ao usuário que escolha entre apagar ou guardar a lista
read -p "Deseja apagar os arquivos .nfo? (Sim/Não): " user_choice

if [ "$user_choice" == "Sim" ] || [ "$user_choice" == "sim" ]; then
    # Apagar os arquivos .nfo
    for here_file in "${here_files[@]}"; do
        rm "$here_file"
    done
    echo "Arquivos .$type_files apagados com sucesso."
else
    # Nome do arquivo de lista com data e localização
    timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
    list_filename="${timestamp}_${folder_to_search}_Arquivos.$type_files.txt"

    # Crie o arquivo de lista
    echo "Lista de arquivos .$type_files salvos em 'temp/$list_filename':"
    for here_file in "${hre_files[@]}"; do
        echo "$here_file"
    done > "temp/$list_filename"

    echo "Lista de arquivos .$type_files salva em 'temp/$list_filename'."
fi
