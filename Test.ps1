Import-Module .\helpers.psm1 -DisableNameChecking

Install-Binary -Url "https://github.com/compnerd/swift-build/releases/latest/download/toolchain.msi" -Name "toolchain.msi"
Install-Binary -Url "https://github.com/compnerd/swift-build/releases/latest/download/sdk.msi" -Name "sdk.msi"
