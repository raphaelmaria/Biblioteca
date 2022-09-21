if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit}
Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Force
Set-ExecutionPolicy RemoteSigned -Force

if ((Test-Path -Path C:\Suporte) -eq "TRUE"){
    Write-Host "Pasta Ja Existe"
   }else{
       New-Item -Path 'c:\' -Name "Suporte" -ItemType "directory"
       Write-Host "Pasta foi criada!"
       }

Set-Location C:\Suporte
WinRM quickconfig --Confirm:$false

Set-PSRepository PSGallery -InstallationPolicy Trusted
Install-Module -Name PowerShellGet -Force -Confirm:$false
Install-Module -Name PackageManagement -Force
Install-PackageProvider -Name NuGet -MinimumVersion '2.8.5.208' -Force -Confirm:$false
Install-Module -Name AWS.Tools.S3 -Force

# Variaveis REMOTAS
$urlPowershell7 = "https://github.com/PowerShell/PowerShell/releases/download/v7.2.2/PowerShell-7.2.2-win-x64.msi"
$NetCoreRuntime = "https://download.visualstudio.microsoft.com/download/pr/068d05e8-a0cf-4584-9422-b77f34f1e98e/de70e92721a05c6148619993cbf1376b/aspnetcore-runtime-2.2.8-win-x64.exe"

# Microsoft Visual C++ UWP Deskto Runtime
$mvc1 = "https://aka.ms/directx_x64_appx"
$mvc2 = "https://download.microsoft.com/download/2/1/F/21F05B77-C444-46C0-B357-7EBC78C95CE2/vc_uwpdesktop.120.exe"
$mvc3 = "https://download.microsoft.com/download/3/B/C/3BC60F47-6A7C-4D46-8CFB-C2E746EF336E/vc_uwpdesktop.110.exe"

Invoke-WebRequest -Uri $mvc1 -OutFile "C:\Suporte\UAPSignedBinary_Microsoft.DirectX.x64.appx"
Invoke-WebRequest -Uri $mvc2 -OutFile "C:\Suporte\vc_uwpdesktop.120.exe"
Invoke-WebRequest -Uri $mvc3 -OutFile "C:\Suporte\vc_uwpdesktop.110.exe"

Add-AppPackage -path .\UAPSignedBinary_Microsoft.DirectX.x64.appx
Start-Process -Wait "C:\Suporte\vc_uwpdesktop.110.exe" -ArgumentList '/S','/v','/qn' -PassThru
Start-Process -Wait "C:\Suporte\vc_uwpdesktop.120.exe" -ArgumentList '/S','/v','/qn' -PassThru

#>_ URLs de Download
Invoke-WebRequest -Uri $urlPowershell7 -OutFile "PowerShell-7.2.2-win-x64.msi"
Invoke-WebRequest -Uri $NetCoreRuntime -OutFile "C:\Suporte\aspnetcore-runtime-2.2.8-win-x64.exe"
#AspNetCore Install
Start-Process -Wait aspnetcore-runtime-2.2.8-win-x64.exe -ArgumentList '/S','/v','/qn' -PassThru

# Instalacao do Powershell
cmd /c msiexec /package PowerShell-7.2.2-win-x64.msi /passive /l*v C:\Suporte\PowershellSetup.log

# Instalacao de Winget
$sourceAppInstaller = "https://github.com/microsoft/winget-cli/releases/download/v1.3.2091/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
$sourceVCLibs = "https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx"
Invoke-WebRequest -Uri $sourceVCLibs -OutFile Microsoft.VCLibs.x64.14.00.Desktop.appx
Invoke-WebRequest -Uri $sourceAppInstaller -OutFile Microsoft.DesktopAppInstaller.msixbundle
Add-AppPackage -path .\Microsoft.VCLibs.x64.14.00.Desktop.appx
Add-AppPackage -Path .\Microsoft.DesktopAppInstaller.msixbundle
Start-Process -Wait C:\Suporte\Microsoft.DesktopAppInstaller.msixbundle

#>_ Instalacao de Essenciais
winget install Microsoft.VC++2013Redist-x86 --accept-package-agreements --accept-source-agreements
winget install Microsoft.VC++2013Redist-x64 --accept-package-agreements --accept-source-agreements
winget install Google.Drive -h --accept-package-agreements --accept-source-agreements
winget install Google.Chrome -h --accept-package-agreements --accept-source-agreements
winget install 7zip.7zip -h --accept-package-agreements --accept-source-agreements
winget install Flameshot.Flameshot -h --accept-package-agreements --accept-source-agreements
winget install pdfforge.PDFCreator -h --accept-package-agreements --accept-source-agreements
winget install anydesk -h --accept-package-agreements --accept-source-agreements
winget install whatsapp.whatsapp -h --accept-package-agreements --accept-source-agreements

sleep 20

############################################
# Anydesk Reset ID
Stop-Process -Name AnyDesk -Force
Remove-Item C:\ProgramData\AnyDesk\service.conf -Force
Start-Process "C:\Program Files (x86)\AnyDesk\AnyDesk.exe" -WindowStyle Minimized

#####################################
# Workaround CVE 2022-29072 - 7-zip
$zip = "C:\Program Files\7-Zip\7-zip.chm"

if (-not(Test-Path -Path $zip -PathType Any)) {
    Write-Host "Vulnerabilidade do 7-zip não existe"
} else {
    Remove-Item -Path $zip -Force
    Write-Host "Remoção concluída!"
}
Install-Module -Name PSWindowsUpdate -Force

Write-Host "Instalação Concluida"
Write-Host "Maquina Apta para uso."
sleep 7
White-host "Apagando arquivos temporarios"
Remove-Item C:\Suporte -Recurse -Force
Remove-Item C:\Suporte\* -Recurse -Force
cmd /c TIMEOUT /t 60 /NOBREAK
sleep 5
Restart-Computer
