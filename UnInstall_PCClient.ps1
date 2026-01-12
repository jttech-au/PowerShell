$uninstallerPath = "C:\Program Files (x86)\PaperCut MF Client\unins000.exe"

# Check if the uninstaller exists
if (Test-Path $uninstallerPath) {
    & $uninstallerPath /verysilent
}