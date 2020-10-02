function Get-PipxVersion {
    return "Pipx $(pipx --version | Select-Object -First 1)"
}

Get-PipxVersion
