# (Get-Command sqlcmd).Source
Get-ChildItem "C:\Program Files\Microsoft SQL Server"

SqlLocalDB.exe create "TestLocalDBInstance"
SqlLocalDB.exe start "TestLocalDBInstance"  
SqlLocalDB.exe info "TestLocalDBInstance"

sqlcmd -S "(localdb)\TestLocalDBInstance" -Q "SELECT GETDATE() AS TimeOfQuery"
sqlcmd -S "(localdb)\TestLocalDBInstance" -Q "SELECT @@SERVERNAME AS ServerName"
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

$getAllUserTablesQuery = @"
SELECT
  *
FROM
  SYSOBJECTS
WHERE
  xtype = 'U';
GO
"@

sqlcmd -S "(localdb)\TestLocalDBInstance" -d "testDatabase" -Q $createTestTableQuery
sqlcmd -S "(localdb)\TestLocalDBInstance" -d "testDatabase" -Q $getAllUserTablesQuery

$sqlPackageTool = "C:\Program Files\Microsoft SQL Server\150\DAC\bin\SqlPackage.exe"
& $sqlPackageTool /TargetFile:"C:\testDatabaseSnapshot.dacpac" /Action:Extract /SourceServerName:"(localdb)\TestLocalDBInstance" /SourceDatabaseName:"testDatabase"

