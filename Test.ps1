$origPath = $env:PATH
$env:PATH = "C:\msys64\mingw64\bin;C:\msys64\usr\bin;$origPath"
pacman -R --noconfirm --needed --noprogressbar base-devel
pacman -S --noconfirm --needed --noprogressbar base-devel
