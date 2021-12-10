# $gccList = @('9', '10', '11')

function Run-Command {
    param (
        [Parameter(Mandatory=$true)]
        [string] $Command,
        [switch] $SuppressStderr
    )
    # Bash trick to suppress and show error output because some commands write to stderr (for example, "python --version")
    $redirectOutputArguments = If ($SuppressStderr) { "2> /dev/null" } Else { "2>&1" }
    $stdout = & bash -c "${Command} ${redirectOutputArguments}"

    return $stdout
}

function Get-GccVersion {
    $versionList = @('9', '10', '11')
    $versionList | Foreach-Object {
        $version = Run-Command "gcc-${_} --version" | Select-Object -First 1
        "$version - available by ``gcc-${_}`` alias"
    }
}

function Get-FortranVersion {
    $versionList = @('9', '10', '11')
    $versionList | Foreach-Object {
        $version = Run-Command "gfortran-${_} --version" | Select-Object -First 1
        "$version - available by ``gfortran-${_}`` alias"
    }
}

$markdown = ""
$markdown += New-MDHeader "Installed Software" -Level 2
$markdown += New-MDHeader "Language and Runtime" -Level 3

# $languageAndRuntimeList = @()

$languageAndRuntimeList = @(
#     (Get-GccVersion),
#     (Get-FortranVersion),
    "start",
    @("test", "report")
)

$hello = @("hello", "world")
Write-Host $hello.GetType()
$gcc = Get-GccVersion
Write-Host $gcc.GetType()

$test = @(
        (Get-GccVersion),
        (Get-FortranVersion)
   )
Write-Host $test.Length

# $languageAndRuntimeList += @(
#     $hello
# )

$languageAndRuntimeList += $test

$toNatural = { [regex]::Replace($_, '\d+', { $args[0].Value.PadLeft(20) }) }
$markdown += New-MDList -Style Unordered -Lines ($languageAndRuntimeList | Sort-Object $toNatural)
$markdown | Out-File -FilePath "./testreport.md" -Encoding UTF8NoBOM
