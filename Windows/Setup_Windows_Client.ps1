if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit}
Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Force
Set-ExecutionPolicy RemoteSigned -Force

$DownloadOffice = 'https://mega.nz/file/JsIzlIaZ#y_73rzBceeD12ePfBxkLomWuZWVSSfAuVOSrsAIKBTQ'
$sourceVCLibs = "https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx"
$sourceAppInstaller = "https://rmtechfiles.s3.amazonaws.com/ScriptFiles/LOFT/workstation/Apps/Microsoft.DesktopAppInstaller.msixbundle"


$RedeEXT = (Test-Connection 8.8.8.8 -Count 3 -Quiet)
if ($RedeEXT -eq "true"){
#>_ Atualizacao do menu de Ajuda do Powershell
    Write-Host "Fazendo Atualizacao do HELP do POWERSHELL" | Update-Help 2>> .\Log.txt

    Write-Host "Maquina conectada com a Internet" -ForegroundColor Green
    Write-Host "Efetuando Download do Conteudo Atualizado!"
#>_ Mudando diretorio para pasta de Download.
    Set-Location $env:USERPROFILE\Downloads
#>_ Fazendo Download do Winget
    Invoke-WebRequest -Uri $sourceVCLibs -OutFile Microsoft.VCLibs.x64.14.00.Desktop.appx
    Invoke-WebRequest -Uri $sourceAppInstaller -OutFile Microsoft.DesktopAppInstaller.msixbundle
#>_ Instalando o Winget
    Add-AppPackage Microsoft.VCLibs.x64.14.00.Desktop.appx
    Add-AppxPackage Microsoft.DesktopAppInstaller.msixbundle
#>_ Instalando programas
    winget install --id AnyDeskSoftwareGmbH.AnyDesk -e --silent --accept-source-agreements --accept-package-agreements
    winget install --id BinaryMark.StreamingVideoDownloader -e --silent --accept-source-agreements --accept-package-agreements
    winget install --id RARLab.WinRAR -e --silent --accept-source-agreements --accept-package-agreements
    winget install --id Oracle.JavaRuntimeEnvironment -e --silent --accept-source-agreements --accept-package-agreements
    winget install --id VideoLAN.VLC -e --silent --accept-source-agreements --accept-package-agreements
    winget install --id Google.Chrome -e --silent --accept-source-agreements --accept-package-agreements
    winget install --id 7zip.7zip -e --silent --accept-source-agreements --accept-package-agreements
#>_ Fazendo download do Office
    Start-Process chrome.exe $DownloadOffice

}else{
    Write-Host "Maquina sem acesso a internet!" -ForegroundColor Red
}