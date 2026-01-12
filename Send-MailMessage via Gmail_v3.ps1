# v3
# Run once for password
# ConvertTo-SecureString "Password" -AsPlainText -Force | ConvertFrom-SecureString | Set-Content C:\Intel\pass.txt
# 
# Add to backup script
# powershell pathtoscript.ps1

$enddate = Get-Date
$startdate = (Get-Date).AddDays(-2)
$date = Get-ChildItem D:\Backup\Logs -Recurse -Filter *.txt | Where-Object { $_.CreationTime -ge $startdate -and $_.CreationTime -le $enddate }
$BackupLog = "D:\Backup\Logs\" + $date.Name

$string1 = "The backup operation successfully completed."
$string2 = "completed successfully"
$string3 = "Error"
$result = get-content $BackupLog | select-string -pattern $string1,$string2,$string3 | Select-Object -Last 5

$user ="user@subdomain.example.com.au"
$pass = Get-Content D:\Backup\pass.txt | ConvertTo-SecureString
$cred = New-Object System.Management.Automation.PSCredential $user, $pass

$Body = @"
Backup has finished at School.

$result

See attachment for backup log.


"@

$Param = @{
    To = "to@subdomain.example.com.au"
    From = "from@subdomain.example.com.au"
    Subject = "Backup"
    Body = $Body
    Attachment = $BackupLog
    SMTPServer = "smtp.gmail.com"
    Port = 587
    Credential = $cred
}
Send-MailMessage @Param -UseSsl