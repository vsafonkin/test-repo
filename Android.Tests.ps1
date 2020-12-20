Import-Module "$PSScriptRoot/Common.Helpers.psm1"

Write-Host (Get-ChildItem "/usr/local/lib/android/sdk/cmake")

Describe "Android" {
    $androidSdkManagerPackages = Get-AndroidPackages
    [int]$platformMinVersion = Get-ToolsetValue "android.platform_min_version"
    Write-Host "min version: $platformMinVersion"
    [version]$buildToolsMinVersion = Get-ToolsetValue "android.build_tools_min_version"
    
    $platforms = (($androidSdkManagerPackages | Where-Object { "$_".StartsWith("platforms;") }) -replace 'platforms;', '' |
    Where-Object { [int]$_.Split("-")[1] -ge $platformMinVersion } | Sort-Object { [int]$_.Split("-")[1] } -Unique |
    ForEach-Object { "platforms/${_}" })

    $buildTools = (($androidSdkManagerPackages | Where-Object { "$_".StartsWith("build-tools;") }) -replace 'build-tools;', '' |
    Where-Object { [version]$_ -ge $buildToolsMinVersion } | Sort-Object { [version]$_ } -Unique |
    ForEach-Object { "build-tools/${_}" })

    $androidPackages = @(
        $platforms,
        $buildTools,
        "tools",
        "platform-tools",
        "ndk-bundle",
        "cmake",
        (Get-ToolsetValue "android.extra_list" | ForEach-Object { "extras/${_}" }),
        (Get-ToolsetValue "android.addon_list" | ForEach-Object { "add-ons/${_}" })
    ) | ForEach-Object { $_ }
    
    BeforeAll {
        $ANDROID_SDK_DIR = "/usr/local/lib/android/sdk"

        function Validate-AndroidPackage {
            param (
                [Parameter(Mandatory=$true)]
                [string]$PackageName
            )

            # Convert 'm2repository;com;android;support;constraint;constraint-layout-solver;1.0.0-beta1' ->
            #         'm2repository/com/android/support/constraint/constraint-layout-solver/1.0.0-beta1'
            $PackageName = $PackageName.Replace(";", "/")
            $targetPath = Join-Path $ANDROID_SDK_DIR $PackageName
            $targetPath | Should -Exist
        }
    }
    

    Context "Packages" {
        $testCases = $androidPackages | ForEach-Object { @{ PackageName = $_ } }

        It "<PackageName>" -TestCases $testCases {
            param ([string] $PackageName)
            Write-Host "Package name: $PackageName"
            Validate-AndroidPackage $PackageName
        }
    }

#     It "HAXM is installed" {
#         $haxmPath = Join-Path $ANDROID_SDK_DIR "extras" "intel" "Hardware_Accelerated_Execution_Manager" "silent_install.sh"
#         "$haxmPath -v" | Should -ReturnZeroExitCode
#     }
}
