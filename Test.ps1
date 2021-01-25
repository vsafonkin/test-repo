

$sdkManager = "$env:ANDROID_SDK_ROOT\tools\bin\sdkmanager.bat"
& $sdkManager "ndk;21.3.6528147" | Out-Null
& $sdkManager "ndk;22.0.7026061" | Out-Null

Get-ChildItem "$env:ANDROID_SDK_ROOT\ndk"
Write-Host "----------------"
& $sdkManager --list
