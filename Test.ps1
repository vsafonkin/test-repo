Set-Location "C:\Program Files\Microsoft SQL Server\130\Tools\Binn"
SqlLocalDB.exe create "TestLocalDBInstance" 
SqlLocalDB.exe start "TestLocalDBInstance"  
SqlLocalDB.exe info "TestLocalDBInstance"

Set-Location "C:\Users\runneradmin\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances"
Get-SqlDatabase -Name "TestLocalDBInstance"
