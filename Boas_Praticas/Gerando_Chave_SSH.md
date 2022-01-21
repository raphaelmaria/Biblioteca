# Como criar e utilizar uma chave SSH (no Windows e Linux)

Fonte: https://tecdicas.com/como-criar-e-utilizar-chaves-ssh-no-windows-e-linux/

17 de Novembro de 2019 às 11:53

Chaves SSH são uma forma segura de identificar usuários conhecidos, substituindo o tradicional "usuário e senha". Sua vantagem está na quantidade de caracteres em relação à uma senha tradicional, fazendo com que ataques bruteforce sejam inviabilizados devido ao tempo absurdo necessário para se "encontrar" a chave secreta através de tentativa e erro.

Algumas plataformas que oferecem servidores VPS (como a Digital Ocean) utilizam deste método de autenticação e desativam o login por usuário e senha para mantê-lo mais seguros. Portanto para acessá-los, você precisa ter uma chave.

Esta chave pode ser gerada tanto no Windows quanto no Linux, e são um "par", sendo a chave pública (enviada para os servidores que você possui permissão para acessar) e a chave privada (somente você deve possuir e pode ser criptografada com uma senha).

Você pode adicionar a sua chave pública a mais de um usuário ou até mesmo em servidores diferentes, desde que você utilize sua chave privada para entrar nestes servidores (a qual por padrão fica salva em seu usuário no Linux), não terá nenhum problema.

Neste artigo iremos abordar os seguintes tópicos:

        Gerando uma chave SSH no Linux;
        Gerando uma chave SSH no Windows;
        Copiando uma chave pública para um servidor Linux;
        Conectando-se à um servidor sua chave privada;

Foram utilizados os sistemas Ubuntu 18.04 e Windows 10 para testes, no entanto, distribuições similares ao Ubuntu podem funcionar sem nenhum problema.

## Gerando uma chave SSH no Linux

Execute o comandos abaixo para gerar sua chave.

            ssh-keygen -t rsa

Em seguida você será questionado onde deseja salvar a chave, mantenha os locais com o padrão indicado e após isso informe uma senha. É altamente recomendável informar uma senha para sua chave, no entanto, caso você deseje ter um login automático, não poderá usar uma senha.

Para visualizar a chave pública gerada (a que você irá informar previamente aos outros hosts), use o comando abaixo.

            cat /home/renan/.ssh/id_rsa.pub

Agora o próximo passo é copiar sua chave pública para um servidor Linux, para que possa então fazer o login usando sua chave. Iremos falar disso adiante neste artigo.

## Gerando uma chave SSH no Windows

Caso você esteja utilizando o Subsistema Windows para Linux, abra o seu terminal e siga os mesmos passos informados para o Linux. Do contrário, você irá precisar do software PuTTY.

[Clique aqui para baixar o PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html)

Após instalar, procure no menu iniciar um atalho com o nome "PuTTYGen" e o execute. Com o programa aberto, basta pressionar o botão "Generate" e mover o cursor aleatoriamente pela parte "vazia" do programa, a fim de gerar movimentos aleatórios que serão usados para gerar sua chave.

Tela do PuTTY após gerar uma chave

Copie a chave pública gerada na caixa de texto "ssh-rsa [...]" para um bloco de notas, pois você irá utilizá-la mais tarde para informar à um servidor Linux.Caso deseje criptografar sua chave privada, informe uma senha nos campos "Key passphrase" e "Confirm passphrase".

Agora salve suas chaves usando os botões "Save public key" e "Save private key", lembre-se de guardar bem estes artigos! O próximo passo é copiar sua chave SSH para um servidor Linux.

## Copiando uma chave pública para um servidor Linux

Este método é indicado para instalar chaves em servidores já existentes e não se aplica caso você esteja configurando o seu primeiro acesso à um VPS da Digital Ocean.

### Instalando a chave automaticamente (somente Linux)
Caso você esteja utilizando Linux (no seu computador local, e não em seu servidor), você poderá utilizar uma forma mais automatizada, apenas digitando o comando abaixo

        ssh-copy-id renan@192.168.3.1

Lembre-se de alterar o usuário e o servidor para qual a chave será copiada. Após realizado este procedimento, sua chave já estará instalada e você poderá logar no usuário e hosts especificado apenas usando o comando.

        ssh renan@192.168.3.1

Instalando a chave manualmente (Linux e Windows)
Faça login em seu servidor Linux (usando usuário e senha, ou através de um console de sua VPS). O usuário que você logou na VPS será o usuário onde a chave pública será instalada.

Digite o comado abaixo para criar o arquivo "authorized_keys" na pasta ".ssh" de seu usuário. O comando não fará nada caso este arquivo já exista.

        mkdir --mode=600 -p ~/.ssh && touch ~/.ssh/authorized_keys

Em seguida, copie o conteúdo de sua chave pública gerada nos passos anteriores deste artigo. Utilize o seu editor de preferência para editar o arquivo "authorized_keys". Utilizaremos o nano como exemplo.

        nano ~/.ssh/authorized_keys

Caso você não possua o nano instalado, basta executar o comando abaixo e tentar novamente.

        sudo apt update && sudo apt install nano

Cole sua chave pública gerada no arquivo, caso este arquivo não esteja vazio, lembre-se de colocar sua chave em uma nova linha! Para colar em um terminal Linux, utilize o botão direito ao invés do Ctrl+V (note que isto pode variar de acordo com o terminal que está utilizando).

Pressione Ctrl+X, digite Y e pressione ENTER para salvar (caso esteja usando o nano)

A partir de agora você já poderá fazer login usando sua chave. Desconecte-se de seu servidor para realizar os testes.

## Conectando-se à um servidor usando sua chave privada

Após a instalação da chave, basta conectar-se em seu servidor. Para usuários Linux, o comando é bem simples, com o usuário que você gerou a chave, tente se conectar ao servidor usando o comando.

        ssh renan@192.168.3.1

Lembre-se de alterar o comando acima para o usuário e servidor no qual você copiou sua chave pública. Caso tudo tenha dado certo, você já estará utilizando sua chave.

Para usuários Windows, abra o aplicativo "PuTTY" e em hosts, adicione o nome do usuário e servidor para qual você copiou sua chave pública.

Neste exemplo, foi usado renan@192.168.3.1 em "Host Name"

Agora navegue até o item "Connection" >> "SSH" >> "Auth", no menu esquerdo do programa e adicione sua chave privada em "private key file for authentication".

Configuração da chave privada
Configuração da chave privada
Volte novamente no menu "Session", no menu esquerdo do programa e digite um nome para sua sessão (qualquer nome) e clique em "Save", assim você não precisará fazer esta configuração novamente.

Exemplo Tecdicas
Exemplo Tecdicas
Agora basta dar dois cliques em sua sessão e o PuTTY irá conectar-se ao seu servidor usando sua chave.

Renan Cavalieri
Analista de Sistemas e autor do tecdicas