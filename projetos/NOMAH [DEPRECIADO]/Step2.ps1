if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit}
Set-ExecutionPolicy RemoteSigned

#>_ Install JumpCloud Nomah
cd $env:temp | Invoke-Expression; Invoke-RestMethod -Method Get -URI https://raw.githubusercontent.com/TheJumpCloud/support/master/scripts/windows/InstallWindowsAgent.ps1 -OutFile InstallWindowsAgent.ps1 | Invoke-Expression; ./InstallWindowsAgent.ps1 -JumpCloudConnectKey "9701f2871f4a475c1f14efbc1206d38a4a2fdf02"
sleep 20

# ADD ADMIN NOMAH
New-LocalUser -Name "Nomah User" -Description "Conta Administradora Nomah" -NoPassword
Add-LocalGroupMember -Group "Administradores" -Member "Nomah User"
Disable-LocalUser -Name "User"
'''
# ADD USER NOMAH
New-LocalUser -Name $UserNMH -Description "Conta de Usuario Final" -NoPassword
Add-LocalGroupMember -Group "Administradores" -Member $UserNMH
'''
# [ALTERANDO A SENHA DE ADMINISTRADOR]
$LocalUser = Get-LocalUser -Name "Nomah User"
$Password = (Get-Content C:\Suporte\note.txt) | ConvertTo-SecureString -key (Get-Content C:\Suporte\key.txt)
$LocalUser | Set-LocalUser -Password $Password

Get-Service "jumpcloud-agent"
Sleep 30
Restart-Computer