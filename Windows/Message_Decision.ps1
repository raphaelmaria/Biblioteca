$title    = 'Instalação Concluida'
$question = 'Apagar arquivos temporarios?'
$choices  = '&Sim', '&Não'

$decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
if ($decision -eq 0) {
    Write-Host 'confirmed'
    [System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms')
    [System.Windows.Forms.MessageBox]::Show('A instalação padrão da Flash foi concluida!','Arquivos Apagados')
} else {
    Write-Host 'cancelled'
    [System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms')
    [System.Windows.Forms.MessageBox]::Show('A instalação padrão da Flash foi concluida!','Arquivos mantidos')
}