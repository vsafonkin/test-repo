#!/bin/bash -e

pwsh -Command "Import-Module './Common.Helpers.psm1' -DisableNameChecking
        Invoke-PesterTests -TestFile \"$1\" -TestName \"$2\""

