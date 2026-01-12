# Import the Active Directory module
Import-Module ActiveDirectory

<#
Example CSV File

username,photoPath
jdoe,C:\photos\jdoe.jpg
asmith,C:\photos\asmith.jpg
#>

# Path to your CSV file
$csvPath = "C:\path\to\photos.csv"

# Read the CSV file
$users = Import-Csv -Path $csvPath

# Loop through each user in the CSV file
foreach ($user in $users) {
    try {
        # Convert the photo to a byte array
        $photo = [byte[]](Get-Content -Path $user.photoPath -Encoding byte)
        
        # Update the user's thumbnailPhoto attribute
        Set-ADUser -Identity $user.username -Replace @{thumbnailPhoto=$photo}
        
        Write-Host "Updated photo for user: $($user.username)" -ForegroundColor Green
    } catch {
        Write-Host "Failed to update photo for user: $($user.username)" -ForegroundColor Red
        Write-Host $_.Exception.Message
    }
}

Write-Host "Photo import process completed."
