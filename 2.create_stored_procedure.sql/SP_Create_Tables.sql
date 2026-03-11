
-----create stored procedure for creating DimCashierTable
CREATE OR ALTER PROCEDURE [dbo].[SP_Create_DimCashierTable] 
AS
BEGIN
SET NOCOUNT ON;

IF OBJECT_ID('[RetailDataWarehouse].dbo.DimCashier', 'U') IS NULL
BEGIN
    CREATE TABLE [RetailDataWarehouse].dbo.DimCashier (
        CashierKey  INT IDENTITY(1,1) PRIMARY KEY,
        CashierName NVARCHAR (Max) NULL,
        LoadDate DATETIME DEFAULT GETDATE(),
        LastRunCheckDate DATETIME NULL
    );
END
END;

EXEC [RetailDataWarehouse].[dbo].[SP_Create_DimCashierTable];

-----create stored procedure for creating and insert data into DimDateTable
CREATE OR ALTER PROCEDURE [dbo].[SP_Create_DimDateTable] 
AS
BEGIN
SET NOCOUNT ON;

/* Step 2: Drop table if it exists */
IF OBJECT_ID('[RetailDataWarehouse].dbo.DimDate', 'U') IS NOT NULL
DROP TABLE [RetailDataWarehouse].dbo.DimDate;


/* Step 3: Create DimDate table */
CREATE TABLE [RetailDataWarehouse].dbo.DimDate
(
    DateKey INT NOT NULL PRIMARY KEY,
    FullDate DATE NOT NULL,
    MonthID INT NOT NULL,
    MonthInYear INT NOT NULL,
    QuarterID INT NOT NULL,
    QuarterInYear INT NOT NULL,
    [Year] INT NOT NULL,
    WeekInYear INT NOT NULL,
    DayInYear INT NOT NULL,
    DayInMonth INT NOT NULL,
    DayInWeek INT NOT NULL,
    IsWeekend BIT NOT NULL,
    IsWorkDay BIT NOT NULL,
    IsPublicHoliday BIT NOT NULL,
    ReportingDateDesc VARCHAR(12) NULL
);


/* Step 4: Insert dates */
DECLARE @StartDate DATE = '2025-01-01';
DECLARE @EndDate DATE   = '2025-12-31';

WHILE @StartDate <= @EndDate
BEGIN

    INSERT INTO dbo.DimDate
    (
        DateKey,
        FullDate,
        MonthID,
        MonthInYear,
        QuarterID,
        QuarterInYear,
        [Year],
        WeekInYear,
        DayInYear,
        DayInMonth,
        DayInWeek,
        IsWeekend,
        IsWorkDay,
        IsPublicHoliday,
        ReportingDateDesc
    )
    SELECT
        CONVERT(INT, FORMAT(@StartDate,'yyyyMMdd')),       
        @StartDate,                                        
        CONVERT(INT, FORMAT(@StartDate,'yyyyMM')),         
        MONTH(@StartDate),                                 
        YEAR(@StartDate)*10 + DATEPART(QUARTER,@StartDate),
        DATEPART(QUARTER,@StartDate),                      
        YEAR(@StartDate),                                  
        DATEPART(WEEK,@StartDate),                         
        DATEPART(DAYOFYEAR,@StartDate),                    
        DAY(@StartDate),                                   
        DATEPART(WEEKDAY,@StartDate),                      
        CASE WHEN DATEPART(WEEKDAY,@StartDate) IN (1,7) THEN 1 ELSE 0 END,
        CASE WHEN DATEPART(WEEKDAY,@StartDate) IN (1,7) THEN 0 ELSE 1 END,
        0,
        FORMAT(@StartDate,'MMM yyyy');

    SET @StartDate = DATEADD(DAY,1,@StartDate);
END
END;



EXEC [RetailDataWarehouse].[dbo].[SP_Create_DimDateTable];

-----create stored procedure for creating DimProductTable
CREATE  OR ALTER PROCEDURE [dbo].[SP_Create_DimProductTable] 
AS
BEGIN
SET NOCOUNT ON;

IF OBJECT_ID('[RetailDataWarehouse].dbo.DimProduct', 'U') IS NULL
BEGIN
    CREATE TABLE [RetailDataWarehouse].dbo.DimProduct (
        ProductKey INT IDENTITY(1,1) PRIMARY KEY,
        ProductID INT NOT NULL,
        Barcode BIGINT NOT NULL,
        ProductName NVARCHAR (Max) NULL,
        Category NVARCHAR (MAX) NULL,
        LoadDate DATETIME DEFAULT GETDATE(),
        LastRunCheckDate DATETIME NULL
    );
END
END;

EXEC [RetailDataWarehouse].[dbo].[SP_Create_DimProductTable];


-----create stored procedure for creating DimProvinceTable
CREATE OR ALTER  PROCEDURE [dbo].[SP_Create_DimProvinceTable] 
AS
BEGIN
SET NOCOUNT ON;

IF OBJECT_ID('[RetailDataWarehouse].dbo.DimProvince','U') IS NULL
BEGIN
    CREATE TABLE [RetailDataWarehouse].dbo.DimProvince (
        ProvinceKey  INT IDENTITY(1,1) PRIMARY KEY,
        Province NVARCHAR (Max) NULL,
        LoadDate DATETIME DEFAULT GETDATE(),
        LastRunCheckDate DATETIME NULL
    );
END
END;

EXEC [RetailDataWarehouse].[dbo].[SP_Create_DimProvinceTable];


-----create stored procedure for creating DimStoreTable
CREATE OR ALTER PROCEDURE [dbo].[SP_Create_DimStoreTable] 
AS
BEGIN
SET NOCOUNT ON;

IF OBJECT_ID('[RetailDataWarehouse].dbo.DimStore', 'U') IS NULL
BEGIN
    CREATE TABLE [RetailDataWarehouse].dbo.DimStore (
      [StoreKey] [int] IDENTITY(1,1) NOT NULL,
[StoreID] [int] NOT NULL,
[StoreName] [nvarchar](MAX) NULL,
[Province] [nvarchar](max) NULL,
[LoadDate] [datetime] NULL,
[LastRunCheckDate] [datetime] NULL
    );
END
END;

EXEC [RetailDataWarehouse].[dbo].[SP_Create_DimStoreTable];


-----create stored procedure for creating FactSalesTable
CREATE OR ALTER PROCEDURE [dbo].[SP_Create_FactSalesTable] 
AS
BEGIN
SET NOCOUNT ON;

IF OBJECT_ID('[RetailDataWarehouse].dbo.FactSales', 'U') IS NULL
BEGIN
    CREATE TABLE [RetailDataWarehouse].dbo.FactSales (
    ProductKey INT NOT NULL,
    StoreKey INT NOT NULL,
    DateKey INT NOT NULL,
    CashierKey INT NOT NULL,
    ProvinceKey INT NOT NULL,
    Quantity INT NULL,
    UnitPrice DECIMAL(18,2) NULL,
    TotalAmount DECIMAL(18,2) NULL,
    LoadDate DATETIME DEFAULT GETDATE(),
    LastRunCheckDate DATETIME NULL
    );
END
END;

EXEC [RetailDataWarehouse].[dbo].[SP_Create_FactSalesTable];