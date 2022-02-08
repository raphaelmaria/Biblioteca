#Identificar a Versao do PowerShell
Get-Date | Out-File ".\Log.txt"
Write-Host "A versao do Seu POWERSHELL é:" | $PSVersionTable.PSVersion | Out-File ".\Log.txt"

# Informacoes da Maquina
Write-Host "As informacoes da Maquina que esta sendo executando é:" | Get-Host 2>> .\Log.txt
Write-Host 'Ultimo reboot foi: '
Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object -Property CSName, LastBootUpTime

#Update do HELP
Write-Host "Fazendo Atualizacao do HELP do POWERSHELL" | Update-Help 2>> .\Log.txt

# Listar servicos em execusao durante a instalacao
Write-Host "Servicos em Execucao:"
Get-Service | Where-Object {$_.Status -eq "Running"}
Write-Host "Servicos em Parada:"
Get-Service | Where-Object {$_.Status -ne "Running"}


