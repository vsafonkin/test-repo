function Get-ErlangVersion {
    $result = Get-CommandResult "erl -version"
    $result.Output -match "version (?<version>\d+\.\d+\.\d+)" | Out-Null
    $version = $Matches.version
    return "Erlang $version"
}

Get-ErlangVersion
