# Listando usuários encontrados na pasta C:\Users
$users = Get-ChildItem -Path C:\Users | Where-Object { $_.PSIsContainer } | Select-Object -ExpandProperty Name

# Exibindo lista de usuários para seleção da origem
$selectedUserSource = Read-Host "Selecione o usuário de origem: " -Prompt ($users -join ", ")

# Exibindo lista de usuários para seleção do destino
$selectedUserDestination = Read-Host "Selecione o usuário de destino: " -Prompt ($users -join ", ")

# Copiando pastas selecionadas do usuário de origem para o destino
$foldersToCopy = @("Documents", "Downloads", "Pictures", "AppData\Local", "AppData\Roaming")

foreach ($folder in $foldersToCopy) {
    $sourcePath = "C:\Users\$selectedUserSource\$folder"
    $destinationPath = "C:\Users\$selectedUserDestination\$folder"
    if (Test-Path $sourcePath -PathType Container) {
        Copy-Item -Path $sourcePath -Destination $destinationPath -Recurse -Force
        Write-Host "Pasta $folder copiada com sucesso de $selectedUserSource para $selectedUserDestination."
    } else {
        Write-Warning "A pasta $folder não existe em $selectedUserSource."
    }
}
