$Passwords = ConvertTo-SecureString -String "S0me@Pas$" -AsPlainText –Force

$BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($Passwords)            
$PlainPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)            
Write-Host "Entered password is $PlainPassword"