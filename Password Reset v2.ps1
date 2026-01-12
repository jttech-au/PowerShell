<#
csvde -d "OU=Student,OU=Accounts,OU=Napoleons Primary School,DC=curric,DC=napoleons-ps,DC=wan" -f out.txt
#>

import-module ActiveDirectory

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ScriptFile = Join-Path $ScriptDir "\PasswordReset2019.txt"

import-csv $ScriptFile | foreach-object {

$UserName = $_.sAMAccountName.ToLower()
$Passwords = ConvertTo-SecureString -String "Som3@p@s$" -AsPlainText -Force
$BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($Passwords)            
$PlainPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)


Write-Host "Resetting" $UserName "password to:" $PlainPassword
Set-ADAccountPassword -Reset -NewPassword $Passwords -Identity $UserName

}