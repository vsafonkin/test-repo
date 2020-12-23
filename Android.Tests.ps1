Import-Module "$PSScriptRoot/Common.Helpers.psm1"

Describe "NVM" {
    BeforeAll {
        $nvmPath = Join-Path $env:HOME ".nvm" "nvm.sh"
        $nvmInitCommand = ". $nvmPath > /dev/null 2>&1 || true"
    }

    It "Nvm is installed" {
        $nvmPath | Should -Exist
        "$nvmInitCommand && nvm --version" | Should -ReturnZeroExitCode
    }

    Context "Nvm versions" {
        $NVM_VERSIONS = @(6, 8, 10, 12)
        $testCases = $NVM_VERSIONS | ForEach-Object { @{NvmVersion = $_} }

        It "<NvmVersion>" -TestCases $testCases {
            param (
                [string] $NvmVersion
            )

            "$nvmInitCommand && nvm ls $($NvmVersion)" | Should -ReturnZeroExitCode
        }
    }
}
