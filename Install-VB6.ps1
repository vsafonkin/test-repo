# $Url = "https://download.microsoft.com/download/5/6/3/5635D6A9-885E-4C80-A2E7-8A7F4488FBF1/VB60SP6-KB2708437-x86-ENU.msi"
$Url = "https://download.microsoft.com/download/5/a/d/5ad868a0-8ecd-4bb0-a882-fe53eb7ef348/VB6.0-KB290887-X86.exe"
(New-Object System.Net.WebClient).DownloadFile($Url, "C:\\vb6.exe")
$ArgumentList = ('/i', 'C:\\vb6.msi', '/QN', '/norestart')
$filePath = "C:\\vb6.exe"
# $process = Start-Process -FilePath $filePath -ArgumentList $ArgumentList -Verb RunAs -Wait -PassThru
# Write-Host $process.ExitCode

$pinfo = New-Object System.Diagnostics.ProcessStartInfo
$pinfo.FileName = $filePath
$pinfo.RedirectStandardError = $true
$pinfo.RedirectStandardOutput = $true
$pinfo.UseShellExecute = $false
$pinfo.Arguments = $ArgumentList
$p = New-Object System.Diagnostics.Process
$p.StartInfo = $pinfo
$p.Start() | Out-Null
$p.WaitForExit()
$stdout = $p.StandardOutput.ReadToEnd()
$stderr = $p.StandardError.ReadToEnd()
Write-Host "stdout: $stdout"
Write-Host "stderr: $stderr"
Write-Host "exit code: " + $p.ExitCode
