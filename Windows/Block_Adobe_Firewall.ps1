# Criar uma nova regra de firewall para bloquear o tráfego de entrada
$adobeAfter = "C:\Program Files\Adobe\Adobe After Effects 2023\Support Files"
$adobeEncoder = "C:\Program Files\Adobe\Adobe Media Encoder 2023"
$adobePhotoshop = "C:\Program Files\Adobe\Adobe Photoshop 2023"
$adobePremiere = "C:\Program Files\Adobe\Adobe Premiere Pro 2023"

New-NetFirewallRule -DisplayName "Bloquear Executáveis na Pasta Suporte (Entrada)" `
    -Direction Inbound -Program "C:\Suporte\*" `
    -Action Block

# Criar uma nova regra de firewall para bloquear o tráfego de saída
New-NetFirewallRule -DisplayName "Bloquear Executáveis na Pasta Suporte (Saída)" `
    -Direction Outbound -Program "C:\Suporte\*" `
    -Action Block


# Regras para bloqueio do Adobe Creative Cloud - Entrada
New-NetFirewallRule -DisplayName "Bloquear Executáveis na Pasta Suporte (Entrada)" `
    -Direction Inbound -Program $adobeAfter `
    -Action Block

    New-NetFirewallRule -DisplayName "Bloquear Executáveis na Pasta Suporte (Entrada)" `
    -Direction Inbound -Program  $adobeEncoder `
    -Action Block

    New-NetFirewallRule -DisplayName "Bloquear Executáveis na Pasta Suporte (Entrada)" `
    -Direction Inbound -Program $adobePhotoshop `
    -Action Block

    New-NetFirewallRule -DisplayName "Bloquear Executáveis na Pasta Suporte (Entrada)" `
    -Direction Inbound -Program $adobePremiere `
    -Action Block

    # Regras para bloqueio do Adobe Creative Cloud - Saida
New-NetFirewallRule -DisplayName "Bloquear Executáveis na Pasta Suporte (Entrada)" `
-Direction Outbound -Program $adobeAfter `
-Action Block

New-NetFirewallRule -DisplayName "Bloquear Executáveis na Pasta Suporte (Entrada)" `
-Direction Outbound -Program  $adobeEncoder `
-Action Block

New-NetFirewallRule -DisplayName "Bloquear Executáveis na Pasta Suporte (Entrada)" `
-Direction Outbound -Program $adobePhotoshop `
-Action Block

New-NetFirewallRule -DisplayName "Bloquear Executáveis na Pasta Suporte (Entrada)" `
-Direction Outbound -Program $adobePremiere `
-Action Block