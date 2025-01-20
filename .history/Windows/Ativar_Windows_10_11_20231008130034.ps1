if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit}

#   [LIBERA A EXECUCAO DESSES SCRIPT NA MAQUINA PARA FAZER A ALTERACOES]
Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Force -Confirm:$false | Out-Null 
Set-ExecutionPolicy RemoteSigned -Confirm:$false | Out-Null

# SERIAIS VALIDOS (fonte: https://www.youtube.com/watch?v=Xvy9WtOnQl4)
$homeAll="TX9XD-98N7V-6WMQ6-BX7FG-H8Q99"
#Home/Core (Country Specific)   PVMJN-6DFY6-9CCP6-7BKTT-D3WVR
$homeSL="7HNRX-D7KGG-3K4RQ-4WPJ4-YTDFH"
#Home/Core N                    3KHY7-WNT83-DGQKR-F7HPR-844BM
$professional="W269N-WFGWX-YVC9B-4J6C9-T83GX"
#Professional N                 MH37W-N47XK-V7XM9-C7227-GCQG9
$enterprise="NPPR9-FWDCX-D2C8J-H872K-2YT43"
#Enterprise N                   DPH2V-TTNVB-4X9Q3-TJR4H-KHJW4
$education="NW6C2-QMPVW-D7KKK-3GKT6-VCFB2"
#Education N                    2WH4N-8QGBV-H22JP-CT43Q-MDWWJ
$enterprise2015LTSB="WNMTR-4C88C-JK8YV-HQ7T2-76DF9"
#Enterprise 2015 LTSB N         2F77B-TNFGY-69QQF-B8YKP-D69TJ
$Enterprise2016LTSB="DCPHK-NFMTC-H88MJ-PFHPY-QJ4BJ"
#Enterprise 2016 LTSB N         QFFDN-GRT3P-VKWWX-X7T3R-8B639

function Show-Menu {
    param (
        [string] $Title = "Ativação de Windows Local - v1.0"
    )
    write-host $Title
    write-host "Escolha a versão da licenças"
    write-host "Pressione '1' para Versão HOME"
    write-host "Pressione '2' para Versão HOME (Single Language)"
    write-host "Pressione '3' para Versão PROFISSIONAL"
    write-host "Pressione '4' para Versão ENTERPRISE"
    write-host "Pressione '5' para Versão EDUCATION"
    write-host "Pressione '6' para Versão Enterprise 2015 LTSB"
    write-host "Pressione '7' para Versão Enterprise 2016 LTSB"
    write-host "Pressione 'R' para reparar em caso de erro"
    write-host "Pressione 'Q' para sair!"
    
}do{
    Show-Menu
    $selection = Read-Host "Qual a licença desejada: "
    switch ($selection)
    {
        '1'{
            cmd /c "cscript slmgr.vbs /ipk $homeAll"
            cmd /c "cscript slmgr.vbs /skms kms.lotro.cc"
            cmd /c "cscript slmgr.vbs /ato"
        } '2' {
            cmd /c "cscript slmgr.vbs /ipk $homeSL"
            cmd /c "cscript slmgr.vbs /skms kms.lotro.cc"
            cmd /c "cscript slmgr.vbs /ato"
        } '3' {
            cmd /c "cscript slmgr.vbs /ipk $professional"
            cmd /c "cscript slmgr.vbs /skms kms.lotro.cc"
            cmd /c "cscript slmgr.vbs /ato"
        } '4' {
            cmd /c "cscript slmgr.vbs /ipk $enterprise"
            cmd /c "cscript slmgr.vbs /skms kms.lotro.cc"
            cmd /c "cscript slmgr.vbs /ato"
        } '5' {
            cmd /c "cscript slmgr.vbs /ipk $education"
            cmd /c "cscript slmgr.vbs /skms kms.lotro.cc"
            cmd /c "cscript slmgr.vbs /ato"
        } '6' {
            cmd /c "cscript slmgr.vbs /ipk $enterprise2015LTSB"
            cmd /c "cscript slmgr.vbs /skms kms.lotro.cc"
            cmd /c "cscript slmgr.vbs /ato"
        } '7' {
            cmd /c "cscript slmgr.vbs /ipk $Enterprise2016LTSB"
            cmd /c "cscript slmgr.vbs /skms kms.lotro.cc"
            cmd /c "cscript slmgr.vbs /ato"
        } 'R' {
            cmd /c "slmgr /dlv"
            cmd /c "slmgr /upk"
        } 
    
    }
}
until ( $selection -eq 'q' )