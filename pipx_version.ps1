function Get-PipxVersion {
    return "Pipx $(pipx --version | Out-String)"
}

Get-PipxVersion
