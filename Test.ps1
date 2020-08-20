$buildScriptsPackageUrl = 'https://appcenterbuildassets-int.azureedge.net/buildscripts/appcenter-build-assets-latest.zip'
Invoke-WebRequest -Uri $buildScriptsPackageUrl -OutFile 'appcenter-build-assets-latest.zip'
# New-Item -ItemType directory -Path 'scripts' | Out-Null
unzip -q -d 'scripts' 'appcenter-build-assets-latest.zip'
if (Test-Path ./scripts) { Invoke-Expression 'bash ./scripts/init.sh' }
