Import-Module .\helpers.psm1 -DisableNameChecking

# Start-Process -FilePath "$env:comspec" -ArgumentList "/c echo %SystemDrive%" -PassThru -Wait -Verb RunAs
# Get-ChildItem "C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\VC\Auxiliary\Build"

# $pinfo = New-Object System.Diagnostics.ProcessStartInfo
# $pinfo.FileName = "$env:comspec"
# $pinfo.Arguments = "/c", "echo", "%APPDATA%"
# $pinfo.RedirectStandardError = $true
# $pinfo.RedirectStandardOutput = $true
# $pinfo.UseShellExecute = $false
# $pinfo.Verb = "RunAs"
# $p = New-Object System.Diagnostics.Process
# $p.StartInfo = $pinfo
# $p.Start() | Out-Null
# $p.WaitForExit()
# $output = $p.StandardOutput.ReadToEnd()
# $output += $p.StandardError.ReadToEnd()
# $output

Write-Host "-------"
Install-Binary -Url "https://github.com/compnerd/swift-build/releases/latest/download/toolchain.msi" -Name "toolchain.msi"
Install-Binary -Url "https://github.com/compnerd/swift-build/releases/latest/download/sdk.msi" -Name "sdk.msi"

$commandLineNativeTools = "C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\VC\Auxiliary\Build\vcvars64.bat"


$pinfo = New-Object System.Diagnostics.ProcessStartInfo
$pinfo.FileName = $commandLineNativeTools
# $pinfo.Arguments = "/c", "echo", "%APPDATA%"
$pinfo.RedirectStandardError = $true
$pinfo.RedirectStandardOutput = $true
$pinfo.RedirectStandardInput = $true
$pinfo.UseShellExecute = $false
$pinfo.Verb = "RunAs"
$p = New-Object System.Diagnostics.Process
$p.StartInfo = $pinfo
$p.Start()
Start-Sleep -s 2
$p.StandardInput.WriteLine("echo %APPDATA%");
$p.WaitForExit()
$output = $p.StandardOutput.ReadToEnd()
$output += $p.StandardError.ReadToEnd()
$output

# Start-Process -FilePath $commandLineNativeTools -ArgumentList "/c echo %SystemDrive%" -PassThru -Wait -Verb RunAs
# cmd.exe -c "C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\VC\Auxiliary\Build\vcvars64.bat"

