$wsus = get-WsusServer
[reflection.assembly]::LoadWithPartialName("Microsoft.UpdateServices.Administration") | Out-Null
# List all updates
# $wsus.getupdates()

# List Windows Server 2008 updates
#$patches = $wsus.SearchUpdates(‘Security Update for Windows Server 2008’) # Update for Windows Server 2008, Windows Server 2008 Service Pack 2 Standalone
#$patches.count
#$patches | Select Title

#Decline updates
$update = $wsus.SearchUpdates('Security Update for Windows Server 2008')
$update[0].Decline()