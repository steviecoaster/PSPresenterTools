Function New-TalkTimer {
    [cmdletBinding()]
    Param(
        [Parameter(Mandatory,Position = 0)]
        [int[]]
        $WarningTimes

    )

    Begin {
        $RootPath = Split-Path $PSScriptRoot -Parent
        Write-Output "Importing $(`"$Rootpath\Private\Pop-Notification.ps1`")"
        . $RootPath\Private\Pop-Notification.ps1
    }

    Process {

        $Countdown = $WarningTimes | Sort-Object -Descending
        $finalTime = $Countdown[-1]
        Write-Verbose "Creating StopWatch..."

        $StopWatch = [System.Diagnostics.Stopwatch]::new()

        Write-Verbose "Starting Watch"
        $StopWatch.Start()
        Foreach($Count in $Countdown) {

            Do {

                $null
            }

            Until ($StopWatch.Elapsed.TotalMinutes -ge $Count)

            Switch ($Count) {
                
                '1' { 
                    Write-Verbose "Popping final warning"
                    $text = "$Count minute left" }
                Default { 
                    Write-Verbose "Popping toast..."
                    $text = "$Count minutes left" }
            
            }

            Pop-Notification
        
        }

        Start-Sleep -Seconds ($finalTime * 60)
        Write-Verbose "Popping time's up message"
        $text = "That's time!"
        Pop-Notification
        $StopWatch.Stop()


    }

}