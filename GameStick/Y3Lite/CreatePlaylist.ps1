#MUDE A LETRA DA UNIDADE AQUI:
#$unidUSB="f:"
# FunÁ„o para listar todas as unidades USB
function Get-USBDrives {
    Get-PSDrive -PSProvider FileSystem | Where-Object { $_.Root -match '^[A-Z]:\\$' }
}

# Listar as unidades USB disponÌveis
$usbDrives = Get-USBDrives

# Mostrar as unidades USB disponÌveis ao usu·rio
Write-Host "Unidades USB disponÌveis:"
foreach ($drive in $usbDrives) {
    Write-Host "$($drive.Name): $($drive.Root)"
}

# Solicitar que o usu·rio selecione uma unidade
$unidUSB = Read-Host "Digite a letra da unidade USB com a qual deseja trabalhar (ex: E)"

# Verificar se a unidade selecionada È v·lida
if ($usbDrives.Name -contains $unidUSB) {
    $unidUSB = "${unidUSB}:"
    Write-Host "VocÍ selecionou a unidade USB: $unidUSB"
} else {
    Write-Host "Unidade USB inv·lida. Por favor, execute o script novamente e selecione uma unidade v·lida."
}

# VARIAVEIS IMPORTANTES -- N√ÉO MEXE
$pathPlaylist="$unidUSB\playlist"
$pathATARI="$unidUSB\roms\atari"
$pathCPS="$unidUSB\roms\cps"
$pathFC="$unidUSB\roms\fc"
$pathGB="$unidUSB\roms\gb"
$pathGBC="$unidUSB\roms\gbc"
$pathGBA="$unidUSB\roms\gba"
$pathMD="$unidUSB\roms\md"
$pathPS1="$unidUSB\roms\ps1"
$pathSFC="$unidUSB\roms\sfc"
$pathSMS="$unidUSB\roms\sms"
$pathZ64="$unidUSB\roms\z64"


# MENU
function Show-Menu {
 param (
 [string] $Title = "Atualizar Playlist Y3 Lite - v1.0"
 )
 write-Host $Title
 Write-Host "Pressione '1' para atualizar todas"
 Write-Host "Pressione '2' para atualizar ATARI"
 Write-Host "Pressione '3' para atualizar ARCADE/MAME"
 Write-Host "Pressione '4' para atualizar NINTENDINHO"
 Write-Host "Pressione '5' para atualizar GameBoy"
 Write-Host "Pressione '6' para atualizar GameBoy Color"
 Write-Host "Pressione '7' para atualizar GameBoy Advanced"
 Write-Host "Pressione '8' para atualizar MegaDrive"
 Write-Host "Pressione '9' para atualizar Playstation One"
 Write-Host "Pressione '10' para atualizar Super Nintendo"
 Write-Host "Pressione '11' para atualizar Master System"
 Write-Host "Pressione '12' para atualizar Nintendo 64"
 Write-Host "Pressione 'q' para sair"

 }do{
    Show-Menu
    $selection = Read-Host "Qual a licenÁa desejada: "
    switch ($selection)
    {
        '1'{
        Rename-Item $unidUSB\playlist $unidUSB\playlistOLD
        New-Item -Path $unidUSB\playlist -ItemType Directory

        #----------------------------------
        } '2' {
         if (Test-Path -Path $unidUSB\playlist\atariOLD.pl) {
             Remove-Item -Path $unidUSB\playlist\atariOLD.pl -Force
            }

            Rename-Item $unidUSB\playlist\atari.pl $unidUSB\playlist\atariOLD.pl
        
            if (-not (Test-Path $pathATARI -PathType Container)) {
                Write-Host "O caminho da pasta n„o È v·lido."
            exit
            }

            $arquivos = Get-ChildItem $pathATARI | Where-Object { $_.Extension -ne ".png" }
            $listaArquivos = @()

            foreach ($arquivo in $arquivos) {
            $nome = $arquivo.BaseName
            $extensao = $arquivo.Extension
            $nomeFormatado = "$nome$extensao <$nome>"
            $listaArquivos += $nomeFormatado
            }
        
            $arquivoSaida = "$unidUSB\playlist\atari.pl"
            $listaArquivos | Out-File -FilePath $arquivoSaida -Encoding utf8
            Write-Host "Lista de arquivos do ATARI foi salva em $arquivoSaida."
        #----------------------------------
        } '3' {
            if (Test-Path -Path $unidUSB\playlist\cpsOLD.pl) {
                Remove-Item -Path $unidUSB\playlist\cpsOLD.pl -Force
            }

            Rename-Item $unidUSB\playlist\cps.pl $unidUSB\playlist\cps.pl
        
            if (-not (Test-Path $pathCPS -PathType Container)) {
                Write-Host "O caminho da pasta n„o È v·lido."
            exit
            }

            $arquivos = Get-ChildItem $pathCPS | Where-Object { $_.Extension -ne ".png" }
            $listaArquivos = @()

            foreach ($arquivo in $arquivos) {
            $nome = $arquivo.BaseName
            $extensao = $arquivo.Extension
            $nomeFormatado = "$nome$extensao <$nome>"
            $listaArquivos += $nomeFormatado
            }
        
            $arquivoSaida = "$unidUSB\playlist\cps.pl"
            $listaArquivos | Out-File -FilePath $arquivoSaida -Encoding utf8
            Write-Host "Lista de arquivos do MAME foi salva em $arquivoSaida."
        #----------------------------------
        } '4' {
          if (Test-Path -Path $unidUSB\playlist\fcOLD.pl) {
        Remove-Item -Path $unidUSB\playlist\fcOLD.pl -Force
        }

        Rename-Item $unidUSB\playlist\fc.pl $unidUSB\playlist\fcOLD.pl
        
        if (-not (Test-Path $pathFC -PathType Container)) {
            Write-Host "O caminho da pasta n„o È v·lido."
        exit
        }

        $arquivos = Get-ChildItem $pathFC | Where-Object { $_.Extension -ne ".png" }
        $listaArquivos = @()

        foreach ($arquivo in $arquivos) {
        $nome = $arquivo.BaseName
        $extensao = $arquivo.Extension
        $nomeFormatado = "$nome$extensao <$nome>"
        $listaArquivos += $nomeFormatado
        }
        
        $arquivoSaida = "$unidUSB\playlist\fc.pl"
        $listaArquivos | Out-File -FilePath $arquivoSaida -Encoding utf8
        Write-Host "Lista de arquivos do NINTENDINHO foi salva em $arquivoSaida."
        #-------------------------------------
        } '5' {
           if (Test-Path -Path $unidUSB\playlist\gbOLD.pl) {
        Remove-Item -Path $unidUSB\playlist\gbOLD.pl -Force
        }

        Rename-Item $unidUSB\playlist\gb.pl $unidUSB\playlist\gbOLD.pl
        
        if (-not (Test-Path $pathGB -PathType Container)) {
            Write-Host "O caminho da pasta n„o È v·lido."
        exit
        }

        $arquivos = Get-ChildItem $pathGB | Where-Object { $_.Extension -ne ".png" }
        $listaArquivos = @()

        foreach ($arquivo in $arquivos) {
        $nome = $arquivo.BaseName
        $extensao = $arquivo.Extension
        $nomeFormatado = "$nome$extensao <$nome>"
        $listaArquivos += $nomeFormatado
        }
        
        $arquivoSaida = "$unidUSB\playlist\gb.pl"
        $listaArquivos | Out-File -FilePath $arquivoSaida -Encoding utf8
        Write-Host "Lista de arquivos do GameBoy foi salva em $arquivoSaida."
        } '6' {
            if (Test-Path -Path $unidUSB\playlist\gbcOLD.pl) {
        Remove-Item -Path $unidUSB\playlist\gbcOLD.pl -Force
        }

        Rename-Item $unidUSB\playlist\gbc.pl $unidUSB\playlist\gbcOLD.pl
        
        if (-not (Test-Path $pathGBC -PathType Container)) {
            Write-Host "O caminho da pasta n„o È v·lido."
        exit
        }

        $arquivos = Get-ChildItem $pathGBC | Where-Object { $_.Extension -ne ".png" }
        $listaArquivos = @()

        foreach ($arquivo in $arquivos) {
        $nome = $arquivo.BaseName
        $extensao = $arquivo.Extension
        $nomeFormatado = "$nome$extensao <$nome>"
        $listaArquivos += $nomeFormatado
        }
        
        $arquivoSaida = "$unidUSB\playlist\gbc.pl"
        $listaArquivos | Out-File -FilePath $arquivoSaida -Encoding utf8
        Write-Host "Lista de arquivos do GameBoy Color foi salva em $arquivoSaida."
        #---------------------------------
        } '7' {
        if (Test-Path -Path $unidUSB\playlist\gbaOLD.pl) {
        Remove-Item -Path $unidUSB\playlist\gbaOLD.pl -Force
        }

        Rename-Item $unidUSB\playlist\gba.pl $unidUSB\playlist\gbaOLD.pl
        
        if (-not (Test-Path $pathGBA -PathType Container)) {
            Write-Host "O caminho da pasta n„o È v·lido."
        exit
        }

        $arquivos = Get-ChildItem $pathGBA | Where-Object { $_.Extension -ne ".png" }
        $listaArquivos = @()

        foreach ($arquivo in $arquivos) {
        $nome = $arquivo.BaseName
        $extensao = $arquivo.Extension
        $nomeFormatado = "$nome$extensao <$nome>"
        $listaArquivos += $nomeFormatado
        }
        
        $arquivoSaida = "$unidUSB\playlist\gba.pl"
        $listaArquivos | Out-File -FilePath $arquivoSaida -Encoding utf8
        Write-Host "Lista de arquivos do GameBoy Advenced foi salva em $arquivoSaida."
        
        #------------------------
        } '8' {
        if (Test-Path -Path $unidUSB\playlist\mdOLD.pl) {
        Remove-Item -Path $unidUSB\playlist\mdOLD.pl -Force
        }

        Rename-Item $unidUSB\playlist\md.pl $unidUSB\playlist\mdOLD.pl
        
        if (-not (Test-Path $pathMD -PathType Container)) {
            Write-Host "O caminho da pasta n„o È v·lido."
        exit
        }

        $arquivos = Get-ChildItem $pathMD | Where-Object { $_.Extension -ne ".png" }
        $listaArquivos = @()

        foreach ($arquivo in $arquivos) {
        $nome = $arquivo.BaseName
        $extensao = $arquivo.Extension
        $nomeFormatado = "$nome$extensao <$nome>"
        $listaArquivos += $nomeFormatado
        }
        
        $arquivoSaida = "$unidUSB\playlist\md.pl"
        $listaArquivos | Out-File -FilePath $arquivoSaida -Encoding utf8
        Write-Host "Lista de arquivos do MegaDrive foi salva em $arquivoSaida."
        
        #----------------------------------
        } '9' {
        if (Test-Path -Path $unidUSB\playlist\ps1OLD.pl) {
        Remove-Item -Path $unidUSB\playlist\ps1OLD.pl -Force
        }

        Rename-Item $unidUSB\playlist\ps1.pl $unidUSB\playlist\ps1OLD.pl
        
        if (-not (Test-Path $pathPS1 -PathType Container)) {
            Write-Host "O caminho da pasta n„o È v·lido."
        exit
        }

        $arquivos = Get-ChildItem $pathPS1 | Where-Object { $_.Extension -ne ".png" }
        $listaArquivos = @()

        foreach ($arquivo in $arquivos) {
        $nome = $arquivo.BaseName
        $extensao = $arquivo.Extension
        $nomeFormatado = "$nome$extensao <$nome>"
        $listaArquivos += $nomeFormatado
        }
        
        $arquivoSaida = "$unidUSB\playlist\ps1.pl"
        $listaArquivos | Out-File -FilePath $arquivoSaida -Encoding utf8
        Write-Host "Lista de arquivos do PS1 foi salva em $arquivoSaida."
        
        #------------------------
        } '10' {
        if (Test-Path -Path $unidUSB\playlist\sfcOLD.pl) {
        Remove-Item -Path $unidUSB\playlist\sfcOLD.pl -Force
        }

        Rename-Item $unidUSB\playlist\sfc.pl $unidUSB\playlist\sfcOLD.pl
        
        if (-not (Test-Path $pathSFC -PathType Container)) {
            Write-Host "O caminho da pasta n„o È v·lido."
        exit
        }

        $arquivos = Get-ChildItem $pathSFC | Where-Object { $_.Extension -ne ".png" }
        $listaArquivos = @()

        foreach ($arquivo in $arquivos) {
        $nome = $arquivo.BaseName
        $extensao = $arquivo.Extension
        $nomeFormatado = "$nome$extensao <$nome>"
        $listaArquivos += $nomeFormatado
        }
        
        $arquivoSaida = "$unidUSB\playlist\sfc.pl"
        $listaArquivos | Out-File -FilePath $arquivoSaida -Encoding utf8
        Write-Host "Lista de arquivos do Super Nintendo foi salva em $arquivoSaida."
        #------------------
        } '11' {
        if (Test-Path -Path $unidUSB\playlist\smsOLD.pl) {
        Remove-Item -Path $unidUSB\playlist\smsOLD.pl -Force
        }

        Rename-Item $unidUSB\playlist\sms.pl $unidUSB\playlist\smsOLD.pl
        
        if (-not (Test-Path $pathSMS -PathType Container)) {
            Write-Host "O caminho da pasta n„o È v·lido."
        exit
        }

        $arquivos = Get-ChildItem $pathSMS | Where-Object { $_.Extension -ne ".png" }
        $listaArquivos = @()

        foreach ($arquivo in $arquivos) {
        $nome = $arquivo.BaseName
        $extensao = $arquivo.Extension
        $nomeFormatado = "$nome$extensao <$nome>"
        $listaArquivos += $nomeFormatado
        }
        
        $arquivoSaida = "$unidUSB\playlist\sms.pl"
        $listaArquivos | Out-File -FilePath $arquivoSaida -Encoding utf8
        Write-Host "Lista de arquivos do MasterSystem foi salva em $arquivoSaida."
        #-------------------------------------------
        } '12' {
        if (Test-Path -Path $unidUSB\playlist\z64OLD.pl) {
        Remove-Item -Path $unidUSB\playlist\z64OLD.pl -Force
        }

        Rename-Item $unidUSB\playlist\z64.pl $unidUSB\playlist\z64OLD.pl
        
        if (-not (Test-Path $pathSMS -PathType Container)) {
            Write-Host "O caminho da pasta n„o È v·lido."
        exit
        }

        $arquivos = Get-ChildItem $pathSMS | Where-Object { $_.Extension -ne ".png" }
        $listaArquivos = @()

        foreach ($arquivo in $arquivos) {
        $nome = $arquivo.BaseName
        $extensao = $arquivo.Extension
        $nomeFormatado = "$nome$extensao <$nome>"
        $listaArquivos += $nomeFormatado
        }
        
        $arquivoSaida = "$unidUSB\playlist\z64.pl"
        $listaArquivos | Out-File -FilePath $arquivoSaida -Encoding utf8
        Write-Host "Lista de arquivos do Nintendo 64 foi salva em $arquivoSaida."
           
        } 
    
    }
}
until ( $selection -eq 'q' )


# Verifica se o caminho da pasta √© v√°lido
if (-not (Test-Path $caminho -PathType Container)) {
    Write-Host "O caminho da pasta n√£o √© v√°lido."
    exit
}

# Obt√©m a lista de arquivos na pasta, excluindo arquivos com a extens√£o .png
$arquivos = Get-ChildItem $caminho | Where-Object { $_.Extension -ne ".png" }

# Inicializa uma lista para armazenar os nomes formatados dos arquivos
$listaArquivos = @()

# Itera sobre cada arquivo na pasta
foreach ($arquivo in $arquivos) {
    # Obt√©m o nome do arquivo (sem extens√£o)
    $nome = $arquivo.BaseName
    
    # Obt√©m a extens√£o do arquivo
    $extensao = $arquivo.Extension
    
    # Formata o nome do arquivo
    $nomeFormatado = "$nome$extensao <$nome>"
    
    # Adiciona o nome formatado √† lista
    $listaArquivos += $nomeFormatado
}


# Caminho do arquivo de sa√≠da
$arquivoSaida = "$unidUSB\playlist\$console.pl"

# Escreve a lista formatada no arquivo de sa√≠da
$listaArquivos | Out-File -FilePath $arquivoSaida -Encoding utf8

Write-Host "Lista de arquivos foi salva em $arquivoSaida."
