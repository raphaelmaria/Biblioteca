

# FONTE: https://docs.vmware.com/en/VMware-Carbon-Black-Cloud/services/cbc-sensor-installation-guide/GUID-0FBA8BFB-8E3D-42FB-A589-8E31B184591B.html
$urlDownload = "[ URL ]"
$chaveInstalacao = "[ TOKEN ID ]"


Invoke-WebRequest -Uri $urlDownload -OutFile 'C:\VMwareCarbonBlack.msi'

cmd /c msiexec /package 'C:\VMWareCarbonBlack.msi' COMPANY_CODE=$chaveInstalacao /qn /l*v C:\VMCarbon.log