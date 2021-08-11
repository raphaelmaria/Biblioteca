#   [FAZ RODAR TODOS OS COMANDOS ABAIXO COMO NIVEL DE ADMINISTRADOR]
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit}

#   [LIBERA A EXECUCAO DESSES SCRIPT NA MAQUINA PARA FAZER A ALTERACOES]
Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Force
Set-ExecutionPolicy RemoteSigned


Write-Host "Empresa: Loft Tecnologia"
Write-Host "Desenvolvedor: Raphael xxxxx xx xxxxxxxxx Maria"
#Cargo: Analista de Suporte
Write-Host "Versão 1.0 - BR Mobile"
# Criado em 18 de Abril de 2021
# Solicitante:
Write-Host "Descrição: Automatiza a customização de novas maquinas Alugadas da BR Mobile baseando em repositorio na Nuvem"
# Código com comentários:
#>

# [CHAVES VARIAVEIS]
# Apontamentos de URL's usadas nesse Script
$TeamViewerHostEXE = "https://customdesign.teamviewer.com/download/version_14x/6n2mncz_windows/TeamViewer_Host_Setup.exe"
$netskope = "https://download-loft-br.de.goskope.com/dlr/win/get"

# >_ Variaveis
$ScriptBatInstallFull = "https://raw.githubusercontent.com/raphaelmaria/deploy/master/loft/Install_All_v2.1.bat"
$ScriptBatInstallPartial = "https://raw.githubusercontent.com/raphaelmaria/deploy/master/loft/Install_Partial_v2.1.bat"
$ScriptInstallCounterStrike = "https://raw.githubusercontent.com/raphaelmaria/deploy/master/loft/crowdstrike-facon-ps.ps1"
$ScriptInstallJumpCloud = "https://raw.githubusercontent.com/raphaelmaria/deploy/master/loft/Install_JumpCloud.ps1"
$ScriptStartPostInstall = "https://raw.githubusercontent.com/raphaelmaria/deploy/master/loft/Start_PostInstall.bat"
$LoftWinWallpaper = "https://raw.githubusercontent.com/raphaelmaria/deploy/master/loft/2021_04_Wallpaper_Project.jpg"
$TeamViewerREG = "https://raw.githubusercontent.com/raphaelmaria/deploy/master/loft/TeamViewer_Settings.reg"


#SET KEY
$KEY = "https://raw.githubusercontent.com/raphaelmaria/deploy/master/loft/key.txt"
$NOTE = "https://raw.githubusercontent.com/raphaelmaria/deploy/master/loft/note.txt"

$HostNameAtual = hostname

Write-Host "================ BR Mobile Setup ================"
Write-Host "> BEM VINDO!"
Write-Host "> Vamos iniciar a configuracao da maquina."

#[INSERINDO AS INFORMACOES PARA RENOMEAR A MAQUINA]
Write-Host "Entre com os 4 ultimos numero da etiqueta de Patrimonio. (SOMENTE NUMEROS)"
$IDLOFT = Read-Host -Prompt "Numero de Patrimonio: "
Write-Host "O numero digitado foi:" $IDLOFT
$HostNameDefault = "LOFT-BRMW-"
$NewHost =  "$HostNameDefault$IDLOFT"


Write-Host 'O nome atual da maquina:' $HostNameAtual.ToUpper()
Write-Host 'Ao final desse Script sera alterado para:' $NewHost.ToUpper()
Start-Sleep 15

#[CRIANDO A PASTA LOCAL PARA ARMAZENAR OS ARQUIVOS PARA A CONFIGURACAO DA MAQUINA]
            
Start-Service winrm
winrm set winrm/config/client/auth '@{Basic="True"}'
Enable-PSRemoting -SkipNetworkProfileCheck -Force
Set-NetFirewallRule -Name 'WINRM-HTTP-In-TCP-PUBLIC' -RemoteAddress Any

if ((Test-Path -Path C:\Suporte) -eq "TRUE"){
    Write-Host "Pasta Ja Existe"
    }else{
        New-Item -Path 'c:\' -Name "Suporte" -ItemType "directory"
        Write-Host "Pasta foi criada!"    
        }
                            
# [VERIFICANDO A REDE E SE O SERVIDOR PODE RESPONDE A REQUISICAO (PING)]
$RedeEXT = (Test-Connection 8.8.8.8 -Count 3 -Quiet)

if ($RedeEXT -eq "true"){
    Write-Host "Maquina conectada com a Internet" -ForegroundColor Green
    Write-Host "Efetuando Download do Conteudo Atualizado!"
    cd 'C:\Suporte'
                
# DOWNLOAD TEAM VIEWER
    Start-Process microsoftedge.exe "https://get.teamviewer.com/lofthost"
    sleep 20

# Instalacao usando o Chocolaty como Repositorio
    Remove-Item C:\ProgramData\chocolatey -Recurse -Force    
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))                 
    choco feature enable -n=allowGlobalConfirmation
    choco install slack -dvfy
    choco install google-drive-file-stream -dvfy
    choco install googlechrome -dvfy 
    choco install adobereader -dvfy
    choco install 7zip.install -dvfy
    choco install lightshot.install -dvfy
    choco install vlc -dvfy
                
# [DOWNLOAD DO GITHUB DOS ARQUIVOS NECESSÁRIOS]
    Invoke-WebRequest -Uri https://www.zoom.us/client/latest/ZoomInstallerFull.msi -OutFile ZoomSetup.msi
    Invoke-WebRequest -Uri $ScriptBatInstallFull -OutFile Install_All_v2.1.bat
    Invoke-WebRequest -Uri $LoftWinWallpaper -OutFile 2021_04_Wallpaper_Project.jpg
    Invoke-WebRequest -Uri $ScriptInstallJumpCloud -OutFile Install_JumpCloud.ps1
    Invoke-WebRequest -Uri $ScriptInstallCounterStrike -OutFile crowdstrike-facon-ps.ps1
    Invoke-WebRequest -Uri $ScriptStartPostInstall -OutFile Start_PostInstall.bat
    Invoke-WebRequest -Uri $KEY -OutFile key.txt
    Invoke-WebRequest -Uri $NOTE -OutFile note.txt
    Invoke-WebRequest -Uri $TeamViewerREG -OutFile TeamViewer_Settings.reg
    Invoke-WebRequest -Uri $netskope -OutFile NSClient.msi
                             
# [INSTALANDO O TEAM VIEWER HOST 14]
    Start-Process -Wait -FilePath "C:\Users\$SiglaBRM$IDLOFT\Downloads\TeamViewer_Host_Setup.exe" -ArgumentList '/S','/v','/qn' -PassThru
      
# [PARA FAZER INSTALACAO DE MSI, VC PRECISA CHAMAR UM BAT POR SER MAIS FACIL]
    Write-Host "Efetuando Instalacao de Programas - Part II"
    Start-Process -Wait 'C:\Suporte\Install_All_v2.1.bat'
    Copy-Item "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Slack Technologies\Slack.lnk" "C:\Users\Public\Desktop"
    Copy-Item "Start_PostInstall.bat" "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\"

# [LIMPEZA DE PASTAS - TEMPORARIAS]
    Remove-Item c:\Suporte\*.exe -Recurse -Force
    Remove-Item c:\Suporte\*.msi -Recurse -Force
    Remove-Item "%UserProfile%\appdata\local\temp\*" -Recurse -Force

# ADD USER LOFT
    New-LocalUser -Name "Loft User" -Description "Contra Administradora LOFT" -NoPassword
    Add-LocalGroupMember -Group "Administradores" -Member "Loft User"
    Disable-LocalUser -Name $SiglaBRM$IDLOFT
    Disable-LocalUser -Name "Lenovo"
    Disable-LocalUser -Name "ADMIN"
    Disable-LocalUser -Name "BR MOBILE"
    Disable-LocalUser -Name "BRMOBILE"
    Disable-LocalUser -Name "HP"
    Disable-LocalUser -Name "DELL"
    Disable-LocalUser -Name "Convex"

#           [RENOMEANDO UMA MAQUINA USANDO POWERSHELL]
    $info = Get-WmiObject -Class Win32_ComputerSystem
    $info.Rename("$NewHost")
    Restart-Computer

    }else{
        Write-Host "Maquina sem acesso a internet!" -ForegroundColor Red
        Pause
         }       
