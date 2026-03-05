USE [RetailDataWarehouse]

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


USE [RetailDataWarehouse]

IF OBJECT_ID('[RetailDataWarehouse].dbo.DimStore', 'U') IS NULL
BEGIN
    CREATE TABLE [RetailDataWarehouse].dbo.DimStore (
        StoreKey INT IDENTITY(1,1) PRIMARY KEY,
        StoreID INT NOT NULL,
        StoreName BIGINT NOT NULL,
        Province NVARCHAR (Max) NULL,
        LoadDate DATETIME DEFAULT GETDATE(),
        LastRunCheckDate DATETIME NULL
    );
END


USE [RetailDataWarehouse]

IF OBJECT_ID('[RetailDataWarehouse].dbo.DimCashier', 'U') IS NULL
BEGIN
    CREATE TABLE [RetailDataWarehouse].dbo.DimCashier (
        CashierKey  INT IDENTITY(1,1) PRIMARY KEY,
        CashierName NVARCHAR (Max) NULL,
        LoadDate DATETIME DEFAULT GETDATE(),
        LastRunCheckDate DATETIME NULL
    );
END

USE [RetailDataWarehouse]

IF OBJECT_ID('[RetailDataWarehouse].dbo.DimProvince','U') IS NULL
BEGIN
    CREATE TABLE [RetailDataWarehouse].dbo.DimProvince (
        ProvinceKey  INT IDENTITY(1,1) PRIMARY KEY,
        Province NVARCHAR (Max) NULL,
        LoadDate DATETIME DEFAULT GETDATE(),
        LastRunCheckDate DATETIME NULL
    );
END



