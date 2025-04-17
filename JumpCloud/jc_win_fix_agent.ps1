$jcScript = "https://github.com/TheJumpCloud/support/blob/master/scripts/windows/FixWindowsAgent.ps1"
Invoke-WebRequest -Uri $jcScript --OutFile C:\jcFixAgent.ps1
Powershell.exe -Command "& {Start-Process Powershell.exe -Verb RunAs C:\jcFixAgent.ps1 -JumpCloudConnectKey "CHAVE"}"