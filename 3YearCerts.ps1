import-module activedirectory
$3Years = (get-date).adddays(-1095)
Get-ADComputer -filter {whenCreated -le $3Years} Properties whenCreated -SearchBase "ou=Wireless Certificates,ou=Mount Pleasant Primary School - 1436,ou=South-Western Victoria Region,ou=Schools,DC=services,DC=education,dc=vic,DC=gov,dc=au" | Format-List -Property name, whenCreated

<#
import-module activedirectory
Get-ADComputer "ComputerName" -Properties *
#>