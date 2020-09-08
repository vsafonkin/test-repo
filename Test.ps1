$(phpunit --version) -match "(?<version>\d+\.\d+\.\d+)\s" | Out-Null
$Matches.Version
   
