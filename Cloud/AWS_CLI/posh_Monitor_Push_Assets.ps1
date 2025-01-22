if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit}

Install-Module -Name PowerShellGet -Force
Install-Module -Name PackageManagement -Force
Install-Module -Name PSWindowsUpdate -Force
Install-PackageProvider -Name NuGet -MinimumVersion '2.8.5.208' -Force
Install-Module -Name AWS.Tools.S3 -Force

$accessKey = "INSIRA SUA CHAVE DE ACESSO"
$secretKey = "INSIRA SUA CHAVE SECRETA"
$region = "COLOQUE SUA REGIAO"
$bucket = "INSIRA SEU S3 BUCKET"
$keyPrefix="PASTA QUE SERÁ BAIXADA"
$SupportFiles = 'LOCAL ONDE SERÁ ARMAZENADA'

Set-AWSCredential -AccessKey $accessKey -SecretKey $secretKey -StoreAs userDownload
Copy-S3Object -BucketName $bucket -AccessKey $accessKey -SecretKey $secretKey -KeyPrefix $keyPrefix -LocalFolder $SupportFiles

