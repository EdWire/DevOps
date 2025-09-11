 <#Author       : Joseph Karns
# Usage        : Install Chocolatey
#>


#######################################
#    Install Chocolatey               #
#######################################

[CmdletBinding()]
  Param (
        [Parameter(Mandatory)]
        [string]$ChocoDownloadLink
)

function InstallChocolateyforAVD($ChocoDownloadLink) {

    Begin {
        $stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
        $templateFilePathFolder = "C:\AVDImage"
        Write-host "Starting AVD Customization: Install Chocolatey : $((Get-Date).ToUniversalTime()) "

        $guid = [guid]::NewGuid().Guid
        $tempFolder = (Join-Path -Path "C:\temp\" -ChildPath $guid)

        if (!(Test-Path -Path $tempFolder)) {
            New-Item -Path $tempFolder -ItemType Directory
        }

        Write-Host "AVD Customization: Install Chocolatey: Created temp folder $tempFolder"
    }

    Process {
        try {
            Write-host "AVD Customization: Install Chocolatey - Requested to Chocolatey"

            $appName = 'chocolatey'
            New-Item -Path $tempFolder -Name $appName  -ItemType Directory -ErrorAction SilentlyContinue
            $LocalPath = $tempFolder + '\' + $appName
            $ChocoPS = 'chocoInstall.ps1'
            $outputPath = $LocalPath + '\' + $ChocoPS

            Invoke-WebRequest -Uri $ChocoDownloadLink -OutFile $outputPath

            Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
            Invoke-Expression $outputPath

            Write-host "AVD Customization: Install Chocolatey - Finished installation of Chocolatey"
            $provisionedPackages = Get-AppxProvisionedPackage -Online
            $isChocoInstalled = $provisionedPackages | Where-Object { $_.PackageName -like '*Choco*' }

            if ($isChocoInstalled) {
                Write-Host "AVD Customization: Install Chocolatey - Get-AppxProvisionedPackage returned Chocolatey."
            } else {
                Write-Host "AVD Customization: Install Chocolatey - Get-AppxProvisionedPackage did not return Chocolatey."
            }
        }
        catch {
            Write-Host "*** AVD CUSTOMIZER PHASE ***  Install Chocolatey  - Exception occured  *** : [$($_.Exception.Message)]"
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
        Write-Host "*** AVD CUSTOMIZER PHASE : Install Chocolatey -  Exit Code: $LASTEXITCODE ***"    
        Write-Host "Ending AVD Customization : Install Chocolatey - Time taken: $elapsedTime"
    }


}

InstallChocolateyforAVD -ChocoDownloadLink $ChocoDownloadLink