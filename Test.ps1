Invoke-Expression "C:\msys64\mingw32\bin\gcc -v -m32 helloworld.c -o helloworld"
Write-Host "------"
New-Item -Path "C:\Users\RUNNER~1\AppData\Local\Temp" -Name "testfile1.txt" -ItemType "file" -Value "This is a text string."
$LastExitCode
