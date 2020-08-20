$buildScriptsPackageUrl = 'https://appcenterbuildassets-int.azureedge.net/buildscripts/appcenter-build-assets-latest.zip'
Invoke-WebRequest -Uri $buildScriptsPackageUrl -OutFile 'appcenter-build-assets-latest.zip'
unzip -q -d 'scripts' 'appcenter-build-assets-latest.zip'
ls .
# if (Test-Path ./scripts) { Invoke-Expression 'bash ./scripts/init.sh' }
