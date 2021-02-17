[System.Net.Dns]::GetHostAddresses("jaraco.com") | foreach {echo $_.IPAddressToString }

