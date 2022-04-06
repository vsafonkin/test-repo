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
Set-Location "C:\Program Files (x86)\Microsoft Visual Studio\Installer\"
$InstallPath = "C:\Program Files\Microsoft Visual Studio\2022\Enterprise"
$componentsToAdd = @(
  "Microsoft.VisualStudio.Component.VC.v143.ATL"
  "Microsoft.VisualStudio.Component.VC.v143.ATL.Spectre"
  "Microsoft.VisualStudio.Component.VC.v143.MFC"
  "Microsoft.VisualStudio.Component.VC.v143.MFC.Spectre"
)
[string]$workloadArgs = $componentsToAdd | ForEach-Object {" --add " +  $_}
$Arguments = ('/c', "vs_installer.exe", 'modify', '--installPath', "`"$InstallPath`"",$workloadArgs, '--norestart', '--nocache')
$process = Start-Process -FilePath cmd.exe -ArgumentList $Arguments -Wait -PassThru -WindowStyle Hidden
if ($process.ExitCode -eq 0)
{
    Write-Host "components have been successfully added"
}
else
{
    Write-Host "components were not installed"
    exit 1
}           

Get-VisualStudioComponents
