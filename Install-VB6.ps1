# $Url = "https://download.microsoft.com/download/5/6/3/5635D6A9-885E-4C80-A2E7-8A7F4488FBF1/VB60SP6-KB2708437-x86-ENU.msi"

New-Item -ItemType "directory" -Path "C:\" -Name "vb6"

$Url = "https://download.microsoft.com/download/5/a/d/5ad868a0-8ecd-4bb0-a882-fe53eb7ef348/VB6.0-KB290887-X86.exe"
(New-Object System.Net.WebClient).DownloadFile($Url, "C:\vb6.exe")

7z.exe x "C:\vb6.exe" -o"C:\vb6" -y | Out-Null
7z.exe x "C:\vb6\vbrun60sp6.exe" -o"C:\vb6" -y | Out-Null
Push-Location "C:\vb6"

ls .
