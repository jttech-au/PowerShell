<# LogSystemInfo.ps1
v1.0
Log user accounts to allocated computers.
#>

$LogFile = "\\Server\Share\Logs\LogSystemInfo.txt"
$Username = $env:USERNAME
$ComputerName = $env:COMPUTERNAME
$ComputerModel = Get-WmiObject Win32_ComputerSystem | Select-Object -ExpandProperty Model

$LogEntry = "$Username, $ComputerName, $ComputerModel"

# Function to check if entry exists in the log file
function CheckLogEntry {
    param([string]$logEntry)
    if (Test-Path $LogFile) {
        Get-Content $LogFile | ForEach-Object {
            if ($_ -eq $logEntry) {
                return $true
            }
        }
    }
    return $false
}

# Function to append entry to the log file with locking
function AppendToLogFile {
    param([string]$entry)
    $lockFile = "$LogFile.lock"
    $lock = New-Object System.Threading.Mutex($false, $lockFile)
    
    $lock.WaitOne()
    try {
        $entry | Out-File -Append $LogFile
    } finally {
        $lock.ReleaseMutex()
    }
}

# Check if the entry already exists in the log file
if (CheckLogEntry $LogEntry) {
    Write-Host "Entry already exists in the log file."
} else {
    # Append the new entry to the log file
    AppendToLogFile $LogEntry
    Write-Host "Entry added to the log file."
}