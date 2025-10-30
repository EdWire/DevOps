 <#Author       : Joseph Karns
# Usage        : Install OLE DB Drivers x64
#>


################################
#    Install OLE DB Drivers    #
################################

[CmdletBinding()]
  Param (
        [Parameter(Mandatory)]
        [System.String[]]$OLEDBDriverVersionsList
)

function InstallOLEDBDriverforAVD($OLEDBDriverVersionsList) {

    Begin {
        $stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
        $templateFilePathFolder = "C:\AVDImage"
        Write-host "Starting AVD Customization: Install OLE DB Driver : $((Get-Date).ToUniversalTime()) "

        $guid = [guid]::NewGuid().Guid
        $tempFolder = (Join-Path -Path "C:\temp\" -ChildPath $guid)

        if (!(Test-Path -Path $tempFolder)) {
            New-Item -Path $tempFolder -ItemType Directory
        }

        Write-Host "AVD Customization: Install OLE DB Driver: Created temp folder $tempFolder"
    }

    Process {
        foreach ($Version in $OLEDBDriverVersionsList) {
            try {
                Write-host "AVD Customization: Install OLE DB Driver - Requested to Install OLE DB Driver Version $Version"

                $appName = 'oledb'
                $appVersion = $Version
                New-Item -Path $tempFolder -Name $appName  -ItemType Directory -ErrorAction SilentlyContinue
                $PartialPath = $tempFolder + '\' + $appName
                New-Item -Path $PartialPath -Name $appVersion  -ItemType Directory -ErrorAction SilentlyContinue
                $LocalPath = $tempFolder + '\' + $appName + '\' + $appVersion
                $msoledbsqlMsi = 'msoledbsql.msi'
                $outputPath = $LocalPath + '\' + $msoledbsqlMsi

                switch ($Version) {
                    19.4.1 { $OLEDBDriverDownloadLink = "https://go.microsoft.com/fwlink/?linkid=2318101" }
                    19.3.7 { $OLEDBDriverDownloadLink = "https://go.microsoft.com/fwlink/?linkid=2335761" }
                    19.3.6 { $OLEDBDriverDownloadLink = "https://go.microsoft.com/fwlink/?linkid=2334824" }
                    19.3.5 { $OLEDBDriverDownloadLink = "https://go.microsoft.com/fwlink/?linkid=2278038" }
                    19.3.3 { $OLEDBDriverDownloadLink = "https://go.microsoft.com/fwlink/?linkid=2266674" }
                    19.3.2 { $OLEDBDriverDownloadLink = "https://go.microsoft.com/fwlink/?linkid=2248728" }
                    19.3.1 { $OLEDBDriverDownloadLink = "https://go.microsoft.com/fwlink/?linkid=2238602" }
                    19.3.0 { $OLEDBDriverDownloadLink = "https://go.microsoft.com/fwlink/?linkid=2220017" }
                    19.2.0 { $OLEDBDriverDownloadLink = "https://go.microsoft.com/fwlink/?linkid=2212594" }
                    19.1.0 { $OLEDBDriverDownloadLink = "https://go.microsoft.com/fwlink/?linkid=2206472" }
                    19.0.0 { $OLEDBDriverDownloadLink = "https://go.microsoft.com/fwlink/?linkid=2186934" }
                    18.7.5 { $OLEDBDriverDownloadLink = "https://go.microsoft.com/fwlink/?linkid=2318002" }
                    18.7.4 { $OLEDBDriverDownloadLink = "https://go.microsoft.com/fwlink/?linkid=2278907" }
                    18.7.2 { $OLEDBDriverDownloadLink = "https://go.microsoft.com/fwlink/?linkid=2266757" }
                    18.6.7 { $OLEDBDriverDownloadLink = "https://go.microsoft.com/fwlink/?linkid=2242656" }
                    18.6.6 { $OLEDBDriverDownloadLink = "https://go.microsoft.com/fwlink/?linkid=2238605" }
                    18.6.5 { $OLEDBDriverDownloadLink = "https://go.microsoft.com/fwlink/?linkid=2218891" }
                    18.6.4 { $OLEDBDriverDownloadLink = "https://go.microsoft.com/fwlink/?linkid=2206347" }
                    18.6.3 { $OLEDBDriverDownloadLink = "https://go.microsoft.com/fwlink/?linkid=2183083" }
                    18.6.0 { $OLEDBDriverDownloadLink = "https://go.microsoft.com/fwlink/?linkid=2164384" }
                    18.5.0 { $OLEDBDriverDownloadLink = "https://go.microsoft.com/fwlink/?linkid=2135577" }
                    18.4.0 { $OLEDBDriverDownloadLink = "https://go.microsoft.com/fwlink/?linkid=2129954" }
                    18.3.0 { $OLEDBDriverDownloadLink = "https://go.microsoft.com/fwlink/?linkid=2117515" }
                    18.2.3 { $OLEDBDriverDownloadLink = "https://go.microsoft.com/fwlink/?linkid=2119554" }
                    18.2.2 { $OLEDBDriverDownloadLink = "https://go.microsoft.com/fwlink/?linkid=2118512" }
                    18.2.1 { $OLEDBDriverDownloadLink = "https://go.microsoft.com/fwlink/?linkid=2118511" }
                    18.1.0 { $OLEDBDriverDownloadLink = "https://go.microsoft.com/fwlink/?linkid=2118506" }
                    18.0.2 { $OLEDBDriverDownloadLink = "https://go.microsoft.com/fwlink/?linkid=2118504" }
                    default { $OLEDBDriverDownloadLink = "https://go.microsoft.com/fwlink/?linkid=2318101" }
                }

                Invoke-WebRequest -Uri $OLEDBDriverDownloadLink -OutFile $outputPath

                Start-Process -FilePath msiexec.exe -Args "/i $outputPath ADDLOCAL=ALL IACCEPTMSOLEDBSQLLICENSETERMS=YES /passive" -Wait

                Write-host "AVD Customization: Install OLE DB Driver - Finished Installation of OLE DB Driver Version $Version"

                $isoledbdInstalled = Get-ChildItem -Path "HKLM:\SOFTWARE\Microsoft","HKLM:\SOFTWARE\Wow6432Node\Microsoft" | Where-Object { $_.Name -like "*MSOLEDBSQL*" } | ForEach-Object { Get-ItemPropertyValue -LiteralPath $_.Name.Replace("HKEY_LOCAL_MACHINE", "HKLM:") -Name $_.Property }
                $isoledbdInstalledVersions = @()
                foreach ($version in $isoledbdInstalled) {
                    $isoledbdInstalledVersions += $version.Substring(0, $version.Length - 2)
                }
                
                if ($isoledbdInstalledVersions -contains $Version) {
                    Write-Host "AVD Customization: Install OLE DB Driver - Windows Registry returned the correct OLE DB Driver version."
                } else {
                    Write-Host "AVD Customization: Install OLE DB Driver - Windows Registry did not return the correct OLE DB Driver version."
                }
            }
            catch {
                Write-Host "*** AVD CUSTOMIZER PHASE ***  Install OLE DB Driver  - Exception occured  *** : [$($_.Exception.Message)]"
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
        Write-Host "*** AVD CUSTOMIZER PHASE : Install OLE DB Driver -  Exit Code: $LASTEXITCODE ***"    
        Write-Host "Ending AVD Customization : Install OLE DB Driver - Time taken: $elapsedTime"
    }


}

InstallOLEDBDriverforAVD -OLEDBDriverVersionsList $OLEDBDriverVersionsList