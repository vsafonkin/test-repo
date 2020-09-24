# Import-Module -Name SqlServer

SqlLocalDB.exe create "TestLocalDBInstance"
# SqlLocalDB.exe share "TestLocalDBInstance" "TestSharedLocalDBInstance"
SqlLocalDB.exe start "TestLocalDBInstance"  
SqlLocalDB.exe info "TestLocalDBInstance"

sqlcmd -S "(localdb)\TestLocalDBInstance" -Q "SELECT GETDATE() AS TimeOfQuery"
sqlcmd -S "(localdb)\TestLocalDBInstance" -Q "CREATE DATABASE testDatabase"

$createTestTableQuery = @"
CREATE TABLE testTable (
    visit_id INT PRIMARY KEY IDENTITY (1, 1),
    first_name VARCHAR (50) NOT NULL,
    last_name VARCHAR (50) NOT NULL,
    visited_at DATETIME,
    phone VARCHAR(20),
    store_id INT NOT NULL,
    FOREIGN KEY (store_id) REFERENCES sales.stores (store_id)
);
"@
sqlcmd -S "(localdb)\TestLocalDBInstance" -d "testDatabase" -Q $createTestTableQuery
