# Search current directory and subfolders for movie files > 500 MB
Get-ChildItem -Path "R:\2025 FS01 Migration" -Recurse -Include *.mp4, *.mkv, *.avi, *.mov, *.wmv, *.flv, *.mpg, *.mpeg |
    Where-Object { -not $_.PSIsContainer -and $_.Length -gt 500MB } |
    Select-Object FullName, @{Name="SizeMB";Expression={[math]::Round($_.Length / 1MB, 2)}}|
    Export-Csv -Path "D:\movie_files_over_500mb.csv" -NoTypeInformation -Encoding UTF8