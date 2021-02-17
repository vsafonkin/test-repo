[System.Net.Dns]::GetHostAddresses("google.com") | foreach {Write-Host $_.IPAddressToString }
