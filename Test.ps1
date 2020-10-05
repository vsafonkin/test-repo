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


function Get-ErlangVersion {
    $result = Get-CommandResult "erl -version"
    $result.Output -match "version (?<version>\d+\.\d+\.\d+)" | Out-Null
    $version = $Matches.version
    return "Erlang $version"
}

Get-ErlangVersion
