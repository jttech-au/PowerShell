$newPassword = ConvertTo-SecureString -String "Term4@mpps" -AsPlainText -Force
# $newPassword = (Read-Host -Prompt "Enter password for all users:" -AsSecureString)
Get-Content C:\Users\ast00148\Desktop\PowerShell\students.txt | Set-ADAccountPassword -NewPassword $newPassword -Reset