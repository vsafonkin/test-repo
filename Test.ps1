Get-ChildItem /usr/share | Where-Object { $_ -match "az_\d+" } | Foreach-Object {
    $_.Name.Split("_")[1]
}
