🔐 Esqueceu a senha do Windows?

Quem trabalha com TI já passou por isso: usuário esqueceu a senha, sem outro login disponível e sem backup. Ao invés de formatar, usei uma solução clássica: reset de senha via Prompt de Comando no modo de recuperação. ⚙️

⚠️ Use com responsabilidade e somente em máquinas autorizadas.

🛠️ Passo a passo (Windows 10/11):

🔄 1. Acesse o Modo de Recuperação
Pressione Shift + Reiniciar na tela de login.
Depois vá em: Solução de Problemas > Opções Avançadas > Prompt de Comando.
No Prompt, verifique se a unidade principal é C: e acesse o diretório
 System32:
 C:
 cd Windows
 cd System32

🔄 2. Altere os arquivos do sistema
Digite os comandos:

ren utilman.exe utilman_backup.exe
ren cmd.exe utilman.exe

Isso permitirá abrir o Prompt de Comando diretamente da tela de login.

🔄 3. Redefina a senha
 Reinicie o computador normalmente.
 Na tela de login, clique no ícone de acessibilidade.
 O Prompt será aberto — digite:
 control userpasswords2

Selecione o usuário desejado, clique em Redefinir Senha, crie uma nova senha e reinicie.

🔄 4. Restaure os arquivos originais
Acesse novamente o Prompt de Comando pelo Modo de Recuperação e digite:

 ren utilman.exe cmd.exe
 ren utilman_backup.exe utilman.exe

✅ Pronto! Sem formatação, sem perda de dados.