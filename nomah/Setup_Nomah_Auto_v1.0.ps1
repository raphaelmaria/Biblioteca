#   [FAZ RODAR TODOS OS COMANDOS ABAIXO COMO NIVEL DE ADMINISTRADOR]
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit}

#   [LIBERA A EXECUCAO DESSES SCRIPT NA MAQUINA PARA FAZER A ALTERACOES]
Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Force
Set-ExecutionPolicy RemoteSigned

<#
# Empresa: Nomah
# Desenvolvedor: Raphael xxxxx xx xxxxxxxxx Maria
# Cargo: Analista de Suporte
# Versão 1.0
# Criado em 07 de Junho de 2021
# Ticket Origem:
# Solicitante:
# Descrição: Automatiza a customização de novas maquinas Loft baseando em repositorio na Nuvem
# Código com comentários:
#>


# [CHAVES VARIAVEIS]
# Apontamentos de URL's usadas nesse Script
$ChocoInstallBat = "https://raw.githubusercontent.com/raphaelmaria/deploy/master/nomah/Install_Chocolatey.bat"
$Step2 = ""
$Start_PostInstall = ""

#SET KEY
$KEY = "https://raw.githubusercontent.com/raphaelmaria/deploy/master/nomah/NMHkey.txt"
$NOTE = "https://raw.githubusercontent.com/raphaelmaria/deploy/master/nomah/NMHnote.txt"

$HostNameAtual = hostname

# [INSERINDO AS INFORMACOES PARA RENOMEAR A MAQUINA]
$PATRIMONIO = Read-Host -Prompt "Entre com o Numero do Patrimonio"
Write-Host "O numero digitado foi:" $PATRIMONIO
$HostNameDefault = "NMH-SPW-"
$NewHost =  "$HostNameDefault$PATRIMONIO"

Write-Host 'O nome atual da maquina:' $HostNameAtual.ToUpper()
Write-Host 'Ao final desse Script sera alterado para:' $NewHost.ToUpper()
$UserNMH = Read-Host -Prompt "Digite o Nome do Usuario Final"

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
                
#  [Instalacao usando o Chocolaty como Repositorio]
        Remove-Item C:\Programdata\chocolatey -Recuse -Force
        Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
        Invoke-WebRequest -Uri $ChocoInstallBat -OutFile Install_Choco.bat
        cmd /c C:\Suporte\Install_Choco.bat

# >_ Aplica a permissao de SIM em modo Global para o Chocolatey
        choco feature enable -n=allowGlobalConfirmation
 
# >_ Instala Aplicações        
        choco install slack -dvfy
        choco install google-drive-file-stream -dvfy
        choco install googlechrome -dvfy 
        choco install adobereader -dvfy
        choco install 7zip.install -dvfy
        choco install lightshot.install -dvfy
        choco install anydesk.install -dvfy
                
#  [DOWNLOAD DO GITHUB]
        Invoke-WebRequest -Uri https://www.zoom.us/client/latest/ZoomInstallerFull.msi -OutFile ZoomSetup.msi
        Invoke-WebRequest -Uri $KEY -OutFile key.txt
        Invoke-WebRequest -Uri $NOTE -OutFile note.txt
        Invoke-WebRequest -Uri $Step2 -OutFile Step2.ps1
        Invoke-WebRequest -Uri $Start_PostInstall -OutFile postinstall.bat
        Copy-Item "C:\Suporte\postinstall.bat" del "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp"
              
# >_ Instalar Zoom para Start Automatico
        cmd /c msiexec /package  "C:\Suporte\ZoomSetup.msi" ZoomAutoUpdate="true" ZoomAutoStart="true" /passive

#  [APLICANDO CONFIGURACOES]
        Write-Host "AGUARDE ESTAMOS CONFIGURANDO O DISPOSITIVO"

        Copy-Item "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Slack Technologies\Slack.lnk" "C:\Users\Public\Desktop"
           
#  [LIMPEZA DE PASTAS - TEMPORARIAS]
        Remove-Item c:\Suporte\*.exe -Recurse -Force
        Remove-Item c:\Suporte\*.msi -Recurse -Force
        Remove-Item "%UserProfile%\appdata\local\temp\*" -Recurse -Force
        Remove-Item C:\WINDOWS\TEMP\chocolatey\*
        Remove-Item C:\Programdata\chocolatey\lib\*
        Remove-Item C:\Users\%UserProfile%\AppData\Local\Temp\chocolatey

                

#  [RENOMEANDO UMA MAQUINA USANDO POWERSHELL]
        $info = Get-WmiObject -Class Win32_ComputerSystem
        $info.Rename("$NewHost")
        Restart-Computer
    }else{
        write-Host "Maquina sem acesso a internet!" -ForegroundColor Red
        pause
        exit    
}       


