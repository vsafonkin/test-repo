Import-Module .\helpers.psm1 -DisableNameChecking


# Get-ChildItem "C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\VC\Auxiliary\Build"


Install-Binary -Url "https://github.com/compnerd/swift-build/releases/latest/download/toolchain.msi" -Name "toolchain.msi"
Install-Binary -Url "https://github.com/compnerd/swift-build/releases/latest/download/sdk.msi" -Name "sdk.msi"

$commandLineNativeTools = "C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\VC\Auxiliary\Build\vcvars64.bat"
Start-Process -FilePath $commandLineNativeTools -ArgumentList "echo %UniversalCRTSdkDir%" -Verb RunAs

