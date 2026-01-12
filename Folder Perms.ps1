<#
$SDP = "D:\SDP"
New-SmbShare –Name "SDP$" –Path $SDP -FullAccess Everyone
TAKEOWN /F $SDP /A /R /D Y
icacls $SDP /inheritance:r
icacls $SDP /grant:r '"Administrators":(OI)(CI)(F)'
icacls $SDP /grant:r '"SYSTEM":(OI)(CI)(F)'
icacls $SDP /grant:r '"Domain Users":(OI)(CI)(RX)'
icacls $SDP /grant:r '"Domain Computers":(OI)(CI)(RX)'
icacls "$SDP\*" /RESET /T
#>

$StaffPublic = "D:\Staff Public"
New-SmbShare –Name "Staff Public$" –Path $StaffPublic -FullAccess Everyone
TAKEOWN /F $StaffPublic /A /R /D Y
icacls $StaffPublic /inheritance:r
icacls $StaffPublic /remove "Domain Admins"
icacls $StaffPublic /remove "LS-Network Administration"
icacls $StaffPublic /grant:r '"Administrators":(OI)(CI)(F)'
icacls $StaffPublic /grant:r '"SYSTEM":(OI)(CI)(F)'
icacls $StaffPublic /grant:r '"LS-Staff":(OI)(CI)(M)'
icacls "$StaffPublic\*" /RESET /T 

$StaffUsers = "D:\Staff Users"
New-SmbShare –Name "Staff Users$" –Path $StaffUsers -FullAccess Everyone
TAKEOWN /F $StaffUsers /A /R /D Y
icacls $StaffUsers /inheritance:r
icacls $StaffUsers /remove "Domain Admins"
icacls $StaffUsers /grant:r '"Administrators":(OI)(CI)(F)'
icacls $StaffUsers /grant:r '"NT AUTHORITY\SYSTEM":(OI)(CI)(F)'
icacls $StaffUsers /grant:r '"CREATOR OWNER":(OI)(CI)(IO)(F)'
icacls $StaffUsers /grant:r '"LS-Staff":(RX,WD,AD)'

$StudentPublic = "D:\Student Public"
New-SmbShare –Name "Student Public$" –Path $StudentPublic -FullAccess Everyone
TAKEOWN /F $StudentPublic /A /R /D Y
icacls $StudentPublic /inheritance:r
icacls $StudentPublic /remove "Domain Admins"
icacls $StudentPublic /remove "LS-Network Administration"
icacls $StudentPublic /grant:r '"Administrators":(OI)(CI)(F)'
icacls $StudentPublic /grant:r '"SYSTEM":(OI)(CI)(F)'
icacls $StudentPublic /grant:r '"LS-Staff":(OI)(CI)(M)'
icacls "$StudentPublic\*" /RESET /T 

$StudentUsers = "D:\Student Users"
New-SmbShare –Name "Student Users$" –Path $StudentUsers -FullAccess Everyone
TAKEOWN /F $StudentUsers /A /R /D Y
icacls $StudentUsers /inheritance:r
icacls $StudentUsers /remove "Domain Admins"
icacls $StudentUsers /grant:r '"Administrators":(OI)(CI)(F)'
icacls $StudentUsers /grant:r '"NT AUTHORITY\SYSTEM":(OI)(CI)(F)'
icacls $StudentUsers /grant:r '"CREATOR OWNER":(OI)(CI)(IO)(F)'
icacls $StudentUsers /grant:r '"LS-Staff":(OI)(CI)(M)'
icacls $StudentUsers /grant:r '"LS-Student":(RX,WD,AD)'

$NetAdmin = "D:\NetAdmin"
New-SmbShare –Name "NetAdmin$" –Path $NetAdmin -FullAccess Everyone
TAKEOWN /F $NetAdmin /A /R /D Y
icacls $NetAdmin /inheritance:r
icacls $NetAdmin /remove "Domain Admins"
icacls $NetAdmin /grant:r '"Administrators":(OI)(CI)(F)'
icacls $NetAdmin /grant:r '"NT AUTHORITY\SYSTEM":(OI)(CI)(F)'
icacls $NetAdmin /grant:r '"LS-NetAdmin":(OI)(CI)(IO)(F)'


$HomeFolders = Get-ChildItem "D:\Staff Users" -Directory
foreach ($HomeFolder in $HomeFolders) {
    $Path = $HomeFolder.FullName
    icacls $Path /remove "Administrators"
    icacls $Path /remove "ast00148"
    $Acl = (Get-Item $Path).GetAccessControl('Access')
    $Username = $HomeFolder.Name
    $Ar = New-Object System.Security.AccessControl.FileSystemAccessRule($Username,'FullControl','ContainerInherit,ObjectInherit','None','Allow')
    $Acl.SetAccessRule($Ar)
    Set-Acl -path $Path -AclObject $Acl
}







<# 
$DeploymentShare = "MDTProduction$"
Grant-SmbShareAccess -Name $DeploymentShare -AccountName "EVERYONE" -AccessRight Change -Force
Revoke-SmbShareAccess -Name $DeploymentShare -AccountName "CREATOR OWNER" -Force
Revoke-SmbShareAccess -Name $DeploymentShare -AccountName "Administrators" -Force

#>