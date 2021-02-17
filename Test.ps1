[System.Net.Dns]::GetHostAddresses("github.com") | foreach {Write-Host $_.IPAddressToString }
