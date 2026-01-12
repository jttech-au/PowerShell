# Block Internet access for the REF001 VM add GW IP
Add-VMNetworkAdapterAcl -VMName REF001 -RemoteIPAddress 192.168.1.1 -Direction Both -Action Deny

# If you want to review existing rules, use this script:
# Get rules for the REF001 VM
Get-VMNetworkAdapterAcl -VMName REF001