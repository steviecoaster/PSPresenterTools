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
        $StopWatch = [System.Diagnostics.Stopwatch]::new()

        Foreach($Count in $Countdown) {

            Do {

                $null
            }

            Until ($StopWatch.Elapsed.TotalMinutes -ge $Count)

            Switch ($Count) {
                
                '1' { $text = "$Count minute left" }
                Default { $text = "$Count minutes left" }
            
            }

            Pop-Notification
        
        }

        Start-Sleep -Seconds ($finalTime * 60)
        $text = "That's time!"

    }

}