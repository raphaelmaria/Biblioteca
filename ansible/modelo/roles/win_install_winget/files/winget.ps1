if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit}

if ((Test-Path -Path C:\Suporte) -eq "TRUE"){
Write-Host "Pasta Ja Existe"
}else{
New-Item -Path 'c:\' -Name "Suporte" -ItemType "directory"
Write-Host "Pasta foi criada!"
}

Set-Location C:\Suporte

Set-PSRepository PSGallery -InstallationPolicy Trusted
Install-Module -Name PowerShellGet -Force -Confirm:$false
Install-Module -Name PackageManagement -Force
Install-PackageProvider -Name NuGet -MinimumVersion '2.8.5.208' -Force
Install-Module -Name AWS.Tools.S3 -Force

# Microsoft Visual C++ UWP Deskto Runtime
$mvc1 = "https://aka.ms/directx_x64_appx"
$mvc2 = "https://download.microsoft.com/download/2/1/F/21F05B77-C444-46C0-B357-7EBC78C95CE2/vc_uwpdesktop.120.exe"
$mvc3 = "https://download.microsoft.com/download/3/B/C/3BC60F47-6A7C-4D46-8CFB-C2E746EF336E/vc_uwpdesktop.110.exe"
$urlPowershell7 = "https://github.com/PowerShell/PowerShell/releases/download/v7.2.2/PowerShell-7.2.2-win-x64.msi"
$sourceAppInstaller = "https://github.com/microsoft/winget-cli/releases/download/v1.3.2091/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
$sourceVCLibs = "https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx"

#>_ URLs de Download
Invoke-WebRequest -Uri $mvc1 -OutFile "C:\Suporte\UAPSignedBinary_Microsoft.DirectX.x64.appx"
Invoke-WebRequest -Uri $mvc2 -OutFile "C:\Suporte\vc_uwpdesktop.120.exe"
Invoke-WebRequest -Uri $mvc3 -OutFile "C:\Suporte\vc_uwpdesktop.110.exe"
Invoke-WebRequest -Uri $urlPowershell7 -OutFile "PowerShell-7.2.2-win-x64.msi"
Invoke-WebRequest -Uri $netskope -OutFile "C:\Suporte\NSClient.msi"
Invoke-WebRequest -Uri $awsVPNClient -OutFile "C:\Suporte\AWS_VPN_Client.msi"
Invoke-WebRequest -Uri $NetCoreRuntime -OutFile "C:\Suporte\aspnetcore-runtime-2.2.8-win-x64.exe"
Invoke-WebRequest -Uri $slackAllUsers -OutFile "C:\Suporte\slack.msi"

#AspNetCore Install
Start-Process -Wait aspnetcore-runtime-2.2.8-win-x64.exe -ArgumentList '/S','/v','/qn' -PassThru
# Instalacao do Powershell
cmd /c msiexec /package PowerShell-7.2.2-win-x64.msi /passive /l*v C:\Suporte\PowershellSetup.log

# Instalacao de Winget
Add-AppPackage -path .\UAPSignedBinary_Microsoft.DirectX.x64.appx
Start-Process -Wait "C:\Suporte\vc_uwpdesktop.110.exe" -ArgumentList '/S','/v','/qn' -PassThru
Start-Process -Wait "C:\Suporte\vc_uwpdesktop.120.exe" -ArgumentList '/S','/v','/qn' -PassThru
Invoke-WebRequest -Uri $sourceVCLibs -OutFile Microsoft.VCLibs.x64.14.00.Desktop.appx
Invoke-WebRequest -Uri $sourceAppInstaller -OutFile Microsoft.DesktopAppInstaller.msixbundle
Add-AppPackage -path .\Microsoft.VCLibs.x64.14.00.Desktop.appx
Add-AppPackage -Path .\Microsoft.DesktopAppInstaller.msixbundle
Start-Process -Wait C:\Suporte\Microsoft.DesktopAppInstaller.msixbundle
