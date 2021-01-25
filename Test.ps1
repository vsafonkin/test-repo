Get-ChildItem "$env:ANDROID_SDK_ROOT\ndk"

$sdkManager = "$env:ANDROID_SDK_ROOT\tools\bin\sdkmanager.bat"
& $sdkManager --list
