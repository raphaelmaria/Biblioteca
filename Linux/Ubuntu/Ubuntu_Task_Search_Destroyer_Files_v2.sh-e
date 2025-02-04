# Localizar todos os arquivos .nfo e listar seus caminhos
find /caminho/para/a/pasta/x -type f -name "*.nfo" | while read -r file; do
    echo "Caminho do arquivo encontrado: $file"
done

# Apagar todos os arquivos .nfo
find /caminho/para/a/pasta/x -type f -name "*.nfo" -exec rm {} \;
exit