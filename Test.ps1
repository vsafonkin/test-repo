Import-Module .\helpers.psm1 -DisableNameChecking


Get-ChildItem "C:\Program Files (x86)\Microsoft Visual Studio\2019"


Install-Binary -Url "https://github.com/compnerd/swift-build/releases/latest/download/toolchain.msi" -Name "toolchain.msi"
Install-Binary -Url "https://github.com/compnerd/swift-build/releases/latest/download/sdk.msi" -Name "sdk.msi"

