$Url = "https://download.microsoft.com/download/5/6/3/5635D6A9-885E-4C80-A2E7-8A7F4488FBF1/VB60SP6-KB2708437-x86-ENU.msi"
(New-Object System.Net.WebClient).DownloadFile($Url, "C:\\vb6.msi")
$ArgumentList = ('/i', 'C:\\vb6.msi', '/QN', '/norestart')
$filePath = "msiexec.exe"
$process = Start-Process -FilePath $filePath -ArgumentList $ArgumentList -Wait -PassThru
Write-Host $process.ExitCode
