# Definir informações do usuário
$nomeUsuario = "mestrebionexo"
$senhaUsuario = ConvertTo-SecureString -String "ACESSO.HELPnexo*!#!" -AsPlainText -Force

# Criar o usuário
$usuario = New-LocalUser -Name $nomeUsuario -Password $senhaUsuario -FullName $nomeUsuario -Description "Usuário de Suporte Corporativo" -PasswordNeverExpires

# Adicionar usuário ao grupo de administradores
Add-LocalGroupMember -Group "Administradores" -Member $nomeUsuario

# Exibir informações do usuário
$usuario
