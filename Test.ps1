[System.Net.Dns]::GetHostAddresses("localhost") | foreach {Write-Host $_.IPAddressToString }
