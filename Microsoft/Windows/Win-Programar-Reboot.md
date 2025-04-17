Definindo Tempo para Reiniciar ou Desligar o Windows
O agendamento do desligamento do Windows é realizado pelo comando shutdown, conforme abaixo:

shutdown -s -t #### (#### é o tempo em segundos)

1 Hora = 3600  Segundos -> shutdown -s -t 3600
2 Horas = 7200 Segundos -> shutdown -s -t 7200
3 Horas = 10800 Segundos -> shutdown -s -t 10800
4 Horas = 14400 Segundos -> shutdown -s -t 14400
5 Horas = 18000 Segundos -> shutdown -s -t 18000
6 Horas = 21600 Segundos -> shutdown -s -t 21600
7 Horas = 25200 Segundos -> shutdown -s -t 25200
8 Horas = 28800 Segundos -> shutdown -s -t 28800
9 Horas = 32400 Segundos -> shutdown -s -t 32400
10 Horas = 36000 Segundos -> shutdown -s -t 36000

Para Programar o Windows para desligar após 5 horas, por exemplo, usa-se o comando:

shutdown -s -t 18000

Cancelando um Agendamento
Para Cancelar o agendamento de Desligamento do Windows, utilizamos o comando:

shutdown -a

Reiniciar o Comutador
Caso você queira agendar um restart (reiniciar) do computador, pode utilizar a opção -r:

shutdown -r – reiniciar o computador

Exemplo: shutdown -r -t 3600

O Windows será reiniciado após 1 Hora da execução do comando.

Outras recursos do Comando Shutdown
O comando shutdown possui outros recursos e opções

Para acessar o help ou ajuda do comando, você pode digitar no prompt de comando:

shutdown /? ou  shutdown

Uso: shutdown [/i | /l | /s | /r | /g | /a | /p | /h | /e] [/f] [/m \\computador][/t xxx][/d [p:]xx:yy [/c “comentário”]]

Sem argumentos – Exibir ajuda. É o mesmo que digitar /?.
/? Exibir ajuda. É o mesmo que não digitar nenhuma opção.
/i Exibir a interface gráfica do usuário (GUI). Esta deve ser a primeira opção.
/l Fazer logoff. Não deve ser usada com a opção /m ou /d
/s Desligar o computador.
/r Desligar e reiniciar o computador.
/g Desligar e reiniciar o computador. Depois que o sistema for reiniciado, inicie novamente aplicativos registrados.
/a Anular um desligamento do sistema. Só pode ser usado durante o período de tempo limite.
/p Desativar computador local sem nenhum tempo limite ou aviso. Pode ser usado com as opções /d e /f.
/h Hibernar o computador local.
Pode ser usado com a opção /f.
/e Documentar o motivo de um encerramento inesperado de um computador.
/m \\computer Especificar o computador de destino.
/t xxx Definir o período de tempo limite antes do desligamento para xxx segundos.
O intervalo válido é de 0 a 315360000 (10 anos), com um padrão de 30.
Se o tempo limite for maior que 0, o parâmetro /f será implícito.
/c “comentário” Comentar o motivo da reinicialização ou do desligamento. Máximo de 512 caracteres permitido.
/f Forçar o fechamento dos aplicativos em execução sem avisar os usuários.
O parâmetro /f é implícito quando um valor maior que 0 é especificado para o parâmetro /t.
/d [p|u:]xx:yy Forneça o motivo da reinicialização ou do desligamento.
p indica que a reinicialização ou o encerramento é planejado.
u indica que o motivo é definido pelo usuário.
Se nem p nem u forem especificados, o reinício ou encerramento não será planejado.
xx é o número da razão primária (inteiro positivo menor que 256).
yy é o número da razão secundária (inteiro positivo menor que 65536).

Aplica-se ao:  Windows XP, Windows Vista, Windows 7, Windows 8, Windows 10, Windows Server.

Outra possibilidade para programar o desligamento do Windows é utilizando o Agendador de Tarefas do Windows

Para acessa-lo, basta ir em Iniciar / Programas / Acessórios / Ferramentas de sistema / Agendador de Tarefas.

Criar uma tarefa e incluir o comando shutdown conforme o tempo que você deseja que o windows seja desligado ou reiniciado.