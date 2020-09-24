# Import-Module -Name SqlServer

SqlLocalDB.exe create "TestLocalDBInstance"
# SqlLocalDB.exe share "TestLocalDBInstance" "TestSharedLocalDBInstance"
SqlLocalDB.exe start "TestLocalDBInstance"  
SqlLocalDB.exe info "TestLocalDBInstance"

sqlcmd -S "(localdb)\TestLocalDBInstance" -Q "SELECT GETDATE() AS TimeOfQuery"
sqlcmd -S "(localdb)\TestLocalDBInstance" -Q "CREATE DATABASE testDatabase"

$createTestTableQuery = @"
CREATE TABLE testTable (
    person_id INT PRIMARY KEY IDENTITY (1, 1),
    first_name VARCHAR (50) NOT NULL,
    last_name VARCHAR (50) NOT NULL,
    birthday DATETIME,
    phone VARCHAR(20)
);
"@

$selectAllQuery = @"
SELECT *  
FROM testTable  
ORDER BY last_name;
"@

sqlcmd -S "(localdb)\TestLocalDBInstance" -d "testDatabase" -Q $selectAllQuery
