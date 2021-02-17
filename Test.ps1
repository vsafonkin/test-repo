[System.Net.Dns]::GetHostAddresses("jaraco.com") | foreach {Write-Host $_.IPAddressToString }
Write-Host "-----"

Install-Module DnsClient
Import-Module DnsClient

Resolve-DnsName -Name "jaraco.com"
