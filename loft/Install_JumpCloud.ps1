if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit}
Set-ExecutionPolicy RemoteSigned

Write-Host "INSTALANDO COMPONENTES .NET FRAMEWORK ESSENCIAIS"
choco install vcredist2005 -dvfy
choco install vcredist2008 -dvfy
choco install vcredist2012 -dvfy
choco install vcredist2013 -dvfy
choco install vcredist2015 -dvfy
choco install vcredist2017 -dvfy
choco install vcredist140 -dvfy

Write-Host ">>> INSTALANDO JUMP CLOUD AGENT <<<"
cd $env:temp | Invoke-Expression; Invoke-RestMethod -Method Get -URI https://raw.githubusercontent.com/TheJumpCloud/support/master/scripts/windows/InstallWindowsAgent.ps1 -OutFile InstallWindowsAgent.ps1 | Invoke-Expression; ./InstallWindowsAgent.ps1 -JumpCloudConnectKey "ef10c8ee36a34a414100d8c1eb2d93f26464acc5"
Start-Sleep 15   

# [INSTALACAO DO ANTIVIRUS CROWNSTRIKE]
Start-Process -wait powershell -verb runas -ArgumentList "-file C:\Suporte\crowdstrike-facon-ps.ps1"
Write-Host ">>> ANTIVIRUS INSTALADO COM SUCESSO <<<"
Start-Sleep 15

#           [ELE AGUARDA 15 SEGUNDOS, PORQUE AINDA EM SEGUNDO PLANO, A INSTALACAO ESTA EM ANDAMENTO]              
Write-Host "Iniciando Servicos do JumpCloud"

#           [BUSCA O SERVICO E VERIFICA O STATUS]
$JCService = Get-Service -Name "jumpcloud-agent"
if ($JCService.Status -eq "Running"){                
    Write-Host "###############################################"
    Write-Host ">>> SERVICO JUMP CLOUD ESTA EM EXECUCAO! <<<"
    Write-Host "###############################################"
    Write-Host ">>> INSTALACAO EFETUADA COM SUCESSO! <<<" 
    start-sleep 5

    # [REDEFINIR SENHA]
    $LocalUser = Get-LocalUser -Name "Loft User"
    $Password = (Get-Content C:\Suporte\note.txt) | ConvertTo-SecureString -key (Get-Content C:\Suporte\key.txt)
    $LocalUser | Set-LocalUser -Password $Password

    
    Stop-Computer
    exit
}else{
    Write-Host "Servico nao iniciou, Reiniciando a maquina"
    Restart-Computer}        