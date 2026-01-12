# Remove a single ip adddress
Remove-NetIPAddress -InterfaceIndex 3 -IPAddress 10.131.8.16

# Removes all of the IP addresses that have a manually-configured prefix origin.
Remove-NetIPAddress -PrefixOrigin Manual

# Remove default gateway
Remove-NetRoute -InterfaceIndex 3 -NextHop "192.168.0.3"