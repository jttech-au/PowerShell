Export-DhcpServer -ComputerName 1436DC01.curric.mount-pleasant-ps.wan -Leases -File "C:\Users\$env:USERNAME\Desktop\dhcpexp.xml" -verbose

Import-DhcpServer -ComputerName 0427DC01.curric.mount-clear-ps.wan -Leases -File "C:\Users\$env:USERNAME\Desktop\dhcpexp.xml" -BackupPath "C:\Users\$env:USERNAME\Desktop\backup\" -Verbose