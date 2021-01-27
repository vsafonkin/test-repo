function Get-AndroidSDKManagerPath {
    return Join-Path $env:ANDROID_HOME "tools\bin\sdkmanager.bat"
}

function Get-AndroidAvailablePackages {
    $androidSDKManagerPath = Get-AndroidSDKManagerPath
    $androidSDKManagerList = & $androidSDKManagerPath --list --include_obsolete
    $androidAvailablePackages = @()
    $availablePackagesFlag = $false
    foreach($packageInfo in $androidSDKManagerList) {
        if(-not $availablePackagesFlag -and $packageInfo -Match "Available Packages:") {
            $availablePackagesFlag = $true
        }
        if ($availablePackagesFlag) {
            $androidAvailablePackages += $packageInfo
        }
    }
    return $androidAvailablePackages
}

# $sdkManager = "$env:ANDROID_SDK_ROOT\tools\bin\sdkmanager.bat"
# & $sdkManager "ndk;22" | Out-Null

# Get-ChildItem "$env:ANDROID_SDK_ROOT\ndk"
# Write-Host "----------------"
# & $sdkManager --list

Get-AndroidAvailablePackages
