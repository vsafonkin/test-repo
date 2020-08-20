$buildScriptsPackageUrl = 'https://appcenterbuildassets-int.azureedge.net/buildscripts/appcenter-build-assets-latest.zip'
Set-Location -Path '$(Agent.HomeDirectory)'
Invoke-WebRequest -Uri $buildScriptsPackageUrl -OutFile 'appcenter-build-assets-latest.zip'
New-Item -ItemType directory -Path 'scripts' | Out-Null
unzip -q -d 'scripts' 'appcenter-build-assets-latest.zip'
ls ./scripts
