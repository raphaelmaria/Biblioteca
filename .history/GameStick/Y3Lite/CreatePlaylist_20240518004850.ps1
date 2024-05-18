#MUDE A LETRA DA UNIDADE AQUI:
$unidUSB="f:"

# VARIAVEIS IMPORTANTES -- NÃO MEXE
$pathPlaylist="$unidUSB\playlist"
$pathATARI="$unidUSB\"
$pathCPS="$unidUSB\"
$pathFC=
$pathGB="$unidUSB\"
$pathGBC=
$pathGBA=
$pathMD=
$pathps1=
$pathSFC=
$pathSMS=
$pathZ64=
# FAZENDO BACKUP DA PLAYLIST ATUAL


# Caminho da pasta contendo os arquivos
$unidUSB = "F:"
$console = "ps1"

$caminho = "$unidUSB\roms\$console"
Write-Host "Rodando em cima do caminho: $caminho"

# Verifica se o caminho da pasta é válido
if (-not (Test-Path $caminho -PathType Container)) {
    Write-Host "O caminho da pasta não é válido."
    exit
}

# Obtém a lista de arquivos na pasta, excluindo arquivos com a extensão .png
$arquivos = Get-ChildItem $caminho | Where-Object { $_.Extension -ne ".png" }

# Inicializa uma lista para armazenar os nomes formatados dos arquivos
$listaArquivos = @()

# Itera sobre cada arquivo na pasta
foreach ($arquivo in $arquivos) {
    # Obtém o nome do arquivo (sem extensão)
    $nome = $arquivo.BaseName
    
    # Obtém a extensão do arquivo
    $extensao = $arquivo.Extension
    
    # Formata o nome do arquivo
    $nomeFormatado = "$nome$extensao <$nome>"
    
    # Adiciona o nome formatado à lista
    $listaArquivos += $nomeFormatado
}


# Caminho do arquivo de saída
$arquivoSaida = "$unidUSB\playlist\$console.pl"

# Escreve a lista formatada no arquivo de saída
$listaArquivos | Out-File -FilePath $arquivoSaida -Encoding utf8

Write-Host "Lista de arquivos foi salva em $arquivoSaida."
