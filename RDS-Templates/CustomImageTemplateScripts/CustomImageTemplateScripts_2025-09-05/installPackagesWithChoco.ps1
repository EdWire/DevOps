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
                Start-Process choco -ArgumentList "install $Package --ignoredetectedreboot --yes --use-package-exit-codes --ignore-checksums --debug --verbose --install-args '/allusers'" -ErrorAction Stop -Wait
            }
            catch {
                Write-Host "*** AVD CUSTOMIZER PHASE : Install Packages with Chocolatey  - Exception occured installing $Package  *** : [$($_.Exception.Message)]"
            }
            finally {
                Start-Process choco list --lo -r -e $Package -Wait -PassThru
                Write-Host "AVD Customization: Install Packages with Chocolatey - $Package is installed."
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