#MUDE A LETRA DA UNIDADE AQUI:
#$unidUSB="f:"

# Função para listar todas as unidades USB
function Get-USBDrives {
    Get-PSDrive -PSProvider FileSystem | Where-Object { $_.Root -match '^[A-Z]:\\$' }
}

# Listar as unidades USB disponíveis
$usbDrives = Get-USBDrives

# Mostrar as unidades USB disponíveis ao usuário
Write-Host "Unidades USB disponíveis:"
foreach ($drive in $usbDrives) {
    Write-Host "$($drive.Name): $($drive.Root)"
}

# Solicitar que o usuário selecione uma unidade
$unidUSB = Read-Host "Digite a letra da unidade USB com a qual deseja trabalhar (ex: E)"

# Verificar se a unidade selecionada é válida
if ($usbDrives.Name -contains $unidUSB) {
    $unidUSB = "${unidUSB}:"
    Write-Host "Você selecionou a unidade USB: $unidUSB"
} else {
    Write-Host "Unidade USB inválida. Por favor, execute o script novamente e selecione uma unidade válida."
    exit
}

# VARIAVEIS IMPORTANTES -- NÃO MEXER
$pathPlaylist = "$unidUSB\playlist"
$pathATARI = "$unidUSB\roms\atari"
$pathCPS = "$unidUSB\roms\cps"
$pathFC = "$unidUSB\roms\fc"
$pathGB = "$unidUSB\roms\gb"
$pathGBC = "$unidUSB\roms\gbc"
$pathGBA = "$unidUSB\roms\gba"
$pathMD = "$unidUSB\roms\md"
$pathPS1 = "$unidUSB\roms\ps1"
$pathSFC = "$unidUSB\roms\sfc"
$pathSMS = "$unidUSB\roms\sms"
$pathZ64 = "$unidUSB\roms\z64"

# MENU
function Show-Menu {
    param (
        [string] $Title = "Atualizar Playlist Y3 Lite - v1.0"
    )
    Write-Host $Title
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
}

function Update-Playlist {
    param (
        [string] $path,
        [string] $playlistName
    )
    $oldPlaylist = "$unidUSB\playlist\$playlistName`OLD.pl"
    $newPlaylist = "$unidUSB\playlist\$playlistName.pl"

    if (Test-Path -Path $oldPlaylist) {
        Remove-Item -Path $oldPlaylist -Force
    }

    if (Test-Path -Path $newPlaylist) {
        Rename-Item -Path $newPlaylist -NewName $oldPlaylist
    }

    if (-not (Test-Path $path -PathType Container)) {
        Write-Host "O caminho da pasta $path não é válido."
        exit
    }

    $arquivos = Get-ChildItem -Path $path | Where-Object { $_.Extension -ne ".png" }
    $listaArquivos = @()

    foreach ($arquivo in $arquivos) {
        $nome = $arquivo.BaseName
        $extensao = $arquivo.Extension
        $nomeFormatado = "$nome$extensao <$nome>"
        $listaArquivos += $nomeFormatado
    }

    $listaArquivos | Out-File -FilePath $newPlaylist -Encoding utf8
    Write-Host "Lista de arquivos foi salva em $newPlaylist."
}

do {
    Show-Menu
    $selection = Read-Host "Qual a licença desejada: "
    switch ($selection) {
        '1' {
            Rename-Item -Path $unidUSB\playlist -NewName "$unidUSB\playlistOLD"
            New-Item -Path $unidUSB\playlist -ItemType Directory
            Update-Playlist -path $pathATARI -playlistName "atari"
            Update-Playlist -path $pathCPS -playlistName "cps"
            Update-Playlist -path $pathFC -playlistName "fc"
            Update-Playlist -path $pathGB -playlistName "gb"
            Update-Playlist -path $pathGBC -playlistName "gbc"
            Update-Playlist -path $pathGBA -playlistName "gba"
            Update-Playlist -path $pathMD -playlistName "md"
            Update-Playlist -path $pathPS1 -playlistName "ps1"
            Update-Playlist -path $pathSFC -playlistName "sfc"
            Update-Playlist -path $pathSMS -playlistName "sms"
            Update-Playlist -path $pathZ64 -playlistName "z64"
        }
        '2' { Update-Playlist -path $pathATARI -playlistName "atari" }
        '3' { Update-Playlist -path $pathCPS -playlistName "cps" }
        '4' { Update-Playlist -path $pathFC -playlistName "fc" }
        '5' { Update-Playlist -path $pathGB -playlistName "gb" }
        '6' { Update-Playlist -path $pathGBC -playlistName "gbc" }
        '7' { Update-Playlist -path $pathGBA -playlistName "gba" }
        '8' { Update-Playlist -path $pathMD -playlistName "md" }
        '9' { Update-Playlist -path $pathPS1 -playlistName "ps1" }
        '10' { Update-Playlist -path $pathSFC -playlistName "sfc" }
        '11' { Update-Playlist -path $pathSMS -playlistName "sms" }
        '12' { Update-Playlist -path $pathZ64 -playlistName "z64" }
        'q' { Write-Host "Saindo do script..." }
        default { Write-Host "Opção inválida. Tente novamente." }
    }
} until ($selection -eq 'q')
