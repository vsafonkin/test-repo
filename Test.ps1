Import-Module .\helpers.psm1 -DisableNameChecking
Start-Process -FilePath "C:\Windows\System32\cmd.exe" -verb runas -ArgumentList {/c echo hello1}
cmd.exe -c "/c echo %APPDATA%"
Start-Process -FilePath "$env:comspec" -ArgumentList "/c echo %SystemDrive%" -PassThru -Wait -Verb RunAs
# Get-ChildItem "C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\VC\Auxiliary\Build"

Write-Host "-------"
Install-Binary -Url "https://github.com/compnerd/swift-build/releases/latest/download/toolchain.msi" -Name "toolchain.msi"
Install-Binary -Url "https://github.com/compnerd/swift-build/releases/latest/download/sdk.msi" -Name "sdk.msi"

$commandLineNativeTools = "C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\VC\Auxiliary\Build\vcvars64.bat"
Start-Process -FilePath $commandLineNativeTools -ArgumentList "/c echo %SystemDrive%" -PassThru -Wait -Verb RunAs
# cmd.exe -c "C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\VC\Auxiliary\Build\vcvars64.bat"
