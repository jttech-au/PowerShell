Import-Module ActiveDirectory

<#
Get-ADComputer "CLIENT1" -Properties *

Get-ADComputer -Filter '*' | Select -Expand Name

Get-ADComputer -Filter 'ObjectClass -eq "Computer"' | Select -Expand DNSHostName
Get-ADComputer -Filter 'ObjectClass -eq "Computer"' | Select -Expand DistinguishedName

Get-ADComputer -Filter { OperatingSystem -Like '*Windows Server*' } -Properties OperatingSystem | Select Name, OperatingSystem | Format-Table -AutoSize
Get-ADComputer -Filter { OperatingSystem -NotLike '*Windows Server*' } -Properties OperatingSystem | Select Name, OperatingSystem | Format-Table -AutoSize

Get-ADComputer -SearchBase 'OU=Clients,OU=Hjemme,dc=svendsen,dc=local' -Filter '*' | Select -Exp Name
Get-ADComputer -SearchBase "OU=IT,DC=Contoso,DC=Com" -filter '*'
#>

$Computers = Get-ADComputer -Filter '*'

ForEach($Computer in $Computers)
    {
    $Computer
    }

##############################################################################################
$OU = "OU=Computers,OU=Primary School,DC=curric,DC=school-ps,DC=wan"

$Computers = (Get-ADComputer -Filter { Name -notlike 'DT*' } -SearchBase $OU ).Name
# $Computers = Get-ADComputer -Filter '*' -SearchBase "OU=1 to 1 Computers,OU=Computers,OU=Mount Clear Primary School,DC=curric,DC=mount-clear-ps,DC=wan"

$Computers | Out-File -FilePath C:\Drivers\test.txt -Append

##############################################################################################

Import-Module ActiveDirectory

$Computers = Get-ADComputer -Filter '*' -Properties OperatingSystem

ForEach($Computer in $Computers)
    {
    if ($Computer.OperatingSystem -like "Windows 7*")
        {
        Write-Host $Computer.Name $Computer.OperatingSystem -ForegroundColor blue
        }
        elseif ($Computer.OperatingSystem -like "Windows 8*")
        {
        Write-Host $Computer $Computer.OperatingSystem -ForegroundColor green
        }
        elseif ($Computer.OperatingSystem -like "Windows Server*")
        {
        Write-Host $Computer.DNSHostName $Computer.OperatingSystem -ForegroundColor red
        }
    }

##############################################################################################
$OU = 'OU=Portable,OU=Computers Managed,OU=LAL LAL PRIMARY SCHOOL,DC=curric,DC=lal-lal-ps,DC=wan'

Get-ADComputer -Filter { OperatingSystem -Like '*Windows 7*' } -SearchBase $OU  -Properties OperatingSystem | Select-Object Name, distinguishedname,DNSHostName, OperatingSystem | Format-Table -AutoSize
# Get-ADComputer -Filter { OperatingSystem -Like '*Windows 7*' } -SearchBase $OU  -Properties OperatingSystem | Stop-Computer

##############################################################################################