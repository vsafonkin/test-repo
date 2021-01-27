function Get-AndroidPackages {
    Param
    (
        [Parameter(Mandatory=$true)]
        [string]$AndroidSDKManagerPath
    )

    return (& $AndroidSDKManagerPath --list --verbose).Trim() | Foreach-Object { $_.Split()[0] } | Where-Object {$_}
}

function Get-AndroidPackagesByName {
    Param (
        [Parameter(Mandatory=$true)]
        [string[]]$AndroidPackages,
        [Parameter(Mandatory=$true)]
        [string]$PrefixPackageName
    )

    return $AndroidPackages | Where-Object { "$_".StartsWith($PrefixPackageName) }
}

function Get-AndroidPackagesByVersion {
    Param (
        [Parameter(Mandatory=$true)]
        [string[]]$AndroidPackages,
        [Parameter(Mandatory=$true)]
        [string]$PrefixPackageName,
        [object]$MinimumVersion,
        [char]$Delimiter,
        [int]$Index = 0
    )

    $Type = $MinimumVersion.GetType()
    $packagesByName = Get-AndroidPackagesByName -AndroidPackages $AndroidPackages -PrefixPackageName $PrefixPackageName
    $packagesByVersion = $packagesByName | Where-Object { ($_.Split($Delimiter)[$Index] -as $Type) -ge $MinimumVersion }
    return $packagesByVersion | Sort-Object { $_.Split($Delimiter)[$Index] -as $Type} -Unique
}

$ndkLTSVersion = "21"
$ndkLatestVersion = "22"

$sdkManager = "$env:ANDROID_SDK_ROOT\tools\bin\sdkmanager.bat"
$androidPackages = Get-AndroidPackages -AndroidSDKManagerPath $sdkManager

$ndkLTSFullVersion = Get-AndroidPackagesByName -AndroidPackages $androidPackages `
                -PrefixPackageName "ndk;" `
                | Where { $_ -Match "ndk;$ndkLTSVersion.*" } `
                | Sort-Object -Unique `
                | Select-Object -Last 1
                
$ndkLTSFullVersion 

$ndkLatestFullVersion = Get-AndroidPackagesByName -AndroidPackages $androidPackages `
                -PrefixPackageName "ndk;" `
                | Where { $_ -Match "ndk;$ndkLatestVersion.*" } `
                | Sort-Object -Unique `
                | Select-Object -Last 1
                
Write-Host "----"
$ndkLatestFullVersion

$ndkLatestPath = "$sdkRoot\ndk\$($ndkLatestFullVersion.Split(";")[1])"
$ndkLatestPath
