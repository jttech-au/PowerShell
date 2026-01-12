# Remove all VMs Network Adapter
# Get-VM | Remove-VMNetworkAdapter

# Find Adapters Name
# Get-NetAdapter

# Add new VMSwitch to Hyper-v and Add Network Adapter to all VMs
New-VMSwitch -Name "Ext" -NetAdapterName "LAN1" -AllowManagementOS $false
Get-VM | Add-VMNetworkAdapter -SwitchName "Ext"