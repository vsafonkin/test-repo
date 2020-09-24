Import-Module -Name SqlServer

# $url = "https://go.microsoft.com/fwlink/?linkid=866662"
# (New-Object System.Net.WebClient).DownloadFile($url, "sqlserverdev.exe")
# Start-Process -FilePath "sqlserverdev.exe" -Wait -PassThru
# Get-ChildItem "C:\Program Files\Microsoft SQL Server\150"

# Set-Location "C:\Program Files\Microsoft SQL Server\130\Tools\Binn"

SqlLocalDB.exe create "TestLocalDBInstance"
SqlLocalDB.exe share "TestLocalDBInstance" "TestSharedLocalDBInstance"
SqlLocalDB.exe start "TestLocalDBInstance"  
SqlLocalDB.exe info "TestLocalDBInstance"

sqlcmd -S "(localdb)\TestLocalDBInstance" -Q "SELECT GETDATE() AS TimeOfQuery"
# SqlLocalDB.exe start
# SqlLocalDB.exe info MSSQLLocalDB

# Get-SqlInstance -Credential -MachineName "fv-az153"
# Invoke-Sqlcmd -Query "SELECT GETDATE() AS TimeOfQuery" -ServerInstance "fv-az153\MSSQLLocalDB"
# Set-Location "SQLSERVER:\SQL\fv-az153"

# sqlcmd -S (localdb)\.\TestSharedLocalDBInstance
# Invoke-Sqlcmd -Query "SELECT GETDATE() AS TimeOfQuery" -ServerInstance "TestSharedLocalDBInstance"

# Set-Location "C:\Users\runneradmin\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\TestLocalDBInstance"
# Invoke-Sqlcmd -Query "SELECT GETDATE() AS TimeOfQuery" -ServerInstance "TestLocalDBInstance"
# Get-SqlDatabase -Name "TestLocalDBInstance"
