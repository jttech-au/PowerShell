$sourcePath = "\\172.16.100.15\Media\Movies"

# Get all files in the directory
Get-ChildItem -Path $sourcePath -File | ForEach-Object {
    $fileName = $_.BaseName  # File name without extension
    $folderPath = Join-Path -Path $sourcePath -ChildPath $fileName

    # Create the folder if it doesn't exist
    if (-not (Test-Path -Path $folderPath)) {
        New-Item -Path $folderPath -ItemType Directory | Out-Null
    }

    # Move the file into its corresponding folder
    Move-Item -Path $_.FullName -Destination $folderPath
}
