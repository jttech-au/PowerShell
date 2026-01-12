# get-wmiobject Win32_Product # or better yet for easy reading
# get-wmiobject Win32_Product | Format-Table IdentifyingNumber, Name, LocalPackage

$computers = Get-Adcomputer -filter * -searchbase "OU=myou,DC=Curric,DC=Myschool,DC=WAN"

Foreach ($computer in $computers)
{

$QT7 = Get-WmiObject -Class Win32_Product -Filter "Name = 'Quicktime 7'" -Computer $computer
$QT7.uninstall()

}