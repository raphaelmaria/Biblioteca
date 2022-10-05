

# FONTE: https://docs.vmware.com/en/VMware-Carbon-Black-Cloud/services/cbc-sensor-installation-guide/GUID-0FBA8BFB-8E3D-42FB-A589-8E31B184591B.html
$urlDownload = "https://rmtechfiles.s3.amazonaws.com/ScriptFiles/LOFT/VMWareCarbonBlack/installer_vista_win7_win8-64-3.8.0.535.msi"
$chaveInstalacao = "LD6IP2YCW2T8SE0Z2C#"


Invoke-WebRequest -Uri $urlDownload -OutFile 'C:\installer_vista_win7_win8-64-3.8.0.535.msi'

cmd /c msiexec /package 'C:\installer_vista_win7_win8-64-3.8.0.535.msi' COMPANY_CODE=$chaveInstalacao /qn /l*v C:\VMCarbon.log