$(phpunit --version) -match "(?<version>\d+\.\d+\.\d+)\s" | Out-Null
Write-Host $Matches.Version
   
