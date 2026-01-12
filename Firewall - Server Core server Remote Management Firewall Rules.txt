Uninstall-WindowsFeature FS-SMB1


Enable-NetFirewallRule -DisplayGroup "Remote Event Log Management"
Enable-NetFirewallRule -DisplayGroup "Remote Service Management"
Enable-NetFirewallRule -DisplayGroup "File and Printer Sharing"
Enable-NetFirewallRule -DisplayGroup "Performance Logs and Alerts"
# Enable on Server and Client for Remote Volume Management
Enable-NetFirewallRule -DisplayGroup "Remote Volume Management"
Enable-NetFirewallRule -DisplayGroup "Windows Firewall Remote Management"
# Windows Server 1709
Enable-NetFirewallRule -DisplayGroup "Windows Defender Firewall Remote Management"
