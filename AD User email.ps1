Import-Module ActiveDirectory
$users = Get-ADUser -Filter * -SearchBase 'OU=Staff Accounts,OU=Accounts,OU=SchoolName,DC=subdomain,DC=example,DC=com,DC=au'
foreach ($user in $users)
{
    $email = $user.samaccountname + '@subdomain.example.com.au'
    Set-ADUser -Identity $user.samaccountname -EmailAddress $email
}