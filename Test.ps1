[System.Net.Dns]::GetHostAddresses("jaraco.com") | foreach {Write-Host $_.IPAddressToString }
Write-Host "-----"
Resolve-DnsName -Name "jaraco.com"
