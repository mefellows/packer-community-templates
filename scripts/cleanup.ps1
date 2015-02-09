# Let's cleanup!
#
# See http://www.hurryupandwait.io/blog/in-search-of-a-light-weight-windows-vagrant-box
# for details!

# Reduce PageFile size
$System = GWMI Win32_ComputerSystem -EnableAllPrivileges
$System.AutomaticManagedPagefile = $False
$System.Put()

$CurrentPageFile = gwmi -query "select * from Win32_PageFileSetting where name='c:\\pagefile.sys'"
$CurrentPageFile.InitialSize = 512
$CurrentPageFile.MaximumSize = 512
$CurrentPageFile.Put()

# Cleanup update uninstallers
Dism.exe /online /Cleanup-Image /StartComponentCleanup /ResetBase

# Run disk cleanup - need to install following and restart
Add-WindowsFeature -Name Desktop-Experience