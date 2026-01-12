# $a = Get-Item -Path C:\backup\Oliver_Backup_04-06-2014.zip
# $a.LastWriteTime = (Get-Date).AddDays(-366)

# Aliases for ForEach-Object
# Get-ChildItem -Path C:\backup | ForEach-Object
# Get-ChildItem -Path C:\backup | ForEach
# Get-ChildItem -Path C:\backup | %

# Get-ChildItem -Path C:\backup | %{$_.CreationTime= '01/25/2013 00:00'}
# Get-ChildItem -Path C:\backup | %{$_.LastWriteTime = '01/20/2013 00:00'}
# Get-ChildItem -Path C:\backup | %{$_.LastWriteTime = (Get-Date).AddDays(-365)} 
# Get-ChildItem -Path C:\backup | %{$_.CreationTime= (Get-Date).AddDays(-365)}

# Script block
Get-ChildItem -Path C:\backup | %{$_.LastWriteTime = (Get-Date).AddDays(-(365.242*5))} 
Get-ChildItem -Path C:\backup | %{$_.CreationTime = (Get-Date).AddDays(-(365.242*5))}
Get-ChildItem -Path C:\backup | %{$_.LastAccessTime = (Get-Date).AddDays(-(365.242*5))}

#Operation statement
Get-ChildItem -Path C:\backup | % LastWriteTime = (Get-Date).AddDays(-(365.242*5))
Get-ChildItem -Path C:\backup | % CreationTime = (Get-Date).AddDays(-(365.242*5))
Get-ChildItem -Path C:\backup | % LastAccessTime = (Get-Date).AddDays(-(365.242*5))