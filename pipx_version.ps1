function Get-CommandResult {
    param (
        [Parameter(Mandatory=$true)]
        [string] $Command,
        [switch] $Multiline
    )
    # Bash trick to suppress and show error output because some commands write to stderr (for example, "python --version")
    $stdout = & bash -c "$Command 2>&1"
    $exitCode = $LASTEXITCODE
    return @{
        Output = If ($Multiline -eq $true) { $stdout } else { [string]$stdout }
        ExitCode = $exitCode
    }
}

function Get-PipxVersion {
#     $pipxVersion = (pipx --version 2> $null)
    return "Pipx $(pipx --version 2> $null)"
}

function Get-YamllintVersion {
    return (yamllint --version | Out-String)
}

Get-PipxVersion
Write-Host "-----"
Get-YamllintVersion
