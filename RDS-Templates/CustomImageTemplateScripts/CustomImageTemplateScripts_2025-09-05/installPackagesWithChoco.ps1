<#Author       : Joseph Karns
# Usage        : Install Packages with Chocolatey
#>


#####################################################
#    Install Packages with Chocolatey               #
#####################################################

[CmdletBinding()]
  Param (
        [Parameter(Mandatory)]
        [System.String[]]$PackageList
)

function InstallPackagesWithChoco($packageArray) {

    BEGIN {
        $stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
        Write-host "Starting AVD Customization: Install Packages with Chocolatey : $((Get-Date).ToUniversalTime()) "
    }

    PROCESS {
        foreach ($Package in $PackageList) {
            try {
                Write-host "AVD Customization: Install Packages with Chocolatey - Installing $Package"
                $maxAttempts = 5
                $attempt = 0
                $success = $false

                while (-not $success -and $attempt -lt $maxAttempts) {
                    $attempt++
                    Write-Host "Attempting to Install $Package with Chocolatey (Attempt $attempt of $maxAttempts)..."

                    try {
                        Start-Process choco -ArgumentList "install $Package --ignoredetectedreboot --yes --use-package-exit-codes --ignore-checksums --install-args '/allusers'" -PassThru -Wait
                        if (choco list --lo -r -e $Package) {
                            Write-Host "AVD Customization: Install Packages with Chocolatey - $Package is installed."
                            $success = $true
                        } else {
                            throw
                        }
                    }
                    catch {
                        Write-Host "Error: $($_.Exception.Message)"
                        if ($attempt -lt $maxAttempts) {
                            Write-Host "AVD Customization: Install Packages with Chocolatey - $Package is not installed."
                            Write-Host "Retrying in 10 seconds..."
                            Start-Sleep -Seconds 10
                        } else {
                            Write-Host "AVD Customization: Install Packages with Chocolatey - $Package is not installed."
                            Write-Host "Maximum attempts reached. Operation failed."
                        }
                    }
                }
            }
            catch {
                Write-Host "*** AVD CUSTOMIZER PHASE ***  Install Packages with Chocolatey  - Exception occured installing $Package  *** : [$($_.Exception.Message)]"
            }
        }
    }

    END {

        #Cleanup
        $stopwatch.Stop()
        $elapsedTime = $stopwatch.Elapsed
        Write-Host "*** AVD CUSTOMIZER PHASE : Install Packages with Chocolatey -  Exit Code: $LASTEXITCODE ***"    
        Write-Host "Ending AVD Customization : Install Packages with Chocolatey - Time taken: $elapsedTime"
    }

}

InstallPackagesWithChoco -PackageList $PackageList

#############
#    END    #
#############