if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit}
if ((Test-Path -Path "C:\Program Files (x86)\Common Files\Adobe\AdobeGCClient\AdobeGCClient.exe.old") -eq "TRUE"){
    Stop-Process -Name AdobeGCClient
    Remove-item "C:\Program Files (x86)\Common Files\Adobe\AdobeGCClient\AdobeGCClient.exe.old"
    Rename-Item "C:\Program Files (x86)\Common Files\Adobe\AdobeGCClient\AdobeGCClient.exe" -newname "C:\Program Files (x86)\Common Files\Adobe\AdobeGCClient\AdobeGCClient.exe.old"

   }else{
    Rename-Item "C:\Program Files (x86)\Common Files\Adobe\AdobeGCClient\AdobeGCClient.exe" -newname "C:\Program Files (x86)\Common Files\Adobe\AdobeGCClient\AdobeGCClient.exe.old"
       }
