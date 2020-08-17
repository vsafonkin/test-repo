$Url = "https://www.microsoft.com/en-us/download/confirmation.aspx?id=7030"
Invoke-WebRequest $Url
(New-Object System.Net.WebClient).DownloadFile($Url, "C:\\vb6.msi")
$ArgumentList = ('/i', 'C:\\vb6.msi', '/QN', '/norestart')
$filePath = "msiexec.exe"
$process = Start-Process -FilePath $filePath -ArgumentList $ArgumentList -Wait -PassThru
Write-Host $process.ExitCode
