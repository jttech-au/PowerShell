# gMSA must also have Logon as a service
# gMSABackupDCs
$gMSAName = 'veeam-gMSA'
$gMSAGroupName = 'gMSABackupDCs'
$gMSADNSHostName = 'veeam-gMSA.curric.school-co.wan'
New-ADServiceAccount -Name $gMSAName -DNSHostName $gMSADNSHostName -PrincipalsAllowedToRetrieveManagedPassword $gMSAGroupName -Enabled $True