Projeto - Confecção de Imagem Linux

Distro = Ubuntu 20.04
Kernel Version = 

Tipo de Hardware Homologado: Virtual Machine
Processador: Intel i7 #6th Generation - 2 Cores 3.40GHz
Memória: 4 GB Ram DDR 4 2133Mhz
SSD: 60 GB SATA #3 Generation

Observações
Docker: Agora é um software pago para uso coorporativo
https://www.docker.com/pricing

SQLDeveloper: é um software pago
Consultando outras fontes para mais informacao, pq pelo site da Oracle, ele exige cadastro para download.

Postman: precisa verificar se realmente é necessario se optaram em manter o Docker.

Os Softwares abaixo são exclusivos para uso em Windows.
Existe um meio de rodar usando um emulação chamada Wine, mas não recomendo pois da muitos crashs nas aplicações.
WinSCP
WinMERGE
CynWin
SourceTree
EnterpriseArchitect

Não são softwares, mas ferramentas de integracao que usam o navegador, ficando a responsabilidade do desenvolvedor fazer a configuração:
Buddy

Softwares abaixo ainda faltam informaçoes:
DLP
PROXY

Para criar imagem em wim:
https://wimlib.net/


Criptografia

É possivel efetuar a criptografia após a instalação, mas isso só é possivel fazer em uma unica pasta, alocada em uma partição a parte.
Em detalhes, se a partição /home estiver em um disco diferente ou partição a parte do "/", basta instalar o CryptSetup e seguir esse [artigo](https://linuxdicasesuporte.blogspot.com/2019/11/criptografar-sua-particao-home-no.html).
Com analise no contéudo, se torna inviavel, pq o processo precisa ser feito manual exigindo um conhecimento mais amplo do sistema operacional linux e sua linha de comando em Bash.

Tela de Criptografia que é executada na inicialização do sistema Linux
![Para carregar o sistema](https://imgur.com/a/7CKO3sL)
