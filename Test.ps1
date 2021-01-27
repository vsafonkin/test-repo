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

$sdkManager = "$env:ANDROID_SDK_ROOT\tools\bin\sdkmanager.bat"
$androidPackages = Get-AndroidPackages -AndroidSDKManagerPath $sdkManager

$ndkList = Get-AndroidPackagesByName -AndroidPackages $androidPackages `
                -PrefixPackageName "ndk;" `
                
$ndkList | Where { ($_.Split(";")[1]).Split(".")[0] -Match $ndkLTSVersion }
