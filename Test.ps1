$origPath = $env:PATH
$env:PATH = "C:\msys64\mingw64\bin;C:\msys64\usr\bin;$origPath"
pacman -R compression
taskkill /f /fi "MODULES eq msys-2.0.dll"
pacman -S --noconfirm --needed --noprogressbar compression
