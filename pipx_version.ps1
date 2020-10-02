function Get-PipxVersion {
    return "Pipx $((pipx --version | Out-String).Split(" ")[0])"
}

Get-PipxVersion
Write-Host "-----"
