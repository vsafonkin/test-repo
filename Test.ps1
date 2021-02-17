[System.Net.Dns]::GetHostAddresses("amazon.com") | foreach {Write-Host $_.IPAddressToString }
