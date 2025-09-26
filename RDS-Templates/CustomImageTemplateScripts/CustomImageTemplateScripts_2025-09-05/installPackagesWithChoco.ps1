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

                Start-Process choco -ArgumentList "install $Package" -PassThru -Wait

                Write-host "AVD Customization: Install Chocolatey - Finished installation of Chocolatey"

                if (choco list --lo -r -e $Package) {
                    Write-Host "AVD Customization: Install Packages with Chocolatey - $Package is installed."

                } else {
                    Write-Host "AVD Customization: Install Packages with Chocolatey - $Package is not installed."
                }
            }
            catch {
                Write-Host "*** AVD CUSTOMIZER PHASE ***  Install Packages with Chocolatey  - Exception occured installing $Package  *** : [$($_.Exception.Message)]"
            }
        }
    }

    END {

        #Cleanup
        if ((Test-Path -Path $templateFilePathFolder -ErrorAction SilentlyContinue)) {
            Remove-Item -Path $templateFilePathFolder -Force -Recurse -ErrorAction Continue
        }

        if ((Test-Path -Path $tempFolder -ErrorAction SilentlyContinue)) {
            Remove-Item -Path $tempFolder -Force -Recurse -ErrorAction Continue
        }

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