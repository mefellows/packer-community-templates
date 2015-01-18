# There needs to be Oracle CA (Certificate Authority) certificates installed in order
# to prevent user intervention popups which will undermine a silent installation.
cmd /c certutil -addstore -f "TrustedPublisher" A:\oracle-cert.cer

# If the ISO is uploaded, unzip it, otherwise download the EXE directly
if ( Test-Path "C:\Users\vagrant\VBoxGuestAdditions.iso" ) {
    # We also need to download 7zip...
    if ( -not ( Test-Path "C:\Windows\Temp\7z920-x64.msi") ) {
        cmd /c powershell -Command "(New-Object System.Net.WebClient).DownloadFile('http://aarnet.dl.sourceforge.net/project/sevenzip/7-Zip/9.20/7z920-x64.msi', 'C:\Windows\Temp\7z920-x64.msi')"
    }
    cmd /c msiexec /qb /i C:\Windows\Temp\7z920-x64.msi
    cmd /c move /Y C:\Users\vagrant\VBoxGuestAdditions.iso C:\Windows\Temp
    cmd /c "C:\Program Files\7-Zip\7z.exe" x C:\Windows\Temp\VBoxGuestAdditions.iso -oC:\Windows\Temp\virtualbox
    cmd /c C:\Windows\Temp\virtualbox\VBoxWindowsAdditions.exe /S
    rm C:\Windows\Temp\VBoxGuestAdditions.iso
} else {
    md C:\Windows\Temp\virtualbox
	cmd /c powershell -Command "(New-Object System.Net.WebClient).DownloadFile('http://download.virtualbox.org/virtualbox/4.3.20/VirtualBox-4.3.20-96997-Win.exe', 'C:\Windows\Temp\virtualbox\VBoxWindowsAdditions.exe')"
    C:\Windows\Temp\virtualbox\VBoxWindowsAdditions.exe --extract --path C:\Windows\Temp\virtualbox --silent
    Start-Sleep -s 5
    C:\Windows\Temp\virtualbox\VirtualBox-4.3.20-r96997-MultiArch_amd64.msi /quiet /norestart
    #VirtualBox-4.3.20-r96997-MultiArch_x86.msi /quiet /norestart
    rm C:\Windows\Temp\virtualbox\VBoxWindowsAdditions.exe -ErrorAction SilentlyContinue
}
