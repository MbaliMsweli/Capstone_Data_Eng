USE [RetailDataWarehouse]

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
   

