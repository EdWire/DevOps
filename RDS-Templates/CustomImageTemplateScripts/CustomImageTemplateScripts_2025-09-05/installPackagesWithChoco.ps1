 <#Author       : Joseph Karns
# Usage        : Install Packages with Chocolatey
#>


#####################################################
#    Install Packages with Chocolatey               #
#####################################################

[CmdletBinding()]
  Param (
        [Parameter(Mandatory)]
        [string]$packageArray
)

function InstallPackagesWithChoco($packageArray) {

    Begin {
        $stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
        Write-host "Starting AVD Customization: Install Packages with Chocolatey : $((Get-Date).ToUniversalTime()) "
    }

    Process {
        foreach ($item in $MyStringArray) {
            try {
                Write-host "AVD Customization: Install Packages with Chocolatey - Installing $item"

                Start-Process choco -ArgumentList "install $item" -PassThru -Wait

                Write-host "AVD Customization: Install Chocolatey - Finished installation of Chocolatey"
                $provisionedPackages = Get-AppxProvisionedPackage -Online
                $isPackageInstalled = $provisionedPackages | Where-Object { $_.PackageName -like '*$item*' }

                if ($isPackageInstalled) {
                    Write-Host "AVD Customization: Install Packages with Chocolatey - Get-AppxProvisionedPackage returned $item."
                } else {
                    Write-Host "AVD Customization: Install Packages with Chocolatey - Get-AppxProvisionedPackage did not return $item."
                }
            }
            catch {
                Write-Host "*** AVD CUSTOMIZER PHASE ***  Install Packages with Chocolatey  - Exception occured installing $item  *** : [$($_.Exception.Message)]"
            }
        }
    }


    End {

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

InstallPackagesWithChoco -packageArray $packageArray