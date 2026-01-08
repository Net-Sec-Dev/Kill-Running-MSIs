# Kill any running MSI installer processes (msiexec.exe) or .msi-based installers
# Simple, robust, no extra logic

Write-Output "Searching for running installer processes..."

# Get all processes that look like MSI or installer-related
$installerProcs = Get-CimInstance Win32_Process |
    Where-Object {
        $_.Name -match 'msiexec' -or
        ($_.CommandLine -match '\.msi\b' -or $_.CommandLine -match 'setup\.exe' -or $_.CommandLine -match 'installer')
    }

if ($installerProcs) {
    Write-Output "Found $($installerProcs.Count) installer process(es). Terminating..."
    foreach ($p in $installerProcs) {
        try {
            Stop-Process -Id $p.ProcessId -Force -ErrorAction Stop
            Write-Output "Killed PID $($p.ProcessId) - $($p.Name)"
        } catch {
            Write-Output "Failed to kill PID $($p.ProcessId): $($_.Exception.Message)"
        }
    }
} else {
    Write-Output "No installer processes found."
}

Write-Output "Done."
exit 0
