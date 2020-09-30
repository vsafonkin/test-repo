Import-Module .\helpers.psm1 -DisableNameChecking


Install-Binary -Url "https://github.com/compnerd/swift-build/releases/latest/download/toolchain.msi" -Name "toolchain.msi"
Install-Binary -Url "https://github.com/compnerd/swift-build/releases/latest/download/sdk.msi" -Name "sdk.msi"

$commandLineNativeTools = "C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\VC\Auxiliary\Build\vcvars64.bat"

$MyProcess = New-Object System.Diagnostics.Process
    
$MyProcess.StartInfo.FileName = $env:comspec
$MyProcess.StartInfo.UseShellExecute = $false
$MyProcess.StartInfo.RedirectStandardInput = $true
$MyProcess.StartInfo.Verb = "RunAs"
$MyProcess.Start() | Out-Null
$StdIn = $MyProcess.StandardInput
$StdIn.WriteLine("call `"$commandLineNativeTools`"")
$StdIn.WriteLine("SET > C:\vcvars.txt")
$StdIn.Close()
$MyProcess.WaitForExit()

Get-Content "C:\vcvars.txt" | Foreach-Object {
  if ($_ -match "^(.*?)=(.*)$") {
    Set-Content "env:\$($matches[1])" $matches[2]
  }
}

copy $env:SDKROOT\usr\share\ucrt.modulemap "$env:UniversalCRTSdkDir\Include\$env:UCRTVersion\ucrt\module.modulemap"
copy $env:SDKROOT\usr\share\visualc.modulemap "$env:VCToolsInstallDir\include\module.modulemap"
copy $env:SDKROOT\usr\share\visualc.apinotes "$env:VCToolsInstallDir\include\visualc.apinotes"
copy $env:SDKROOT\usr\share\winsdk.modulemap "$env:UniversalCRTSdkDir\Include\$env:UCRTVersion\um\module.modulemap"

Get-ChildItem C:\Library\Developer

# git clone git://github.com/compnerd/swift-cmake-examples C:\swift-cmake-examples
# $SWIFTFLAGS="-sdk $env:SDKROOT -resource-dir $env:SDKROOT/usr/lib/swift -I $env:SDKROOT/usr/lib/swift -L $env:SDKROOT/usr/lib/swift/windows"
# cmake.exe -B C:\HelloWorld -D BUILD_SHARED_LIBS=YES -D CMAKE_BUILD_TYPE=Release -D CMAKE_Swift_FLAGS=$SWIFTFLAGS -G Ninja -S C:\swift-cmake-examples\HelloWorld
