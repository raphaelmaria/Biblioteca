Crie uma variável contendo uma ação.
$action = New-ScheduledTaskAction -Execute 'comando' -Argument 'Agrumentos do comando'
Exemplo:
$action = New-ScheduledTaskAction -Execute 'ping' -Argument '-n 5 8.8.8.8'

Crie uma variável contendo o gatilho.
$trigger = New-ScheduledTaskTrigger -Daily -At 09am

Crie uma tarefa agendada.
Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "TEST" -Description "MY SCHEDULED TASK"

Liste todas as tarefas agendadas criadas por um usuário específico.
Get-ScheduledTask | where author -like "tech\administrator"


Exclua uma tarefa agendada.
Unregister-ScheduledTask -TaskName "TEST" -Confirm: $false


