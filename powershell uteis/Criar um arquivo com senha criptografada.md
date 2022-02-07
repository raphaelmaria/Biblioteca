
#Script Pronto - Generico
#Digite a senha desejada e será guardada na variavel de nome $password
$password = read-host "Password" -AsSecureString

#Gera a Chave de Criptografia
$key = (1,85,2,5,243,56,98,186,2,7,1,9,3,45,123,77,222,111,38,33,21,199,21,78,232,156,45,89,162,55,251,32)

#Tarefa que vai pegar a senha e gerar o arquivo com a senha criptografada em um TXT
$password | ConvertFrom-SecureString -key $key | Set-Content C:\Suporte\NMHnote.txt

#Nesse processo o arquivo vai ser lido para gerar a chave assimetrica que deve ser usada em conjunto.
Get-Content C:\Suporte\NMHnote.txt

#Gera Gerando a chave Assimetrica
$key | Set-Content C:\Suporte\NMHkey.txt



#No final vai haver dois arquivos.
Para importar isso via Powershell vc vai usar o seguinte comando.
$LocalUser = Get-LocalUser -Name "UserName" # Localiza se o usuário UserName existe
$Password = (Get-Content C:\Suporte\note.txt) | ConvertTo-SecureString -key (Get-Content C:\Suporte\key.txt) #Verifica se os arquivos esta na pasta
$LocalUser | Set-LocalUser -Password $Password # Inseri a senha criptografada no usuario