$origPath = $env:PATH
$env:PATH = "C:\msys64\mingw64\bin;C:\msys64\usr\bin;$origPath"
Get-Command gcc
gcc -v -Wall sample.c -o sample
Write-Host "EXIT CODE: $LASTEXITCODE"
ls .
