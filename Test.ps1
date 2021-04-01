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

function Get-AptSourceRepository {
    param([String] $PackageName)

    return &(apt show $PackageName) | Select-String -Pattern "APT-Sources" | Take-OutputPart -Part 1

}

Get-AptSourceRepository -PackageName 'postgresql'
