Invoke-WebRequest -Uri 'https://appcenterbuildassets-int.azureedge.net/buildscripts/appcenter-build-assets-latest.zip' -OutFile 'appcenter-build-assets-latest.zip'
if (Test-Path ./scripts) { Remove-Item -Path ./scripts -Force -Recurse }
New-Item -ItemType directory -Path 'scripts' | Out-Null
unzip -q -d 'scripts' 'appcenter-build-assets-latest.zip'
Invoke-Expression 'bash ./scripts/init.sh'
ls ./scripts
echo "------"
ls /Users/runner/.gradle/init.d
