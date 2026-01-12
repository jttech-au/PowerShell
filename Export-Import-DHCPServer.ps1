Export-DhcpServer -ComputerName DC01.subdomain.example.com.au -Leases -File "C:\Users\$env:USERNAME\Desktop\dhcpexp.xml" -verbose
Import-DhcpServer -ComputerName DC01.subdomain.example.com.au -Leases -File "C:\Users\$env:USERNAME\Desktop\dhcpexp.xml" -BackupPath "C:\Users\$env:USERNAME\Desktop\backup\" -Verbose
