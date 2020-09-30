Import-Module .\helpers.psm1 -DisableNameChecking

# Install-Binary -Url "https://github.com/compnerd/swift-build/releases/latest/download/toolchain.msi" -Name "toolchain.msi"
# Install-Binary -Url "https://github.com/compnerd/swift-build/releases/latest/download/sdk.msi" -Name "sdk.msi"
Install-Binary -Url "https://swift.org/builds/swift-5.3-release/windows10/swift-5.3-RELEASE/swift-5.3-RELEASE-windows10.exe" -Name "swift-5.3-RELEASE-windows10.exe"
swift --version
