Import-Module "$PSScriptRoot/Common.Helpers.psm1"

# Describe "Android" {
#     $androidSdkManagerPackages = Get-AndroidPackages
#     [int]$platformMinVersion = Get-ToolsetValue "android.platform_min_version"
#     [version]$buildToolsMinVersion = Get-ToolsetValue "android.build_tools_min_version"
    
#     $platforms = (($androidSdkManagerPackages | Where-Object { "$_".StartsWith("platforms;") }) -replace 'platforms;', '' |
#     Where-Object { [int]$_.Split("-")[1] -ge $platformMinVersion } | Sort-Object { [int]$_.Split("-")[1] } -Unique |
#     ForEach-Object { "platforms/${_}" })

#     $buildTools = (($androidSdkManagerPackages | Where-Object { "$_".StartsWith("build-tools;") }) -replace 'build-tools;', '' |
#     Where-Object { [version]$_ -ge $buildToolsMinVersion } | Sort-Object { [version]$_ } -Unique |
#     ForEach-Object { "build-tools/${_}" })

#     $androidPackages = @(
#         $platforms,
#         $buildTools,
#         (Get-ToolsetValue "android.extra_list" | ForEach-Object { "extras/${_}" }),
#         (Get-ToolsetValue "android.addon_list" | ForEach-Object { "add-ons/${_}" }),
#         (Get-ToolsetValue "android.additional_tools" | ForEach-Object { "${_}" })
#     ) | ForEach-Object { $_ }
    
#     BeforeAll {
#         $ANDROID_SDK_DIR = "/usr/local/lib/android/sdk"

#         function Validate-AndroidPackage {
#             param (
#                 [Parameter(Mandatory=$true)]
#                 [string]$PackageName
#             )

#             # Convert 'm2repository;com;android;support;constraint;constraint-layout-solver;1.0.0-beta1' ->
#             #         'm2repository/com/android/support/constraint/constraint-layout-solver/1.0.0-beta1'
#             $PackageName = $PackageName.Replace(";", "/")
#             $targetPath = Join-Path $ANDROID_SDK_DIR $PackageName
#             $targetPath | Should -Exist
#         }
#     }
    

#     Context "Packages" {
#         $testCases = $androidPackages | ForEach-Object { @{ PackageName = $_ } }

#         It "<PackageName>" -TestCases $testCases {
#             param ([string] $PackageName)
#             Write-Host "Package name: $PackageName"
#             Validate-AndroidPackage $PackageName
#         }
#     }

#     It "HAXM is installed" {
#         $haxmPath = Join-Path $ANDROID_SDK_DIR "extras" "intel" "Hardware_Accelerated_Execution_Manager" "silent_install.sh"
#         "$haxmPath -v" | Should -ReturnZeroExitCode
#     }
# }

Describe "Haskell" {

    $GHCCommonPath = "/opt/ghc"
    $GHCVersions = Get-ChildItem -Path $GHCCommonPath | Where-Object { $_.Name -match "\d+\.\d+" }
    Write-Host $GHCVersions.Count
    
    $testCases = $GHCVersions | ForEach-Object { @{ GHCPath = "${_}/bin/ghc"} }
    
    It "Installed GHC versions count" {
        $GHCVersions.Count | Should -Be 3
    }
    
    It "GHC version <GHCPath>" -TestCases $testCases {
            param ([string] $GHCPATH)
            "$GHCPATH --version" | Should -ReturnZeroExitCode
    }
    
    It "Default GHC" {
        "ghc --version" | Should -ReturnZeroExitCode
    }

    It "Cabal" {
        "cabal --version" | Should -ReturnZeroExitCode
    }

    It "Stack" {
        "stack --version" | Should -ReturnZeroExitCode
    }
}
