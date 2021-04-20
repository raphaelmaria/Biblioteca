powershell.exe "C:\Suporte\Install_JumpCloud.ps1"
powershell.exe "C:\Suporte\crowdstrike-facon-ps.ps1"
msg %username% Instalacao de CrowdStrike e JumpCloud efetuadas com sucesso!

del "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\Start_PostInstall.bat"
del "C:\Suporte\Install_JumpCloud.ps1"
del "C:\Suporte\crowdstrike-facon-ps.ps1"