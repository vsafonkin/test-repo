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
    $result = (Get-CommandResult "pipx --version").Output
    $pipxVersion = $result -match "(?<version>\d+\.\d+\.\d+\.?\d*)" | Out-Null
    return "Pipx $pipxVersion"
}

Get-PipxVersion