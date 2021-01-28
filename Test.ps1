# Invoke-Expression "C:\msys64\mingw32\bin\gcc -v helloworld.c -o helloworld"
Start-Process "C:\msys64\mingw32\bin\gcc.exe" -Verb runAs -ArgumentList @("-v", "helloworld.c", "-o", "helloworld")
