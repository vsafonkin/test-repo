# $gccList = @('9', '10', '11')

function Get-GccVersion {
    $versionList = @('9', '10', '11')
    $versionList | Foreach-Object {
        $version = Run-Command "gcc-${_} --version" | Select-Object -First 1
        "$version - available by ``gcc-${_}`` alias"
    }
}

Get-GccVersion
