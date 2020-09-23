Set-Location "C:\Program Files\Microsoft SQL Server\130\Tools\Binn"
SqlLocalDB.exe create "TestLocalDBInstance" 
SqlLocalDB.exe start "TestLocalDBInstance"  
SqlLocalDB.exe info "TestLocalDBInstance"

Get-SqlDatabase -Name "TestLocalDBInstance"
