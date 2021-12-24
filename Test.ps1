For ($i = 0; $i -lt 100; $i++) {
  $outfile = "dotnet-$i.zip"
  curl https://dotnetcli.azureedge.net/dotnet/Sdk/5.0.403/dotnet-sdk-5.0.403-win-x64.zip -o $outfile
}
