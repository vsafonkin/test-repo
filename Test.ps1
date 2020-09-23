Import-Module -Name SqlServer

Set-Location "C:\Program Files\Microsoft SQL Server\130\Tools\Binn"
SqlLocalDB.exe create "TestLocalDBInstance"
SqlLocalDB.exe share "TestLocalDBInstance" "TestSharedLocalDBInstance"
SqlLocalDB.exe start "TestLocalDBInstance"  
SqlLocalDB.exe info "TestLocalDBInstance"

# SqlLocalDB.exe start
# SqlLocalDB.exe info MSSQLLocalDB

Get-PSDrive
Get-SqlInstance -Credential -MachineName "fv-az153"
# Invoke-Sqlcmd -Query "SELECT GETDATE() AS TimeOfQuery" -ServerInstance "fv-az153\MSSQLLocalDB"
Set-Location "SQLSERVER:\SQL\fv-az153"


# sqlcmd -S (localDB)\TestLocalDBInstance
# Invoke-Sqlcmd -Query "SELECT GETDATE() AS TimeOfQuery" -ServerInstance "TestSharedLocalDBInstance"

# Set-Location "C:\Users\runneradmin\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\TestLocalDBInstance"
# Invoke-Sqlcmd -Query "SELECT GETDATE() AS TimeOfQuery" -ServerInstance "TestLocalDBInstance"
# Get-SqlDatabase -Name "TestLocalDBInstance"
