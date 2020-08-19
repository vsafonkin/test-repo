$origPath = $env:PATH
$env:PATH = "C:\msys64\mingw64\bin;C:\msys64\usr\bin;$origPath"
pacman -Syu --noconfirm --needed --noprogressbar clang
