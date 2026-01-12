Import-Module ActiveDirectory
$OU = "OU=Inactive,OU=Name Primary School,DC=curric,DC=schoolname-ps,DC=wan"
$Users = Get-ADUser -Filter * -SearchBase $OU -Properties sAMAccountName

foreach ($User in $Users)
    {
    If ($User.Enabled -eq $false)
        {
        $HomeFolder = Get-ADUser -Identity $User -Properties HomeDirectory | Select-Object -ExpandProperty HomeDirectory
    
        If (Test-Path $HomeFolder) 
            {
            #Take ownership
            $acl = Get-Acl $HomeFolder
            $object = New-Object System.Security.Principal.Ntaccount("Administrators")
            $acl.SetOwner($object)
            $acl | Set-Acl $HomeFolder

            #Change Permissions
            $acl = Get-Acl $HomeFolder
            $acl.SetAccessRuleProtection($True, $False)
            $rule = New-Object System.Security.AccessControl.FileSystemAccessRule("Administrators","FullControl", "ContainerInherit, ObjectInherit", "None", "Allow")
            $acl.AddAccessRule($rule)
            $rule = New-Object System.Security.AccessControl.FileSystemAccessRule("MCPS\ast00148","FullControl", "ContainerInherit, ObjectInherit", "None", "Allow")
            $acl.AddAccessRule($rule)
            Set-Acl $HomeFolder $acl
        
            Remove-Item $HomeFolder -Recurse -Force
            #
            # Use robocopy to delete folders greater than 260 chars
            # create an empty folder c:\temp
            # robocopy deletes the files and folders under the target directory
            #
            # robocopy C:\Temp $HomeFolder /purge
            }
        Remove-ADUser $User -Confirm:$False
        }
    }

<# $ADUser = Get-ADUser -Filter * -SearchBase $OU -Properties sAMAccountName,HomeDirectory | Select sAMAccountName,HomeDirectory

$acl = Get-Acl $HomeFolder
$object = New-Object System.Security.Principal.Ntaccount("1436FS01\Administrators")
$acl.SetOwner($object)
$acl | Set-Acl $HomeFolder 


$acl = Get-Acl $HomeFolder
$acl.SetAccessRuleProtection($True, $False)
$rule = New-Object System.Security.AccessControl.FileSystemAccessRule("Administrators","FullControl", "ContainerInherit, ObjectInherit", "None", "Allow")
$acl.AddAccessRule($rule)
$rule = New-Object System.Security.AccessControl.FileSystemAccessRule("MPPS\ast00148","FullControl", "ContainerInherit, ObjectInherit", "None", "Allow")
$acl.AddAccessRule($rule)
Set-Acl $HomeFolder $acl

#>