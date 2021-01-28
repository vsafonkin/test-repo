Invoke-Expression "C:\msys64\mingw32\bin\gcc -v -m32 helloworld.c -o helloworld"
Write-Host "------"
$LastExitCode
