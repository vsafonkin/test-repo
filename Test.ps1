

$sdkManager = "$env:ANDROID_SDK_ROOT\tools\bin\sdkmanager.bat"
& $sdkManager "ndk;22.*" | Out-Null

Get-ChildItem "$env:ANDROID_SDK_ROOT\ndk"
Write-Host "----------------"
& $sdkManager --list
