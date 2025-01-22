# Solicitar permissões de administrador
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Start-Process powershell.exe "-File $PSCommandPath" -Verb RunAs
    exit
}

# Função para bloquear o acesso à internet
function Block-ResolumeApp {
    param ($Name, $Path)
    if (-not (Get-NetFirewallRule -DisplayName "Block $Name" -ErrorAction SilentlyContinue)) {
        Write-Host "Bloqueando $Name..."
        New-NetFirewallRule -DisplayName "Block $Name" -Direction Outbound -Action Block -Program $Path
    }
}

# Função para desbloquear o acesso à internet
function Unblock-ResolumeApp {
    param ($Name, $Path)
    if (Get-NetFirewallRule -DisplayName "Block $Name" -ErrorAction SilentlyContinue) {
        Write-Host "Desbloqueando $Name..."
        Remove-NetFirewallRule -DisplayName "Block $Name"
    }
}

# Menu de seleção
function Menu {
    Write-Host "Selecione uma opção:"
    Write-Host "1. Bloquear Resolume"
    Write-Host "2. Desbloquear Resolume"
    $choice = Read-Host "Digite sua escolha (1-2)"
    
    switch ($choice) {
        1 {
            Block-ResolumeApp -Name "Arena" -Path "C:\Program Files\Resolume Arena\Arena.exe"
            Block-ResolumeApp -Name "Avenue" -Path "C:\Program Files\Resolume Avenue\Avenue.exe"
            Block-ResolumeApp -Name "Wire" -Path "C:\Program Files\Resolume Wire\Wire.exe"
            Write-Host "Acesso à internet bloqueado com sucesso."
        }
        2 {
            Unblock-ResolumeApp -Name "Arena" -Path "C:\Program Files\Resolume Arena\Arena.exe"
            Unblock-ResolumeApp -Name "Avenue" -Path "C:\Program Files\Resolume Avenue\Avenue.exe"
            Unblock-ResolumeApp -Name "Wire" -Path "C:\Program Files\Resolume Wire\Wire.exe"
            Write-Host "Acesso à internet desbloqueado com sucesso."
        }
        default {
            Write-Host "Por favor, escolha 1 ou 2."
            Menu
        }
    }
}

# Executar o menu
Menu
