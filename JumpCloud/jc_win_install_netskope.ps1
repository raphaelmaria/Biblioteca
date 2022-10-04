# Essa linha chama um powershell em modo administrador para executar as linhas depois dele.
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit}

# Essa linha retira a para o usuário alvo, a retirada das restrições para executar o códigos que vierem do JumpCloud.
Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Force -ErrorAction:SilentlyContinue -Confirm:$false

# Permite a conexão remota para execução dos scripts
Set-ExecutionPolicy RemoteSigned -ErrorAction:SilentlyContinue -Confirm:$false

# Vai criar uma pasta, mas antes ele verifica se ela já existe e caso não ele cria, usada para repositorio, guardando o download do client do netskope para efetuar a instalação.
if ((Test-Path -Path C:\Suporte) -eq "TRUE"){
    Write-Host "Pasta Ja Existe"
   }else{
       New-Item -Path 'c:\' -Name "Suporte" -ItemType "directory"
       Write-Host "Pasta foi criada!"    
       }

# Muda a pasta atual para a pasta repositorio
Set-Location C:\Suporte

# Link de Download do seu netskope, segue o exemplo adicionando seu URL de download.
$netskope = "https://download-contoso-br.goskope.com/dlr/win/get?actkey=netskope"

Write-Host "###############################################"
Write-Host ">_ INSTALANDO NETSKOP IDP"
Write-Host "###############################################"
# Aqui o script vai fazer o download do client
Invoke-WebRequest -Uri $netskope -OutFile C:\Suporte\NSClient.msi

# Aqui vai ser feito a instalação e configurado para onde apontar para conexão, registrando em log todo o processo
cmd /c msiexec /package NSClient.msi installmode="IDP" tenant="contoso-br" domain="goskope.com" /qn /l*v C:\nscinstall.log
Write-Host ">_ NETSKOPE INSTALADO COM SUCESSO"