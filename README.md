# Optimize-Gaming

If you get error that you can't run powershell scripts run in an elevated powershell terminal:
`Set-ExecutionPolicy RemoteSigned -Scope CurrentUser`

To create a 'double-click script':

On desktop: New > Shortcut

In location of item put (Technical term 'Target'):

`C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -ExecutionPolicy Bypass -File "path\to\Optimize-Gaming\services.ps1"`