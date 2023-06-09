'''
Este script realiza as seguintes ações:

Habilita o Windows Remote Management (WinRM) para permitir conexões remotas.
Configura o Firewall do Windows para permitir o tráfego do WinRM.
Configura as opções de autenticação do WinRM para permitir a autenticação básica.
Reinicia o serviço WinRM para aplicar as alterações.
'''
# Configura o Windows Remote Management para permitir conexões remotas
Enable-PSRemoting -Force

# Configura o Firewall do Windows para permitir o tráfego do WinRM
Set-NetFirewallRule -Name "WINRM-HTTP-In-TCP" -Enabled True

# Configura as opções de autenticação do WinRM para permitir a autenticação básica
Set-Item -Path WSMan:\localhost\Service\Auth\Basic -Value $true

# Reinicia o serviço WinRM para aplicar as alterações
Restart-Service -Name WinRM
