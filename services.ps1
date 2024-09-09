# file containing excluded services
$excludeFile = "C:\Users\IT\Documents\Projects\IT\Stop-Services_Gaming-Optimization\exclude_services.txt"

# init empty hashtable for excluded services
$excludeServices = @{}

# read list of excluded services, trim whitespaces, convert to lowercase, and add them to the hashtable
Get-Content -Path $excludeFile | ForEach-Object { 
    $serviceName = $_.Trim().ToLower()
    if (-not [string]::IsNullOrWhiteSpace($serviceName)) {
        $excludeServices[$serviceName] = $true 
    }
}

# get all services currently running
$runningServices = Get-Service | Where-Object { $_.Status -eq 'Running' }

foreach ($service in $runningServices) {
    # convert service name to lowercase for comparison
    $serviceName = $service.Name.Trim().ToLower()

    # check if service in excluded services
    if (-not $excludeServices.ContainsKey($serviceName)) {
        try {
            Stop-Service -Name $service.Name -Force -ErrorAction Stop
            Write-Output "Stopped service: $($service.Name)"
        } catch {
            Write-Error "Could not stop service: $($service.Name) - $($_.Exception.Message)"
        }
    } else {
        Write-Warning "Excluded service: $($service.Name)"
    }
}

# Pause to keep the window open
Read-Host "Press Enter to continue..."
