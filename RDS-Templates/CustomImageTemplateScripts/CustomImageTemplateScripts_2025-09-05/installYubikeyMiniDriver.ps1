 <#Author       : Joseph Karns
# Usage        : Install Yubikey Smartcard MiniDriver x64
#>


##############################################
#    Install Yubikey Smartcard MiniDriver    #
##############################################

[CmdletBinding()]
  Param (
        [Parameter(Mandatory)]
        [string]$YubikeyDriverDownloadLink,

        [Parameter(Mandatory)]
        [string]$YubikeyDriverVersion
)

function InstallYubikeyDriverforAVD($YubikeyDriverDownloadLink, $YubikeyDriverVersion) {

    Begin {
        $stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
        $templateFilePathFolder = "C:\AVDImage"
        Write-host "Starting AVD Customization: Install Yubikey Driver : $((Get-Date).ToUniversalTime()) "

        $guid = [guid]::NewGuid().Guid
        $tempFolder = (Join-Path -Path "C:\temp\" -ChildPath $guid)

        if (!(Test-Path -Path $tempFolder)) {
            New-Item -Path $tempFolder -ItemType Directory
        }

        Write-Host "AVD Customization: Install Yubikey Driver: Created temp folder $tempFolder"
    }

    Process {
        try {
            Write-host "AVD Customization: Install Yubikey Driver - Requested to Install Yubikey Driver"

            $appName = 'yubikey'
            $appVersion = $YubikeyDriverVersion
            New-Item -Path $tempFolder -Name $appName  -ItemType Directory -ErrorAction SilentlyContinue
            $LocalPath = $tempFolder + '\' + $appName
            $YubikeyExe = 'YubiKey-Minidriver-' + $appVersion + '-x64.msi'
            $outputPath = $LocalPath + '\' + $YubikeyExe

            Invoke-WebRequest -Uri $YubikeyDriverDownloadLink -OutFile $outputPath

            Start-Process -FilePath msiexec.exe -Args "/i $outputPath INSTALL_LEGACY_NODE=1 /quiet" -Wait

            New-Item -Path "HKLM:\Software\Yubico" -Name "ykmd" -Force -ErrorAction Ignore
            New-ItemProperty -Path "HKLM:\Software\Yubico\ykmd" -Name "NewKeyTouchPolicy" -Value 3 -force

            Write-host "AVD Customization: Install Yubikey Driver - Finished installation of Yubikey Driver"
            $isYubiInstalled = Get-WindowsDriver -Online | Where-Object {($_.ProviderName -like "Yubico") -and ($_.ClassName -like "SmartCard") -and ($_.Version -like "*")} | Select-Object -ExpandProperty "Version"

            if ($isYubiInstalled == $appVersion) {
                Write-Host "AVD Customization: Install Yubikey Driver - Get-WindowsDriver returned the correct Yubikey Driver version."
            } else {
                Write-Host "AVD Customization: Install Yubikey Driver - Get-WindowsDriver did not return the correct Yubikey Driver version."
            }
        }
        catch {
            Write-Host "*** AVD CUSTOMIZER PHASE ***  Install Yubikey Driver  - Exception occured  *** : [$($_.Exception.Message)]"
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
        Write-Host "*** AVD CUSTOMIZER PHASE : Install Yubikey Driver -  Exit Code: $LASTEXITCODE ***"    
        Write-Host "Ending AVD Customization : Install Yubikey Driver - Time taken: $elapsedTime"
    }


}

InstallYubikeyDriverforAVD -YubikeyDriverDownloadLink $YubikeyDriverDownloadLink -YubikeyDriverVersion $YubikeyDriverVersion