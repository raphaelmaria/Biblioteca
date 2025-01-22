$application = Get-WmiObject -Class Win32_Product -Filter "Name = '[Nome do Programa]'"
$application.Uninstall() 