# Import-Module -Name SqlServer

SqlLocalDB.exe create "TestLocalDBInstance"
# SqlLocalDB.exe share "TestLocalDBInstance" "TestSharedLocalDBInstance"
SqlLocalDB.exe start "TestLocalDBInstance"  
SqlLocalDB.exe info "TestLocalDBInstance"

sqlcmd -S "(localdb)\TestLocalDBInstance" -Q "SELECT GETDATE() AS TimeOfQuery"
sqlcmd -S "(localdb)\TestLocalDBInstance" -Q "CREATE DATABASE testDatabase"
sqlcmd -S "(localdb)\TestLocalDBInstance" -d "testDatabase" -Q "CREATE Table testTable"
