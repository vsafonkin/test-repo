function Get-VisualStudioInstance {
    # Use -Prerelease and -All flags to make sure that Preview versions of VS are found correctly
    $vsInstance = Get-VSSetupInstance -Prerelease -All | Where-Object { $_.DisplayName -match "Visual Studio" } | Select-Object -First 1
    $vsInstance | Select-VSSetupInstance -Product *
}

function Get-VisualStudioComponents {
    (Get-VisualStudioInstance).Packages | Where-Object type -in 'Component', 'Workload' |
    Sort-Object Id, Version | Select-Object @{n = 'Package'; e = {$_.Id}}, Version |
    Where-Object { $_.Package -notmatch "[0-9a-fA-F]{8}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{12}" }
}

Write-Host "Starting Install ..."
$bootstrapperFilePath = ''
$bootstrapperArgumentList = ('/c', $bootstrapperFilePath, $WorkLoads, '--quiet', '--norestart', '--wait', '--nocache' )
$process = Start-Process -FilePath cmd.exe -ArgumentList $bootstrapperArgumentList -Wait -PassThru

$exitCode = $process.ExitCode
if ($exitCode -eq 0 -or $exitCode -eq 3010)
{
    Write-Host "Installation successful"
}
else
{
    Write-Host "Installation failed"
}            

Get-VisualStudioComponents
