Set-Location "C:\Program Files\Microsoft SQL Server\130\Tools\Binn"
# SqlLocalDB.exe create "TestLocalDBInstance"
# SqlLocalDB.exe share "TestLocalDBInstance" "TestSharedLocalDBInstance"
# SqlLocalDB.exe start "TestLocalDBInstance"  
# SqlLocalDB.exe info "TestLocalDBInstance"

SqllocalDB.exe info MSSQLLocalDB

# Invoke-Sqlcmd -Query "SELECT GETDATE() AS TimeOfQuery" -ServerInstance "TestSharedLocalDBInstance"

# Set-Location "C:\Users\runneradmin\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\TestLocalDBInstance"
# Invoke-Sqlcmd -Query "SELECT GETDATE() AS TimeOfQuery" -ServerInstance "TestLocalDBInstance"
# Get-SqlDatabase -Name "TestLocalDBInstance"
