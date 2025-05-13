$logStatus = 0  # Set to 0 to DISABLE LOGGING

$logFile = Join-Path -Path $PSScriptRoot -ChildPath "monitor_status.log"
$shortcutOff = Join-Path -Path $PSScriptRoot -ChildPath "OpenRGB OFF.lnk"
$shortcutOn = Join-Path -Path $PSScriptRoot -ChildPath "OpenRGB ON.lnk"

if ($logStatus -eq 1) {
	"--- Monitor WMI Logger Started at $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') ---" | Out-File -FilePath $logFile -Append
}

$previousState = $null  # null, "on", or "off"

while ($true) {
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $currentState = $null

    try {
        $monitors = Get-CimInstance -Namespace root\wmi -ClassName WmiMonitorID -ErrorAction Stop
        if ($monitors.Count -eq 0) {
            if ($logStatus -eq 1) {
                "$timestamp - No WMI monitors detected." | Out-File -FilePath $logFile -Append
            }
            $currentState = "off"
        } else {
            foreach ($monitor in $monitors) {
                $manufacturer = ([System.Text.Encoding]::ASCII.GetString($monitor.ManufacturerName)).Trim([char]0)
                $product = ([System.Text.Encoding]::ASCII.GetString($monitor.ProductCodeID)).Trim([char]0)
                $serial = ([System.Text.Encoding]::ASCII.GetString($monitor.SerialNumberID)).Trim([char]0)
				if ($logStatus -eq 1) {
					"$timestamp - Monitor: $manufacturer $product - Serial: $serial" | Out-File -FilePath $logFile -Append
				}
            }
            $currentState = "on"
        }
    }
    catch {
		if ($logStatus -eq 1) {
			"$timestamp - WMI query failed: $_" | Out-File -FilePath $logFile -Append
		}
        $currentState = "off"
    }

    # Handle state change triggers
    if ($currentState -ne $previousState) {
        if ($currentState -eq "off" -and (Test-Path $shortcutOff)) {
            Start-Process -FilePath $shortcutOff
			if ($logStatus -eq 1) {
				"$timestamp - Launched: OpenRGB OFF.lnk" | Out-File -FilePath $logFile -Append
			}
        } elseif ($currentState -eq "on" -and (Test-Path $shortcutOn)) {
            Start-Process -FilePath $shortcutOn
			if ($logStatus -eq 1) {
				"$timestamp - Launched: OpenRGB ON.lnk" | Out-File -FilePath $logFile -Append
			}
        }
        $previousState = $currentState
    }

    Start-Sleep -Seconds 5
}
