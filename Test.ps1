function Get-sqlcmdVersion {
    $bcpVersion = sqlcmd -? | Take-OutputPart -Part 2 | Take-OutputPart -Part 1 -Delimiter " "
    return "sqlcmd $bcpVersion"
}

Get-sqlcmdVersion
