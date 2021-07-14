if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit}
Set-ExecutionPolicy RemoteSigned

Write-Host "###############################################"
Write-Host "INSTALANDO COMPONENTES .NET FRAMEWORK ESSENCIAIS"
Write-Host "###############################################"

choco install vcredist2005 -dvfy
choco install vcredist2008 -dvfy
choco install vcredist2012 -dvfy
choco install vcredist2013 -dvfy
choco install vcredist2015 -dvfy
choco install vcredist2017 -dvfy
choco install vcredist140 -dvfy

# [REDEFINIR SENHA]
$LocalUser = Get-LocalUser -Name "Loft User"
$Password = (Get-Content C:\Suporte\note.txt) | ConvertTo-SecureString -key (Get-Content C:\Suporte\key.txt)
$LocalUser | Set-LocalUser -Password $Password

Write-Host "###############################################"
Write-Host ">_ EFETUADO A TROCA DA SENHA COM SUCESSO!..."
Write-Host "###############################################"

Write-Host "###############################################"
Write-Host ">_ INSTALANDO JUMP CLOUD AGENT"
Write-Host "###############################################"

cd $env:temp | Invoke-Expression; Invoke-RestMethod -Method Get -URI https://raw.githubusercontent.com/TheJumpCloud/support/master/scripts/windows/InstallWindowsAgent.ps1 -OutFile InstallWindowsAgent.ps1 | Invoke-Expression; ./InstallWindowsAgent.ps1 -JumpCloudConnectKey "5c8f74b6bc5da2b8c9fd5b7ea07ef5173ed59151"
Start-Sleep 30   

Write-Host "#>_ Limpando Cache Chocolatey"
Remove-Item C:\WINDOWS\TEMP\chocolatey\*
Remove-Item C:\C:\Programdata\chocolatey\lib\zoom
Remove-Item C:\Users\%UserProfile%\AppData\Local\Temp\chocolatey

# [INSTALACAO DO ANTIVIRUS CROWNSTRIKE]
#Start-Process -wait powershell -verb runas -ArgumentList "-file C:\Suporte\crowdstrike-facon-ps.ps1"
#Write-Host "###############################################"
#Write-Host ">_ Crowd Strike Falcon INSTALADO COM SUCESSO"
#Write-Host "###############################################"
Powershell.exe -Command "& {Start-Process Powershell.exe -Verb RunAs C:\Suporte\crowdstrike-facon-ps.ps1}"S

#   [ELE AGUARDA 15 SEGUNDOS, PORQUE AINDA EM SEGUNDO PLANO, A INSTALACAO ESTA EM ANDAMENTO]              
Write-Host ">_ Iniciando Servicos do JumpCloud"
#   [BUSCA O SERVICO E VERIFICA O STATUS DO JUMP CLOUD AGENT]
$JCService = Get-Service -Name "jumpcloud-agent"
if ($JCService.Status -eq "Running"){                
    Write-Host "###############################################"
    Write-Host ">_ SERVICO JUMP CLOUD ESTA EM EXECUCAO! <<<"
    Write-Host "###############################################"
    Write-Host ">_ INSTALACAO EFETUADA COM SUCESSO! <<<" 
    Write-Host "###############################################"
    start-sleep 20
    exit
}else{
    Write-Host "Servico nao iniciou, Reiniciando a maquina"
    Restart-Computer}
    
