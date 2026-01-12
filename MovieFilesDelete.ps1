# Import the CSV and delete files
Import-Csv "D:\movie_files_over_500mb.csv" | ForEach-Object {
    if (Test-Path $_.FullName) {
        Remove-Item $_.FullName -Force -ErrorAction SilentlyContinue
    }
}
