cp C:\Users\vagrant\prl-tools-win.iso C:\Windows\Temp -Force
& "C:\Program Files\7-Zip\7z.exe" x C:\Windows\Temp\prl-tools-win.iso -oC:\Windows\Temp\parallels
C:\Windows\Temp\parallels\Autorun.exe /S

Start-Sleep -s 60