[System.Net.Dns]::GetHostAddresses("jaraco.com") | foreach {Write-Host $_.IPAddressToString }
