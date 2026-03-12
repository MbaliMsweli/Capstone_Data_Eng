
---This allows Store Manager to:SELECT,INSERT,UPDATE, DELETE and run procedures (ETL / SSIS jobs
use [RetailDataWarehouse]

ALTER ROLE db_datareader ADD MEMBER StoreManager;
ALTER ROLE db_datawriter ADD MEMBER StoreManager;
GRANT EXECUTE TO StoreManager;

---This allows DataAnalyst to: Read tables and Create reporting views
use [RetailDataWarehouse]

ALTER ROLE db_datareader ADD MEMBER DataAnalyst;
GRANT CREATE VIEW TO DataAnalyst;


--CashierUser should only read reporting views so We will:
--Create a Reporting schema
--Move views into that schema
--Give CashierUser permission to read that schema only

--A schema is like a folder inside the database.
CREATE SCHEMA Reporting;

---Move Views into the Reporting Folder
USE [RetailDataWarehouse]
ALTER SCHEMA Reporting TRANSFER [dbo].[vw_CashierPerformance];
ALTER SCHEMA Reporting TRANSFER [dbo].[vw_CategoryRevenue];
ALTER SCHEMA Reporting TRANSFER [dbo].[vw_DailySales];
ALTER SCHEMA Reporting TRANSFER [dbo].[vw_MonthlySalesSummary];
ALTER SCHEMA Reporting TRANSFER [dbo].[vw_ProvinceRevenue];
ALTER SCHEMA Reporting TRANSFER [dbo].[vw_StorePerformance];
ALTER SCHEMA Reporting TRANSFER [dbo].[vw_Top10Products];

--Give CashierUser Access to All Views at Once
USE [RetailDataWarehouse]
GRANT SELECT ON SCHEMA::Reporting TO CashierUser;

--Block Access to Real Tables
USE [RetailDataWarehouse]
DENY SELECT ON SCHEMA::dbo TO CashierUser;

---Check If the User Exists
SELECT name 
FROM sys.database_principals
WHERE type_desc = 'SQL_USER';

---Test CashierUser
USE RetailDataWarehouse;
EXECUTE AS USER = 'CashierUser';
SELECT * FROM Reporting.vw_DailySales;

---Test DataAnalystUser
USE RetailDataWarehouse;
EXECUTE AS USER = 'DataAnalyst';
SELECT * FROM dbo.FactSales;

---Test StoreManagerUser
use [RetailDataWarehouse]
EXECUTE AS USER = 'StoreManager';
SELECT TOP 5 * FROM dbo.FactSales;

---Return to Admin to be able to access everything
REVERT;