Import-Module ActiveDirectory
$users = Get-ADUser -Filter * -SearchBase 'OU=Staff Accounts,OU=Accounts,OU=St Aloysius Parish School,DC=internal,DC=saredan,DC=catholic,DC=edu,DC=au'
foreach ($user in $users)
{
    $email = $user.samaccountname + '@saredan.catholic.edu.au'
    Set-ADUser -Identity $user.samaccountname -EmailAddress $email
}