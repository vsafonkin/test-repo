function Get-JavaVersions {
    param(
        [string] $DefaultVersion
    )

    $postfix = ""
    $javaDir = "/usr/lib/jvm"
    return Get-ChildItem $javaDir | ForEach-Object {
        Write-Host $_
        $javaBinPath = Join-Path $_ "bin"
        $rawVersion = Invoke-Expression "$javaBinPath/java -version 2>&1" | Out-String
        $rawVersion -match 'openjdk version "(?<version>.+)"' | Out-Null
        $version = $Matches.Version
        if ($version -match $DefaultVersion) {
            $postfix = "(default)"
        } else {
            $postfix = ""
        }
        return "Java $version $postfix"
    } | Sort-Object {
        $version = ($_.Split(" ")[1]).Split("_")[0]
        return [System.Version]$version
    }
}


Write-Host "-----"
& java -version
