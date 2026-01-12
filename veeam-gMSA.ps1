# gMSA must also have Logon as a service
# gMSABackupDCs
$gMSAName = 'veeam-gMSA'
$gMSAGroupName = 'gMSABackupDCs'
$gMSADNSHostName = 'veeam-gMSA.subdomain.example.com.au'
New-ADServiceAccount -Name $gMSAName -DNSHostName $gMSADNSHostName -PrincipalsAllowedToRetrieveManagedPassword $gMSAGroupName -Enabled $True