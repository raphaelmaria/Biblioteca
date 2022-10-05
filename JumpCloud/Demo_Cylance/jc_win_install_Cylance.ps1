if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit}

$urlDownload= "[ URL de download ]"
Set-Location "C:\"
Invoke-WebRequest -Uri $urlDownload -OutFile C:\CylanceUnifiedSetup_x64.msi
# NESSA LINHA ELE INSTALA O ENDPOINT SEM APRESENTAR O ICONE NA AREA DE NOTIFICAO
#cmd /c msiexec /i CylanceUnifiedSetup_x64.msi /qn PIDKEY=[CHAVE DE ATIVACAO] LAUNCHAPP=0

# NESSA LINHA ELE INSTALA O ENDPOINT E APRESENTAR O ICONE NA AREA DE NOTIFICAO
cmd /c msiexec /i CylanceUnifiedSetup_x64.msi /qn PIDKEY=[CHAVE DE ATIVACAO] LAUNCHAPP=1
