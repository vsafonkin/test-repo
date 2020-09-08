$(phpunit --version) -match "PHPUnit (?<version>\d+\.\d+\.\d+)\s" | Out-Null
$Matches.Version
   
