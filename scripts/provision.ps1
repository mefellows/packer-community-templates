# Enable basic Web Server features
Install-WindowsFeature Web-Server
Install-WindowsFeature Web-Mgmt-Tools
Install-WindowsFeature Web-App-Dev -IncludeAllSubFeature

# Install .NET and related tools so we can build/test/CI.
choco install seek-dsc -y
choco install netfx-4.5.1-devpack -y
choco install microsoft-build-tools -y
choco install vs2013agents -y
Install-WindowsFeature NET-Framework-Core # needs to be here otherwise other packages above don't install

# F# Bundle
cd $env:TEMP
$webclient = New-Object Net.WebClient
$url = 'http://download.microsoft.com/download/E/A/3/EA38D9B8-E00F-433F-AAB5-9CDA28BA5E7D/FSharp_Bundle.exe'
$webclient.DownloadFile($url, "$pwd\FSharp_Bundle.exe")
.\FSharp_Bundle.exe /install /quiet