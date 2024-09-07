# file containing services to exclude
$excludeFile = "C:\Users\IT\Documents\Projects\IT\Stop-Services_Gaming-Optimization\exclude_services.txt"

# read the list of excluded services, trim whitespaces and convert to lowercase
$excludeServices = Get-Content -Path $excludeFile | ForEach-Object { $_.Trim().ToLower() }

# get all services that are currently running
$runningServices = Get-Service | Where-Object { $_.Status -eq 'Running' }

foreach ($service in $runningServices) {
    # convert the service name to lowercase for comparison
    $serviceName = $service.Name.ToLower()

    # check if the service is in the exclusion list
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

# pause to keep the window open
Read-Host "Press Enter to continue..."
