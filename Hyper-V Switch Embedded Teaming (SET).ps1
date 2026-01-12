New-VMSwitch -Name Curric -NetAdapterName "Integrated NIC 1 Port 1-1","Integrated NIC 1 Port 2-1" -EnableEmbeddedTeaming $true
Set-VMSwitch -Name Curric -AllowManagementOS $false
Get-VMSwitchTeam -Name Curric | FL

# default with Hyper-V HyperVPort 
Set-VMSwitchTeam -Name Ext -LoadBalancingAlgorithm Dynamic

Set-VMSwitch -Name Curric -NetAdapterName "QLogic 4x10GE QL41164HMRJ CNA (NDIS)","QLogic 4x10GE QL41164HMRJ CNA (NDIS) #2"

# Remove from TEAM
$VMSwitch = Get-VMSwitch -Name "TEAM0"
Remove-VMSwitchTeamMember -VMSwitch $VMSwitch --NetAdapterInterfaceDescription "QLogic 4x10GE QL41164HMRJ CNA (NDIS)", "QLogic 4x10GE QL41164HMRJ CNA (NDIS) #2"
Remove-VMSwitchTeamMember -VMSwitch $VMSwitch -NetAdapterName "PCIE-Port1", "PCIE-Port2"

# Add to TEAM
Set-VMSwitchTeam -name "CURRIC" -NetAdapterName "NIC03","NIC04"
Set-VMSwitchTeam -name "TEAM0" -NetAdapterName "NIC01","NIC02"

