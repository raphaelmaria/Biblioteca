'''
Este script realiza as seguintes ações:

1. Instala o módulo AWSPowerShell.NetCore necessário para a comunicação com o Windows.
2. Desativa o Firewall do Windows para permitir a comunicação remota.
3. Habilita a execução de scripts do PowerShell para execução automatizada.
4. Habilita o WinRM para permitir a comunicação remota do Ansible.
5. Configura o Windows Remote Management para permitir a autenticação básica.
6. Reinicia o serviço WinRM para aplicar as alterações.
7. Adiciona uma entrada no arquivo de hosts do Windows para permitir a comunicação do Ansible.
8. Verifica se o Ansible já está instalado e, se não, faz o download
'''

# Instala o módulo do PowerShell do Ansible
Install-Module -Name AWSPowerShell.NetCore -Force

# Desativa o Firewall do Windows
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False

# Habilita a execução de scripts do PowerShell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Force

# Habilita o WinRM para comunicação remota
Enable-PSRemoting -Force

# Configura o Windows Remote Management para permitir a autenticação básica
Set-Item -Path WSMan:\localhost\Service\Auth\Basic -Value $true

# Reinicia o serviço WinRM para aplicar as alterações
Restart-Service -Name WinRM

# Configura o arquivo de hosts para permitir a comunicação do Ansible
Add-Content -Path "C:\Windows\System32\drivers\etc\hosts" -Value "`n127.0.0.1 ansible_connection=winrm ansible_user=<usuário> ansible_password=<senha>"

# Verifica se o Ansible já está instalado e, se não, faz o download e a instalação
if (-not (Test-Path -Path "C:\Program Files\Ansible")) {
    $url = "https://github.com/ansible/ansible/archive/refs/tags/v4.5.0.tar.gz"
    $destination = "$env:TEMP\ansible.tar.gz"
    Invoke-WebRequest -Uri $url -OutFile $destination
    Expand-Archive -Path $destination -DestinationPath "$env:TEMP"
    $ansibleFolder = (Get-ChildItem -Path "$env:TEMP" -Filter "ansible-*" -Directory).FullName
    Move-Item -Path $ansibleFolder -Destination "C:\Program Files\Ansible"
    Remove-Item -Path $destination
}

# Adiciona o caminho do Ansible ao PATH do sistema
$ansiblePath = Join-Path -Path "C:\Program Files\Ansible" -ChildPath "bin"
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";$ansiblePath", [EnvironmentVariableTarget]::Machine)

# Configura o arquivo de configuração do Ansible
$ansibleConfigPath = Join-Path -Path $env:USERPROFILE -ChildPath ".ansible.cfg"
$ansibleConfig = @"
[defaults]
inventory = C:\Windows\System32\drivers\etc\hosts
remote_user = <usuário>
"@ | Out-File -FilePath $ansibleConfigPath -Encoding utf8 -Force
