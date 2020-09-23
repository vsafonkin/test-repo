Set-Location "C:\Program Files\Microsoft SQL Server\130\Tools\Binn"
SqlLocalDB.exe create "TestLocalDBInstance"
SqlLocalDB.exe share "TestLocalDBInstance" "TestSharedLocalDBInstance"
SqlLocalDB.exe start "TestLocalDBInstance"  
SqlLocalDB.exe info "TestLocalDBInstance"

Invoke-Sqlcmd -Query "SELECT GETDATE() AS TimeOfQuery" -ServerInstance "np:\\.\pipe\LOCALDB#88D853C0\tsql\query"

# Set-Location "C:\Users\runneradmin\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\TestLocalDBInstance"
# Invoke-Sqlcmd -Query "SELECT GETDATE() AS TimeOfQuery" -ServerInstance "TestLocalDBInstance"
# Get-SqlDatabase -Name "TestLocalDBInstance"
