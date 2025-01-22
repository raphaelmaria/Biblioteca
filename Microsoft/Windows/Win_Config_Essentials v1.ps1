if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit}
Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Force -Confirm:$false
Set-ExecutionPolicy RemoteSigned -Force -Confirm:$false

# VARIEAVEIS EXTERNOS

# VARIAVEIS INTERNAS
$DATA = date

# Informaçoes da Maquina
$HostName = Get-ComputerInfo -Property CsCaption
$WinInfo = Get-ComputerInfo -Property WindowsProductName
$WinVersion = Get-ComputerInfo -Property OsArchitecture
$WinLanguage = Get-ComputerInfo -Property OsLanguage
$WinProcessador = Get-ComputerInfo -Property CsProcessors
#$WinMemoria = {Get-ComputerInfo -Property}
$WinGraphics = wmic path win32_VideoController get name

Start-Transcript -Path C:\StartAutoDeploy.txt -Append
Write-Host "Inventario do Computador" 
Write-Host "O nome do computador:" $HostName
Write-Host "O Sistema Operacional instalado:" $WinInfo
Write-Host "A Versao:" $WinVersion
Write-Host "Na Linguagem padrao:" $WinLanguage
Write-Host "Com base no processador:" $WinProcessador
#$WinMemoria
Write-Host "Com a placa de Video:" $WinGraphics

$RedeEXT = (Test-Connection 8.8.8.8 -Count 3 -Quiet)
if ($RedeEXT -eq "true"){
    Write-Host "Maquina conectada com a Internet" -ForegroundColor Green
    Write-Host "Efetuando Download do Conteudo Atualizado!"
#               Instalacao usando o Chocolaty como Repositorio
    Write-Host "Instalando Chocolaty Apps Manager"
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    Write-Host "Iniciando Instalacao de Aplicativos"

    # Install Winget Package
    $sourceAppInstaller = "https://github.com/microsoft/winget-cli/releases/download/v1.2.10271/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
    $sourceVCLibs = "https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx"
    Invoke-WebRequest -Uri $sourceVCLibs -OutFile Microsoft.VCLibs.x64.14.00.Desktop.appx
    Invoke-WebRequest -Uri $sourceAppInstaller -OutFile Microsoft.DesktopAppInstaller.msixbundle
    Add-appPackage -path "C:\Suporte\Microsoft.VCLibs.x64.14.00.Desktop.appx"
    Add-appPackage -path "C:\Suporte\Microsoft.DesktopAppInstaller.msixbundle"

    # INSTALACAO DE APLICATIVOS PADRONIZADOS E HOMOLOGADOS DENTRO DA LOFT
    winget install Google.Chrome -h --accept-package-agreements --accept-source-agreements
    winget install 7zip.7zip -h --accept-package-agreements --accept-source-agreements
    winget install Flameshot.Flameshot -h --accept-package-agreements --accept-source-agreements
    winget install pdfforge.PDFCreator -h --accept-package-agreements --accept-source-agreements
    winget install anydesk -h --accept-package-agreements --accept-source-agreements
    

    # LIMPEZA DE PASTAS - TEMPORARIAS
    Remove-Item c:\Suporte\*.exe -Recurse -Force -ErrorAction:SilentlyContinue
    Remove-Item c:\Suporte\*.msi -Recurse -Force -ErrorAction:SilentlyContinue
    Remove-Item "%UserProfile%\appdata\local\temp\*" -Recurse -Force
    cmd /c "dism /online /Enable-Feature /FeatureName:Internet-Explorer-Optional-amd64"

    Stop-Transcript
    exit
}else{
    Write-Host "Maquina sem acesso a internet!" -ForegroundColor Red
    Stop-Transcript
    exit
}


