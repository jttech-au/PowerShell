# Firewall Rule
Set-NetFirewallRule -DisplayGroup 'Remote Volume Management' -Enabled True -PassThru
# Start Service
Set-Service -Name vds -StartupType Automatic
Start-Service -Name vds