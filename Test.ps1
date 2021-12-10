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

Get-GccVersion
