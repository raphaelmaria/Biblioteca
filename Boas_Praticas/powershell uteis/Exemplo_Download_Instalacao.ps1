# Exemplo de script PowerShell para instalar um aplicativo

# Definir o caminho de download e instalação do aplicativo
$downloadUrl = "URL_do_instalador_ou_caminho_local"
$installPath = "C:\Caminho\para\instalação"

# Baixar o arquivo de instalação
$downloadPath = "C:\Caminho\para\download\aplicativo.exe"
Invoke-WebRequest -Uri $downloadUrl -OutFile $downloadPath

# Instalar o aplicativo
Start-Process -FilePath $downloadPath -ArgumentList "/S" -Wait

# Remover o arquivo de instalação, se desejado
# Remove-Item -Path $downloadPath