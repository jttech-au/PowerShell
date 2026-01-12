# v2
# Run once for password
# ConvertTo-SecureString "Password" -AsPlainText -Force | ConvertFrom-SecureString | Set-Content C:\Intel\pass.txt
# 
# Add to backup script
# powershell pathtoscript.ps1


$user ="user@subdomain.example.com.au"
$pass = Get-Content C:\Intel\pass.txt | ConvertTo-SecureString
$cred = New-Object System.Management.Automation.PSCredential $user, $pass

$Date = Get-Date -format dd-MM-yyyy
$BackupLog = "D:\Backup\BackupLogs\$Date.txt"


$Body = @"
Backup has finished at SCHOOLNAME.

See attachment for backup log.
"@

$Param = @{
    To = "to@subdomain.example.com.au"
    From = "from@subdomain.example.com.au"
    Subject = "School Backup"
    Body = $Body
    Attachment = $BackupLog
    SMTPServer = "smtp.gmail.com"
    Port = 587
    Credential = $cred
}
Send-MailMessage @Param -UseSsl