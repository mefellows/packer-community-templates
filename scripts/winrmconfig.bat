cmd.exe /c powershell -Command "Set-ExecutionPolicy -ExecutionPolicy bypass -Force"
Set-Item WSMan:\localhost\Client\TrustedHosts -Value * -Force
Restart-Service WinRM
winrm quickconfig -q
winrm set "winrm/config/winrs" '@{MaxMemoryPerShellMB="512"}'
winrm set "winrm/config" '@{MaxTimeoutms="1800000"}'
winrm set "winrm/config/service" '@{AllowUnencrypted="true"}'
winrm set "winrm/config/client" '@{AllowUnencrypted="true"}'
winrm set "winrm/config/service/auth" '@{Basic="true"}'
winrm set "winrm/config/client/auth" '@{CredSSP="true"}'
winrm set "winrm/config/service/auth" '@{CredSSP="true"}'

# Need to run this on client and server
Enable-WSManCredSSP -role client -delegatecomputer * -force
Enable-WSManCredSSP -role client -delegatecomputer *.seek.int  -force
Enable-WSManCredSSP -role server -force
Restart-Service WinRM

C:\Windows\SysWOW64\cmd.exe /c powershell -Command "Set-ExecutionPolicy -ExecutionPolicy bypass -Force"
cmd.exe /c winrm quickconfig -q
cmd.exe /c winrm quickconfig '-transport:http'
cmd.exe /c winrm set "winrm/config" '@{MaxTimeoutms="1800000"}'
cmd.exe /c winrm set "winrm/config/winrs" '@{MaxMemoryPerShellMB="512"}'
cmd.exe /c winrm set "winrm/config/service" '@{AllowUnencrypted="true"}'
cmd.exe /c winrm set "winrm/config/client" '@{AllowUnencrypted="true"}'
cmd.exe /c winrm set "winrm/config/service/auth" '@{Basic="true"}'
cmd.exe /c winrm set "winrm/config/client/auth" '@{Basic="true"}'
cmd.exe /c winrm set "winrm/config/service/auth" '@{CredSSP="true"}'
cmd.exe /c winrm set "winrm/config/listener?Address=*+Transport=HTTP" '@{Port="5985"}'
cmd.exe /c netsh advfirewall firewall set rule group="remote administration" new enable=yes
cmd.exe /c netsh firewall add portopening TCP 5985 "Port 5985" 
cmd.exe /c net stop winrm 
cmd.exe /c sc config winrm start= auto
cmd.exe /c net start winrm

cmd.exe /c wmic useraccount where "name='vagrant'" set PasswordExpires=FALSE
