# Check status
Get-MpComputerStatus
Get-MpPreference | select Exclusion* | fl #Check exclusions
# Disable
Set-MpPreference -DisableRealtimeMonitoring $true
#To completely disable Windows Defender on a computer, use the command:
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name DisableAntiSpyware -Value 1 -PropertyType DWORD -Force
# Set exclusion path
Add-MpPreference -ExclusionPath "C:\users\public\documents\magichk"
Set-MpPreference -ExclusionPath "C:\users\public\documents\magichk"

# Check exclusions configured via GPO
Parse-PolFile .\Registry.pol

KeyName : Software\Policies\Microsoft\Windows Defender\Exclusions
ValueName : Exclusions_Paths
ValueType : REG_DWORD
ValueLength : 4
ValueData : 1

KeyName : Software\Policies\Microsoft\Windows Defender\Exclusions\Paths
ValueName : C:\Windows\Temp
ValueType : REG_SZ
ValueLength : 4
ValueData : 0