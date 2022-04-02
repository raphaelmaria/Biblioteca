if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit}
Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Force
Set-ExecutionPolicy RemoteSigned -Force

#Update do HELP
Write-Host "Fazendo Atualizacao do HELP do POWERSHELL" | Update-Help 2>> .\Log.txt

Set-Location $env:USERPROFILE\Downloads
#Instala dependencia do Winget 
$sourceVCLibs = "https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx"
Invoke-WebRequest -Uri $sourceVCLibs -OutFile Microsoft.VCLibs.x64.14.00.Desktop.appx
Add-AppPackage Microsoft.VCLibs.x64.14.00.Desktop.appx


#Instala Winget

$sourceAppInstaller = "https://rmtechfiles.s3.amazonaws.com/ScriptFiles/LOFT/workstation/Apps/Microsoft.DesktopAppInstaller.msixbundle"
Invoke-WebRequest -Uri $sourceAppInstaller -OutFile Microsoft.DesktopAppInstaller.msixbundle
Add-AppxPackage Microsoft.DesktopAppInstaller.msixbundle


$RedeEXT = (Test-Connection 8.8.8.8 -Count 3 -Quiet)
if ($RedeEXT -eq "true"){
    Write-Host "Maquina conectada com a Internet" -ForegroundColor Green
    Write-Host "Efetuando Download do Conteudo Atualizado!"
                winget install --id AnyDeskSoftwareGmbH.AnyDesk -e --silent --accept-source-agreements --accept-package-agreements
                winget install --id BinaryMark.StreamingVideoDownloader -e --silent --accept-source-agreements --accept-package-agreements
                winget install --id RARLab.WinRAR -e --silent --accept-source-agreements --accept-package-agreements
                winget install --id Oracle.JavaRuntimeEnvironment -e --silent --accept-source-agreements --accept-package-agreements
                winget install --id VideoLAN.VLC -e --silent --accept-source-agreements --accept-package-agreements
                winget install --id Google.Chrome -e --silent --accept-source-agreements --accept-package-agreements
                winget install --id 7zip.7zip -e --silent --accept-source-agreements --accept-package-agreements
}else{
    Write-Host "Maquina sem acesso a internet!" -ForegroundColor Red
}

$DownloadOffice = 'https://mega.nz/file/JsIzlIaZ#y_73rzBceeD12ePfBxkLomWuZWVSSfAuVOSrsAIKBTQ'
$DownloadAtivador = 'https://mega.nz/file/484AVaLC#ccIQT0rY1ckw6-7i7s5kLgRakp-PPwKw9BDAK-Oo4sM'
Start-Process chrome.exe $DownloadOffice
Start-Process chrome.exe $DownloadAtivador


