Import-Module ActiveDirectory
$users = Get-ADUser -Filter * -SearchBase 'OU=Staff Accounts,OU=Accounts,OU=SchoolName,DC=internal,DC=DomainName,DC=edu,DC=au'
foreach ($user in $users)
{
    $email = $user.samaccountname + '@internal.DomainName.edu.au'
    Set-ADUser -Identity $user.samaccountname -EmailAddress $email
}