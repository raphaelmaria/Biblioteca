
#   [FAZ RODAR TODOS OS COMANDOS ABAIXO COMO NIVEL DE ADMINISTRADOR]
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit}

Set-Location C:\
# LINK DE DOWNLOAD PUBLICO DA BIT DEFENDER
$urlBDInstaller = "https://download.bitdefender.com/SMB/Hydra/release/bst_win/downloaderWrapper/BEST_downloaderWrapper.msi"
# Download de MSI
Invoke-webrequest -Uri $urlBDInstaller -OutFile BEST_downloaderWrapper.msi
# Inicia a instalacao
cmd /c msiexec /package "BEST_downloaderWrapper.msi" /qn GZ_PACKAGE_ID=[CHAVE DE ATIVACAO] REBOOT_IF_NEEDED=0