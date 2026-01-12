$SDP = "D:\SDP"
New-SmbShare -Name "SDP$" -Path $SDP -FullAccess Everyone
TAKEOWN /F $SDP /A /R /D Y
icacls $SDP /inheritance:r
icacls $SDP /grant:r '"Administrators":(OI)(CI)(F)'
icacls $SDP /grant:r '"SYSTEM":(OI)(CI)(F)'
icacls $SDP /grant:r '"Domain Users":(OI)(CI)(RX)'
icacls $SDP /grant:r '"Domain Computers":(OI)(CI)(RX)'
icacls "$SDP\*" /RESET /T 

$StaffPublic = "D:\Public Folders\Staff Public"
New-SmbShare -Name "Staff Public$" -Path $StaffPublic -FullAccess Everyone
TAKEOWN /F $StaffPublic /A /R /D Y
icacls $StaffPublic /inheritance:r
icacls $StaffPublic /remove "Domain Admins"
icacls $StaffPublic /grant:r '"Administrators":(OI)(CI)(F)'
icacls $StaffPublic /grant:r '"SYSTEM":(OI)(CI)(F)'
icacls $StaffPublic /grant:r '"grp_staff":(OI)(CI)(M)'
icacls "$StaffPublic\*" /RESET /T 

$Shares = "D:\Public Folders\Shares"
New-SmbShare -Name "Shares$" -Path $Shares -FullAccess Everyone
TAKEOWN /F $Shares /A /R /D Y
icacls $Shares /inheritance:r
icacls $Shares /remove "Domain Admins"
icacls $Shares /grant:r '"Administrators":(OI)(CI)(F)'
icacls $Shares /grant:r '"SYSTEM":(OI)(CI)(F)'
icacls $Shares /grant:r '"grp_staff":(OI)(CI)(M)'
icacls "$Shares\*" /RESET /T

$StudentPublic = "D:\Public Folders\Student Public"
New-SmbShare -Name "Student Public$" -Path $StudentPublic -FullAccess Everyone
TAKEOWN /F $StudentPublic /A /R /D Y
icacls $StudentPublic /inheritance:r
icacls $StudentPublic /remove "Domain Admins"
icacls $StudentPublic /grant:r '"Administrators":(OI)(CI)(F)'
icacls $StudentPublic /grant:r '"SYSTEM":(OI)(CI)(F)'
icacls $StudentPublic /grant:r '"grp_staff":(OI)(CI)(M)'
icacls $StudentPublic /grant:r '"grp_students":(OI)(CI)(RX)'
icacls "$StudentPublic\*" /RESET /T

$Apps = "D:\Apps"
New-SmbShare -Name "Apps$" -Path $Apps -FullAccess Everyone
TAKEOWN /F $Apps /A /R /D Y
icacls $Apps /inheritance:r
icacls $Apps /remove "Domain Admins"
icacls $Apps /grant:r '"Administrators":(OI)(CI)(F)'
icacls $Apps /grant:r '"SYSTEM":(OI)(CI)(F)'
icacls $Apps /grant:r '"grp_staff":(OI)(CI)(M)'
icacls $Apps /grant:r '"grp_students":(OI)(CI)(RX)'
icacls "$Apps\*" /RESET /T 