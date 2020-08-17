# $Url = "https://download.microsoft.com/download/5/6/3/5635D6A9-885E-4C80-A2E7-8A7F4488FBF1/VB60SP6-KB2708437-x86-ENU.msi"
$Url = "https://download.microsoft.com/download/5/a/d/5ad868a0-8ecd-4bb0-a882-fe53eb7ef348/VB6.0-KB290887-X86.exe"
(New-Object System.Net.WebClient).DownloadFile($Url, "C:\\vb6.exe")

New-Item -ItemType "directory" -Path "C:\\" -Name "vb6"
# & "C:\\vb6.exe /T:C:\vb6 /C /Q"

ls C:\\
