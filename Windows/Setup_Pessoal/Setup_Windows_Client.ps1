if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit}
Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Force
Set-ExecutionPolicy RemoteSigned -Force

#Update do HELP
Write-Host "Fazendo Atualizacao do HELP do POWERSHELL" | Update-Help 2>> .\Log.txt

$RedeEXT = (Test-Connection 8.8.8.8 -Count 3 -Quiet)
if ($RedeEXT -eq "true"){
    Write-Host "Maquina conectada com a Internet" -ForegroundColor Green
    Write-Host "Efetuando Download do Conteudo Atualizado!"
#               Instalacao usando o Chocolaty como Repositorio
    Write-Host "Instalando Chocolaty Apps Manager"
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    Write-Host "Iniciando Instalacao de Aplicativos"
                choco install anydesk.install -dvfy
                choco install silverlight -dvfy
                choco install dotnet4.7.2 -dvfy
                choco install vcredist2005 -dvfy
                choco install vcredist2008 -dvfy
                choco install vcredist2012 -dvfy
                choco install vcredist2013 -dvfy
                choco install vcredist2015 -dvfy
                choco install vcredist2017 -dvfy
                choco install vcredist140 -dvfy
                choco install googlechrome -dvfy 
                choco install adobereader -dvfy
                choco install 7zip.install -dvfy
                choco install winrar -dvfy
                choco install jre8 -dvfy
                choco install lightshot.install -dvfy
                choco install vlc -dvfy

                #INSTALACAO JUMPCLOUD 
                cd $env:temp | Invoke-Expression; Invoke-RestMethod -Method Get -URI https://raw.githubusercontent.com/TheJumpCloud/support/master/scripts/windows/InstallWindowsAgent.ps1 -OutFile InstallWindowsAgent.ps1 | Invoke-Expression; ./InstallWindowsAgent.ps1 -JumpCloudConnectKey "251cff6c6c7ec83f6068fe3afc5d063d94855b61"
}else{
    Write-Host "Maquina sem acesso a internet!" -ForegroundColor Red
}

$DownloadOffice = 'https://mega.nz/file/JsIzlIaZ#y_73rzBceeD12ePfBxkLomWuZWVSSfAuVOSrsAIKBTQ'
$DownloadAtivador = 'https://mega.nz/file/484AVaLC#ccIQT0rY1ckw6-7i7s5kLgRakp-PPwKw9BDAK-Oo4sM'
Start-Process chrome.exe $DownloadOffice
Start-Process chrome.exe $DownloadAtivador


