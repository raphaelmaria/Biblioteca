Release Version 1.0:
     
    -Date 07/01/2022
    -Confeccionado o script inicial e organizado estrutura de processos para instalacao

Release Version 1.1:
     
    -Data 07/01/2022
    -Adicionei algumas simplificações de instalacao usando a SNAP Store.
    -Que agregar boa parte das ferramentas e simplifica a instalação

Release Version 1.2:
 
    -Date 10/01/2022
    -Simplificado instalação do Java versões JRE e JDK.
    -Instalacao do Wine e da Biblioteca Mono C++
    -Refeito algumas linhas de informacoes.
    -Teste de aplicativos em EXE e MSI usando Wine.
    -Efetuados com sucesso e suas particulariedades de erros, mas em sua maioria estão todos rodando.
    -WinSCP - Funcionando
    -WinMerge - Funcionando
    -Enterprise Architect - Funcionando

Release Version 1.3:

    -Efetuado elaboração da Remoção da Interface Gnome 3.
    -Efetuado instalação da Interface Cinnamon
    -Aplicado campo interativo para instalação do Crown Strike Falcon, onde ele vai solicitar a chave do tenant do cliente.
    -Criado sessão para criação de usuário local.

Release Version 1.4:
 
    -Adicionado pacotes Libxml2 e ntfs-3g
    -Corrigido instalação do SQL Developer com apontamento do arquivo alocado no meu AWS S3 Bucket.
    Tomei essa medida, pq para baixar da Oracle, agora é necessário sempre logar com uma conta autenticada.
    -Alterado nome da pasta que recebe os EXEs e MSIs de "deploy" para "windowsApps"
    -Criado rotina de atualizacao via AWS S3 Bucket, sera efetuado download e instalacao de alguns apps a parte deste repositorio.
    -Criado rotina semanal para analise de atualizacao de apps nativos do Ubuntu.
    -Acressentado a instalacao do Synaptic, gerenciado de facil uso para instalacao em Distro Debian/Ubuntu
    
Release Version 1.5:
 
    -Efetuado comentários em linhas para teste.
    -Efetuado organização para otimização do código.
    -Adicionado complementos que acressentam melhorias ao emulador Wine e criam os atalhos do apps EXE e MSI na dashboard do Gnome.
    -Removido CygWin por ser um emulador de terminar Bashrc, o usuário pode usar o nativo através do terminal.
    -Adicionado Link Curto para download e instalacao

Release Version 1.6:

    -Adicionado chave de ativação do Crown Strike Falcon
    -Adicionado instalador do Microsoft Teams
    -Adicionado instalador do CheckPoint SSL VPN
    -Desativado instalação do Force Point, porque não tem compatibilidade com Linux.
    -Adicionado instalador do Qualys - Analise de Vulnerabilidade.
    -Criado novo repositorio na AWS S3 - alelodev
    -Removido softwares criados para Windows para evitar problemas e pela maior parte já possuir recursos nativos dentro do Linux.


