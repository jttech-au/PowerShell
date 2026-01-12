$DeploymentShareNTFS = "D:\MDTProduction"
icacls $DeploymentShareNTFS /grant '"Users":(OI)(CI)(RX)'
icacls $DeploymentShareNTFS /grant '"Administrators":(OI)(CI)(F)'
icacls $DeploymentShareNTFS /grant '"SYSTEM":(OI)(CI)(F)'
icacls "$DeploymentShareNTFS\Captures" /grant '"DOMAIN\MDT_BA":(OI)(CI)(M)'

$DeploymentShare = "MDTProduction$"
Grant-SmbShareAccess -Name $DeploymentShare -AccountName "EVERYONE" -AccessRight Change -Force
Revoke-SmbShareAccess -Name $DeploymentShare -AccountName "CREATOR OWNER" -Force
Revoke-SmbShareAccess -Name $DeploymentShare -AccountName "Administrators" -Force