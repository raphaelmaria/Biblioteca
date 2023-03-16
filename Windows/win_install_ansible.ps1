# Instalar o Windows Management Framework 5.1
Invoke-WebRequest -Uri "https://download.microsoft.com/download/C/F/F/CFF3A0B8-99D4-41A2-AE1A-496C08BEB904/Win7AndW2K8R2-KB3191566-x64.zip" -OutFile "C:\temp\WMF51.zip"
Expand-Archive -Path "C:\temp\WMF51.zip" -DestinationPath "C:\temp\WMF51"
Start-Process -FilePath "C:\temp\WMF51\Win7AndW2K8R2-KB3191566-x64.msu" -ArgumentList "/quiet /norestart" -Wait

# Instalar o Python
Invoke-WebRequest -Uri "https://www.python.org/ftp/python/3.9.7/python-3.9.7-amd64.exe" -OutFile "C:\temp\python.exe"
Start-Process -FilePath "C:\temp\python.exe" -ArgumentList "/quiet InstallAllUsers=1 PrependPath=1 Include_test=0" -Wait

# Instalar o módulo do PowerShell para o Ansible
Install-Module -Name AWSPowerShell.NetCore

# Configurar o PowerShell remoto
Enable-PSRemoting -Force

# Configurar as políticas de execução do PowerShell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine
