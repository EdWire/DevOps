<#Author       : Joseph Karns
# Usage        : Install ODBC Drivers x64
#>


################################
#    Install ODBC Drivers    #
################################

[CmdletBinding()]
Param (
    [Parameter(Mandatory)]
    [System.String[]]$ODBCDriverVersionsList
)

function InstallODBCDriverforAVD($ODBCDriverVersionsList) {

    Begin {
        $stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
        $templateFilePathFolder = "C:\AVDImage"
        Write-host "Starting AVD Customization: Install ODBC Driver : $((Get-Date).ToUniversalTime()) "

        $guid = [guid]::NewGuid().Guid
        $tempFolder = (Join-Path -Path "C:\temp\" -ChildPath $guid)

        if (!(Test-Path -Path $tempFolder)) {
            New-Item -Path $tempFolder -ItemType Directory
        }

        Write-Host "AVD Customization: Install ODBC Driver: Created temp folder $tempFolder"
    }

    Process {
        foreach ($Version in $ODBCDriverVersionsList) {
            try {
                Write-host "AVD Customization: Install ODBC Driver - Requested to Install ODBC Driver Version $Version"

                $appName = 'odbc'
                $appVersion = $Version
                New-Item -Path $tempFolder -Name $appName  -ItemType Directory -ErrorAction SilentlyContinue
                $PartialPath = $tempFolder + '\' + $appName
                New-Item -Path $PartialPath -Name $appVersion  -ItemType Directory -ErrorAction SilentlyContinue
                $LocalPath = $tempFolder + '\' + $appName + '\' + $appVersion
                $msodbcsqlMsi = 'msodbcsql.msi'
                $outputPath = $LocalPath + '\' + $msodbcsqlMsi

                switch ($Version) {
                    18.5.2.1 { $ODBCDriverDownloadLink = "https://go.microsoft.com/fwlink/?linkid=2335671" }
                    18.5.1.1 { $ODBCDriverDownloadLink = "https://go.microsoft.com/fwlink/?linkid=2307162" }
                    18.4.1.1 { $ODBCDriverDownloadLink = "https://go.microsoft.com/fwlink/?linkid=2280794" }
                    18.3.3.1 { $ODBCDriverDownloadLink = "https://go.microsoft.com/fwlink/?linkid=2266640" }
                    17.10.6.1 { $ODBCDriverDownloadLink = "https://go.microsoft.com/fwlink/?linkid=2266337" }
                    18.3.2.1 { $ODBCDriverDownloadLink = "https://go.microsoft.com/fwlink/?linkid=2249006" }
                    17.10.5.1 { $ODBCDriverDownloadLink = "https://go.microsoft.com/fwlink/?linkid=2249004" }
                    18.3.1.1 { $ODBCDriverDownloadLink = "https://go.microsoft.com/fwlink/?linkid=2242886" }
                    18.2.2.1 { $ODBCDriverDownloadLink = "https://go.microsoft.com/fwlink/?linkid=2239549" }
                    17.10.4.1 { $ODBCDriverDownloadLink = "https://go.microsoft.com/fwlink/?linkid=2239168" }
                    18.2.1.1 { $ODBCDriverDownloadLink = "https://go.microsoft.com/fwlink/?linkid=2223270" }
                    17.10.3.1 { $ODBCDriverDownloadLink = "https://go.microsoft.com/fwlink/?linkid=2223304" }
                    18.1.2.1 { $ODBCDriverDownloadLink = "https://go.microsoft.com/fwlink/?linkid=2214634" }
                    17.10.2.1 { $ODBCDriverDownloadLink = "https://go.microsoft.com/fwlink/?linkid=2217421" }
                    18.1.1.1 { $ODBCDriverDownloadLink = "https://go.microsoft.com/fwlink/?linkid=2202930" }
                    17.10.1.1 { $ODBCDriverDownloadLink = "https://go.microsoft.com/fwlink/?linkid=2200731" }
                    18.0.1.1 { $ODBCDriverDownloadLink = "https://go.microsoft.com/fwlink/?linkid=2186919" }
                    17.9.1.1 { $ODBCDriverDownloadLink = "https://go.microsoft.com/fwlink/?linkid=2187214" }
                    17.8.1.1 { $ODBCDriverDownloadLink = "https://go.microsoft.com/fwlink/?linkid=2168524" }
                    17.7.2.1 { $ODBCDriverDownloadLink = "https://go.microsoft.com/fwlink/?linkid=2156851" }
                    17.7.1.1 { $ODBCDriverDownloadLink = "https://go.microsoft.com/fwlink/?linkid=2153471" }
                    17.6.1.1 { $ODBCDriverDownloadLink = "https://go.microsoft.com/fwlink/?linkid=2137027" }
                    17.5.2.1 { $ODBCDriverDownloadLink = "https://go.microsoft.com/fwlink/?linkid=2120137" }
                    17.5.1.1 { $ODBCDriverDownloadLink = "https://go.microsoft.com/fwlink/?linkid=2120248" }
                    17.4.2.1 { $ODBCDriverDownloadLink = "https://go.microsoft.com/fwlink/?linkid=2120354" }
                    17.4.1.1 { $ODBCDriverDownloadLink = "https://go.microsoft.com/fwlink/?linkid=2120149" }
                    17.3.1.1 { $ODBCDriverDownloadLink = "https://go.microsoft.com/fwlink/?linkid=2120355" }
                    17.2.0.1 { $ODBCDriverDownloadLink = "https://go.microsoft.com/fwlink/?linkid=2120250" }
                    17.1.0.1 { $ODBCDriverDownloadLink = "https://go.microsoft.com/fwlink/?linkid=2120151" }
                    17.0.1.1 { $ODBCDriverDownloadLink = "https://go.microsoft.com/fwlink/?linkid=2120444" }
                    13.1.0.0 { $ODBCDriverDownloadLink = "https://go.microsoft.com/fwlink/?linkid=2121020" }
                    13.0.0.0 { $ODBCDriverDownloadLink = "https://go.microsoft.com/fwlink/?linkid=2121118" }
                    11.0.0.0 { $ODBCDriverDownloadLink = "https://go.microsoft.com/fwlink/?linkid=2121206" }
                    default { $ODBCDriverDownloadLink = "https://go.microsoft.com/fwlink/?linkid=2335671" }
                }

                Invoke-WebRequest -Uri $ODBCDriverDownloadLink -OutFile $outputPath

                Start-Process -FilePath msiexec.exe -Args "/i $outputPath ADDLOCAL=ALL IACCEPTMSODBCSQLLICENSETERMS=YES /passive" -Wait

                Write-host "AVD Customization: Install ODBC Driver - Finished Installation of ODBC Driver Version $Version"

                $isoledbdInstalled = Get-ChildItem -Path "HKLM:\SOFTWARE\ODBC", "HKLM:\SOFTWARE\Wow6432Node\ODBC" | Where-Object { $_.Name -like "*ODBC.INI*" }
                
                if ($isoledbdInstalled) {
                    Write-Host "AVD Customization: Install ODBC Driver - Windows Registry returned the ODBC Driver."
                }
                else {
                    Write-Host "AVD Customization: Install ODBC Driver - Windows Registry did not return the ODBC Driver."
                }
            }
            catch {
                Write-Host "*** AVD CUSTOMIZER PHASE ***  Install ODBC Driver  - Exception occured  *** : [$($_.Exception.Message)]"
            }
        }
    }

    End {

        #Cleanup
        if ((Test-Path -Path $templateFilePathFolder -ErrorAction SilentlyContinue)) {
            Remove-Item -Path $templateFilePathFolder -Force -Recurse -ErrorAction Continue
        }

        $stopwatch.Stop()
        $elapsedTime = $stopwatch.Elapsed
        Write-Host "*** AVD CUSTOMIZER PHASE : Install ODBC Driver -  Exit Code: $LASTEXITCODE ***"    
        Write-Host "Ending AVD Customization : Install ODBC Driver - Time taken: $elapsedTime"
    }


}

InstallODBCDriverforAVD -ODBCDriverVersionsList $ODBCDriverVersionsList