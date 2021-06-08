#   [FAZ RODAR TODOS OS COMANDOS ABAIXO COMO NIVEL DE ADMINISTRADOR]
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit}

#   [LIBERA A EXECUCAO DESSES SCRIPT NA MAQUINA PARA FAZER A ALTERACOES]
Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Force
Set-ExecutionPolicy RemoteSigned

<#
# Empresa: Loft Tecnologia
# Desenvolvedor: Raphael xxxxx xx xxxxxxxxx Maria
# Cargo: Analista de Suporte
# Versão 1.0
# Criado em 12 de Maio de 2021
# Ticket Origem:
# Solicitante:
# Descrição: Automatiza a customização de novas maquinas Loft baseando em repositorio na Nuvem
# Código com comentários:
#>


# [CHAVES VARIAVEIS]
# Apontamentos de URL's usadas nesse Script
$TeamViewerHostEXE = "https://customdesign.teamviewer.com/download/version_14x/6n2mncz_windows/TeamViewer_Host_Setup.exe"
$ChocoInstallBat = "https://raw.githubusercontent.com/raphaelmaria/deploy/master/nomah/Install_Chocolatey.bat"

#SET KEY
$KEY = "https://raw.githubusercontent.com/raphaelmaria/deploy/master/nomah/NMHkey.txt"
$NOTE = "https://raw.githubusercontent.com/raphaelmaria/deploy/master/nomah/NMHnote.txt"

$HostNameAtual = hostname
$LocalUser = Get-LocalUser -Name "Nomah User"

# [INSERINDO AS INFORMACOES PARA RENOMEAR A MAQUINA]
$PATRIMONIO = Read-Host -Prompt "Entre com o Numero do Patrimonio"
Write-Host "O numero digitado foi:" $PATRIMONIO
$HostNameDefault = "NMH-SPW-"
$NewHost =  "$HostNameDefault$PATRIMONIO"

Write-Host 'O nome atual da maquina:' $HostNameAtual.ToUpper()
Write-Host 'Ao final desse Script sera alterado para:' $NewHost.ToUpper()
Start-Sleep 15
# [CRIANDO A PASTA LOCAL PARA ARMAZENAR OS ARQUIVOS PARA A CONFIGURACAO DA MAQUINA]
            
if ((Test-Path -Path C:\Suporte) -eq "TRUE"){
     Write-Host "Pasta Ja Existe"
    }else{
        New-Item -Path 'c:\' -Name "Suporte" -ItemType "directory"
        Write-Host "Pasta foi criada!"    
        }
                            
#  [VERIFICANDO A REDE E SE O SERVIDOR PODE RESPONDE A REQUISICAO (PING)]
$RedeEXT = (Test-Connection 8.8.8.8 -Count 3 -Quiet)
if ($RedeEXT -eq "true"){
        Write-Host "Maquina conectada com a Internet" -ForegroundColor Green
        Write-Host "Efetuando Download do Conteudo Atualizado!"
        cd 'C:\Suporte'
                
#  [DOWNLOAD TEAM VIEWER]
        Start-Process microsoftedge.exe "https://get.teamviewer.com/lofthost"
        sleep 20
# >_ Fechando navegador Microsoft Edge utilizado para Download do Team Viewer Host.
        Stop-Process -Name msedge
# >_ INSTALANDO O TEAM VIEWER
        Start-Process -Wait -FilePath "C:\Users\Loft User\Downloads\TeamViewer_Host_Setup.exe" -ArgumentList '/S','/v','/qn' -PassThru


#  [Instalacao usando o Chocolaty como Repositorio]
        Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
        Invoke-WebRequest -Uri $ChocoInstallBat -OutFile Install_Choco.bat
        cmd /c C:\Suporte\Install_Choco.bat
       
        choco feature enable -n=allowGlobalConfirmation
        choco install slack -dvfy
        choco install google-drive-file-stream -dvfy
        choco install googlechrome -dvfy 
        choco install adobereader -dvfy
        choco install 7zip.install -dvfy
        choco install lightshot.install -dvfy
                
#  [DOWNLOAD DO GITHUB]
        Invoke-WebRequest -Uri https://www.zoom.us/client/latest/ZoomInstallerFull.msi -OutFile ZoomSetup.msi
        Invoke-WebRequest -Uri $KEY -OutFile key.txt
        Invoke-WebRequest -Uri $NOTE -OutFile note.txt
              


#  [APLICANDO CONFIGURACOES]
        Write-Host "AGUARDE ESTAMOS CONFIGURANDO O DISPOSITIVO"

        Copy-Item "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Slack Technologies\Slack.lnk" "C:\Users\Public\Desktop"
           
#  [LIMPEZA DE PASTAS - TEMPORARIAS]
        Remove-Item c:\Suporte\*.exe -Recurse -Force
        Remove-Item c:\Suporte\*.msi -Recurse -Force
        Remove-Item "%UserProfile%\appdata\local\temp\*" -Recurse -Force
        Remove-Item C:\WINDOWS\TEMP\chocolatey\*
        Remove-Item C:\C:\Programdata\chocolatey\lib\*
        Remove-Item C:\Users\%UserProfile%\AppData\Local\Temp\chocolatey


# [ALTERANDO A SENHA DE ADMINISTRADOR]
        $LocalUser = Get-LocalUser -Name "Nomah User"
        $Password = (Get-Content C:\Suporte\note.txt) | ConvertTo-SecureString -key (Get-Content C:\Suporte\key.txt)
        $LocalUser | Set-LocalUser -Password $Password        

#  [RENOMEANDO UMA MAQUINA USANDO POWERSHELL]
        $info = Get-WmiObject -Class Win32_ComputerSystem
        $info.Rename("$NewHost")
        #Restart-Computer
    }else{
        write-Host "Maquina sem acesso a internet!" -ForegroundColor Red
        pause
        exit    
}       

