#   [FAZ RODAR TODOS OS COMANDOS ABAIXO COMO NIVEL DE ADMINISTRADOR]
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit}
<#
# Empresa: [NOME DA EMPRESA]
# Desenvolvedor: Raphael xxxxx xx xxxxxxxxx Maria
# Cargo: Analista de Suporte
# Versão 2.1
# Criado em 29 de Dezembro de 2020
# Ticket Origem:
# Solicitante:
# Descrição: Automatiza a customização de novas maquinas.
# Código com comentários:
#>

#   [LIBERA A EXECUCAO DESSES SCRIPT NA MAQUINA PARA FAZER A ALTERACOES]
Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Force



#   [AQUI COMECA O MENU DE OPCOES]
function Show-Menu
{
    param (
        [string]$Title = '[INSIRA  O TITULO AQUI]'
    )
    Clear-Host
#   [APRESENTACAO]
    Write-Host "================ $Title ================"
#   [AS OPCOES]
    Write-Host "1: Press '1' Instalar Programas Padroes e Renomear Host."
    Write-Host "2: Press '2' Configurar o JumpCloud."
    Write-Host "3: Press '3' Renomear este computador."
    Write-Host "Q: Press 'Q' Para Sair."
}

do
 {
     Show-Menu
     $selection = Read-Host "SELECIONE UMA OPCAO"
     switch ($selection)
#   [AQUI COMECA A ACAO DA OPCAO 1]
     {
         '1' {
#           [INSERINDO AS INFORMACOES PARA RENOMEAR A MAQUINA]
                $PATRIMONIO = Read-Host -Prompt "Entre com o Numero do Patrimonio "
                Write-Host "O numero digitado foi, " $PATRIMONIO.ToInt64()
                $HostNameAtual = hostname
                $HostNameDefault = "[NOMENCLATURA PADRAO DA SUA EMPRESA]"
                $NewHost =  "$HostNameDefault$IDLOFT"

              Write-Host 'O nome atual da maquina:' $HostNameAtual.ToUpper()
              Write-Host 'Ao final desse Script sera alterado para:' $NewHost.ToUpper()
              sleep 15
#            [CRIANDO A PASTA LOCAL PARA ARMAZENAR OS ARQUIVOS PARA A CONFIGURACAO DA MAQUINA]
              New-Item -Path 'c:\' -Name "Suporte" -ItemType "directory"
#            [VERIFICANDO A REDE E SE O SERVIDOR PODE RESPONDE A REQUISICAO (PING)]
                $conn = (Test-Connection "IP ADDRESS SERVER" -Count 3 -Quiet)
                    if ($conn -eq "true"){
                        $CRE = Read-Host "Entre com seu LOGIN de REDE "
#           [O WINDOWS VAI ABRIR UM POP-UP MOSTRANDO O USUARIO DE REDE FORNECIDO E SOLICITANDO  SENHA PARA MONTAR UMA UNIDADE TEMPORARIA DA PASTA DO SERVIDOR QUE TEM OS ARQUIVOS PARA INSTALACAO]
                        New-PSDrive -Name K -PSProvider FileSystem -Root "\\0.0.0.0\PASTA COMPARTILHADA" -Credential $CRE.ToLower() -Scope Global
                        Write-Host "Servidor conectado com sucesso, Prosseguindo com o Setup" -ForegroundColor Green
                    } else {
                        Write-Host "Sem acesso ao servidor, verifique sua conexao de Rede" -ForegroundColor Red
                    }
#            [EFETUANDO COPIA DOS ARQUIVOS DO SERVIDOR PARA A PASTA LOCAL]
             Write-Host "Iniciando Copia dos arquivos para o repositorio local"
             copy '\\0.0.0.0\PASTA COMPARTILHADA\PROGRAMA_1.exe' 'C:\Suporte'
             copy '\\0.0.0.0\PASTA COMPARTILHADA\PROGRAMA_2.msi' 'C:\Suporte'
             copy '\\0.0.0.0\PASTA COMPARTILHADA\Auto_Setup_Machine.bat' 'C:\Suporte'

              #[FAZENDO DOWNLOAD DE ARQUIVOS DIRETO DA INTERNET (DEPENDENDO DO AMBIENTE)]
              cd 'C:\Suporte'
              wget https://www.7-zip.org/a/7z1900-x64.exe -OutFile 7zipSetup.exe
              wget https://www.zoom.us/client/latest/ZoomInstallerFull.msi -OutFile ZoomSetup.msi
              wget https://slack.com/ssb/download-win64-msi-legacy -OutFile SlackSetup.msi

#             [FAZENDO INSTALACAO DE PROGRAMA COM EXTENSAO ".EXE" COMO EXEMPLOS]
            Write-Host 'Efetuando Instalacao de Programas EXE - Part I'
            Start-Process -Wait -FilePath "C:\Suporte\Setup_AdobeReaderDC.exe" -ArgumentList '/S','/v','/qn' -PassThru
            Start-Process -Wait -FilePath "C:\Suporte\ChromeStandaloneSetup64.exe" -PassThru
            Start-Process -Wait -FilePath "C:\Suporte\GoogleDriveFSSetup.exe" -ArgumentList '--silent','--desktop_shortcut' -PassThru
            Start-Process -Wait -FilePath "C:\Suporte\7zipSetup.exe" -ArgumentList '/S','/v','/qn' -PassThru

#             [PARA FAZER INSTALACAO DE MSI, VC PRECISA CHAMAR UM BAT POR SER MAIS FACIL]
              Write-Host "Efetuando Instalacao de Programas MSI - Part II"
              Start-Process -Wait 'C:\Suporte\Auto_Setup_Machine.bat'

#             [RENOMEANDO UMA MAQUINA USANDO POWERSHELL]
              $LocalUserDefault = "[COLOCA O NOME DO USUARIO ADMINISTRADOR LOCAL]"
              Rename-Computer -NewName $NewHost -LocalCredential $LocalUserDefault -force -Restart
#             [AQUI COMECAO AS ACOES A SEREM EFETUADAS PELA OPCAO 2]
              } '2' {
             Write-Host 'INSTALANDO E CONFIGURANDO O JUMP CLOUD NA MAQUINA'
              cd $env:temp | Invoke-Expression; Invoke-RestMethod -Method Get -URI https://raw.githubusercontent.com/TheJumpCloud/support/master/scripts/windows/InstallWindowsAgent.ps1 -OutFile InstallWindowsAgent.ps1 | Invoke-Expression; ./InstallWindowsAgent.ps1 -JumpCloudConnectKey "INSIRA AQUI SUA CHAVE DE CONEXAO"
#           [FONTE: https://support.jumpcloud.com/support/s/article/agent-deployment-via-command-line1]              
#           [A LINHAS SEGUIR SO FAZENDO A VERIFICACAO SE O SERVICO DO AGENT INICIOU, CASO NAO, ELE REINICIA A MAQUINA]
              Write-Host "Iniciando Servicos do JumpCloud"
#           [ELE AGUARDA 30 SEGUNDOS, PORQUE AINDA EM SEGUNDO PLANO, A INSTALACAO ESTA EM ANDAMENTO]              
              sleep 30
#           [BUSCA O SERVICO E VERIFICA O STATUS]
              $JCService = Get-Service -Name "jumpcloud-agent"
                 if ($JCService.Status -eq "Running")
                    {
                    Write-Host "Serviço esta em Execucao"
                    }
                else {
                      Write-Host "Servico nao iniciou, Reiniciando a maquina"
                      Restart-Computer
                    }
#           [AQUI COMECA AS ACOES DA OPCAO 3]
              } '3' {
            #Iniciando Coleta de Informações para o SETUP
            $PATRIMONIO = Read-Host -Prompt "Entre com o Numero do Patrimonio "
            Write-Host "O numero digitado foi, " $PATRIMONIO.ToInt64()
            $HostNameAtual = hostname
            $HostNameDefault = "[NOMENCLATURA PADRAO DA SUA EMPRESA]"
            $NewHost =  "$HostNameDefault$IDLOFT"
            Write-Host 'O nome atual da maquina:' $HostNameAtual.ToUpper()
            Write-Host 'Ao final desse Script sera alterado para:' $NewHost.ToUpper()
            
#           [RENOMEANDO UMA MAQUINA USANDO POWERSHELL]
            $LocalUserDefault = "[COLOCA O NOME DO USUARIO ADMINISTRADOR LOCAL]"
            Rename-Computer -NewName $NewHost -LocalCredential $LocalUserDefault -force -Restart
         }
     }
#   [Aguarda 10 segundos antes de seguir automaticamente para o final.]
    sleep 10
 }
 until ($selection -eq 'q')

