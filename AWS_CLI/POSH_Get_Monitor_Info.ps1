#!/bin/env posh
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit}

#Essa linha remove se o conteudo ja existiu em algum momento.
Remove-Item C:\${env:ComputerName}_monitors.txt

#Aqui começa a coleta de dados sobre os monitores instalados presente no registro da maquina.
# Variaveis para executar o comando.
$Monitors = Get-WmiObject WmiMonitorID -Namespace root\wmi
$LogFile = "C:\monitors.txt"
    
function Decode {
    If ($args[0] -is [System.Array]) {
        [System.Text.Encoding]::ASCII.GetString($args[0])
     }
     Else {
         "Not Found"
     }
}
    
 #echo "Manufacturer", "Name, Serial"
    
ForEach ($Monitor in $Monitors) {  
     $Manufacturer = Decode $Monitor.ManufacturerName -notmatch 0
     $Name = Decode $Monitor.UserFriendlyName -notmatch 0
     $Serial = Decode $Monitor.SerialNumberID -notmatch 0
    
     echo "$Manufacturer, $Name, $Serial" >> $LogFile
}

# Nessa sessão o arquivo gerado é renomeado e vira um nome padrão para upload da AWS S3 no próximo passo.
Set-Location C:\
Rename-Item "monitors.txt" -NewName ${env:ComputerName}_monitors.txt

########################################################################################
Write-Host "INSTALANDO COMPLEMENTOS PARA O AWS CLI"
[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12
Install-PackageProvider -Name NuGet -Force
Install-Module -Name PowerShellGet -Force
Update-Module -Name PowerShellGet -Force
Install-Module -Name PackageManagement -Force
Install-Module -Name PSWindowsUpdate -Force
Install-PackageProvider -Name NuGet -MinimumVersion '2.8.5.208' -Force
Install-Module -Name AWS.Tools.S3 -Force

#########################################################################################!/usr/bin/env pwsh
Write-Host "INICIANDO TRANSFERENCIA DE ARQUIVO PARA REPOSITORIO AWS"
Set-Location C:\
$AccessKey = "COLOQUE AQUI O SEU ACCESS KEY"
$SecreteKey = "COLOQUE AQUI O SEU SECRET KEY"
$bucket = "COLOQUE AQUI O BUCKET"
$upFiles = "${env:ComputerName}_monitors.txt"

# INICIANDO A VALIDACAO E LOGIN DO USUARIO PARA ESSA SESSÃO
Set-AWSCredential `
                 -AccessKey $AccessKey `
                 -SecretKey $SecreteKey `
                 -StoreAs default
# INICIANDO A COPIA DO ARQUIVO PARA AWS
Write-S3Object -BucketName $bucket -File $upFiles