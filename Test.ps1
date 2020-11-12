function Get-sqlcmdVersion {
    $bcpVersion = sqlcmd -? | Take-OutputPart -Part 2
    return "sqlcmd $bcpVersion"
}

function Take-OutputPart {
    param (
        [Parameter(ValueFromPipeline)]
        [string] $toolOutput,
        [string] $Delimiter = " ",
        [int[]] $Part
    )
    $parts = $toolOutput.Split($Delimiter, [System.StringSplitOptions]::RemoveEmptyEntries)
    $selectedParts = $parts[$Part]
    return [string]::Join($Delimiter, $selectedParts)
}

Get-sqlcmdVersion
Write-Host "-----"
sqlcmd -?
