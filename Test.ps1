Import-Module .\helpers.psm1 -DisableNameChecking

# Start-Process -FilePath "$env:comspec" -ArgumentList "/c echo %SystemDrive%" -PassThru -Wait -Verb RunAs
# Get-ChildItem "C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\VC\Auxiliary\Build"


# $MyProcess = New-Object System.Diagnostics.Process
    
# $MyProcess.StartInfo.FileName = "$env:comspec"
# $MyProcess.StartInfo.UseShellExecute = $false
# $MyProcess.StartInfo.RedirectStandardInput = $true
# $MyProcess.StartInfo.Verb = "RunAs"
# $MyProcess.Start() | Out-Null
# $StdIn = $MyProcess.StandardInput
# $StdIn.WriteLine("echo %APPDATA%")
# $StdIn.WriteLine("echo %SystemDrive%")
# $StdIn.Close()

# Write-Host "-------"
# Install-Binary -Url "https://github.com/compnerd/swift-build/releases/latest/download/toolchain.msi" -Name "toolchain.msi"
# Install-Binary -Url "https://github.com/compnerd/swift-build/releases/latest/download/sdk.msi" -Name "sdk.msi"

$commandLineNativeTools = "C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\VC\Auxiliary\Build\vcvars64.bat"
# & $commandLineNativeTools

# $pinfo = New-Object System.Diagnostics.ProcessStartInfo
# $pinfo.FileName = $commandLineNativeTools
# # $pinfo.Arguments = "/c", "echo", "%APPDATA%"
# $pinfo.RedirectStandardError = $true
# $pinfo.RedirectStandardOutput = $true
# $pinfo.RedirectStandardInput = $true
# $pinfo.UseShellExecute = $false
# $pinfo.Verb = "RunAs"
# $p = New-Object System.Diagnostics.Process
# $p.StartInfo = $pinfo
# $p.Start() | Out-Null
# Start-Sleep -s 2
# $p.StandardInput.WriteLine("echo %APPDATA%");
# # $p.WaitForExit()
# $output = $p.StandardOutput.ReadToEnd()
# $output += $p.StandardError.ReadToEnd()
# $output

# Start-Process -FilePath $commandLineNativeTools -ArgumentList "/c echo %SystemDrive%" -PassThru -Wait -Verb RunAs
# cmd.exe -c "C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\VC\Auxiliary\Build\vcvars64.bat"


$MyProcess = New-Object System.Diagnostics.Process
    
$MyProcess.StartInfo.FileName = $env:comspec
$MyProcess.StartInfo.UseShellExecute = $false
$MyProcess.StartInfo.RedirectStandardInput = $true
# $MyProcess.StartInfo.RedirectStandardOutput = $true
$MyProcess.StartInfo.Verb = "RunAs"
$MyProcess.Start() | Out-Null
Start-Sleep -s 10
$StdIn = $MyProcess.StandardInput
# $StdOut = $MyProcess.StandardOutput
# $StdIn.WriteLine("copy %SDKROOT%\usr\share\ucrt.modulemap `"%UniversalCRTSdkDir%\Include\%UCRTVersion%\ucrt\module.modulemap`"")
$StdIn.WriteLine($commandLineNativeTools)
$StdIn.WriteLine("SET > C:\vcvars.txt")
$StdIn.Close()

# $output = $StdOut.ReadToEnd()
# $output

Get-ChildItem "C:"
