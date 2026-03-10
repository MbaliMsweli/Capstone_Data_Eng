----STORED PROCEDURE FOR INSERTING DATA INTO DimCashierTable

CREATE   PROCEDURE [dbo].[SP_InsertInto_DimCashierTable] 
AS
BEGIN
SET NOCOUNT ON;
 -----Inserting data in DimCashier Table----
INSERT INTO [RetailDataWarehouse].[dbo].[DimCashier] ( 
        CashierName,
        LoadDate  
)
SELECT DISTINCT
   CAST(S.CashierName AS NVARCHAR), 
   GETDATE()
    
FROM
   [RetailStaging].[dbo].[RetailSalesData] AS S
WHERE NOT EXISTS (
    SELECT 1
    FROM [RetailDataWarehouse].[dbo].[DimCashier]AS D
    WHERE S.CashierName = D.CashierName
);
END
GO

----STORED PROCEDURE FOR INSERTING DATA INTO DimProductTable
CREATE   PROCEDURE [dbo].[SP_InsertInto_DimProductTable] 
AS
BEGIN
SET NOCOUNT ON;
-----Inserting data in DimProduct Table----
INSERT INTO [RetailDataWarehouse].[dbo].[DimProduct] ( 
        ProductID,
        Barcode ,
        ProductName ,
        Category ,
        LoadDate  
)
SELECT DISTINCT
   CAST(S.ProductID AS INT ), 
   CAST(S.Barcode AS BIGINT),
   CAST(S.ProductName AS NVARCHAR), 
   CAST(S.Category AS NVARCHAR) ,
   GETDATE()
    
FROM
   [RetailStaging].[dbo].[RetailSalesData] AS S
WHERE NOT EXISTS (
    SELECT 1
    FROM [RetailDataWarehouse].[dbo].[DimProduct] AS D
    WHERE S.ProductID = D.ProductID
);
END


----STORED PROCEDURE FOR INSERTING DATA INTO DimProvinceTable
CREATE   PROCEDURE [dbo].[SP_InsertInto_DimProvinceTable] 
AS

BEGIN
SET NOCOUNT ON;
 -----Inserting data in DimProvince Table----
INSERT INTO [RetailDataWarehouse].[dbo].[DimProvince] ( 
        Province,
        LoadDate  
)
SELECT DISTINCT
   CAST(S.Province AS NVARCHAR), 
   GETDATE()
    
FROM
   [RetailStaging].[dbo].[RetailSalesData] AS S
WHERE NOT EXISTS (
    SELECT 1
    FROM [RetailDataWarehouse].[dbo].[DimProvince]AS D
    WHERE S.Province = D.Province
);
END
GO

----STORED PROCEDURE FOR INSERTING DATA INTO DimStoreTable

CREATE   PROCEDURE [dbo].[SP_InsertInto_DimStoreTable] 
AS
BEGIN
SET NOCOUNT ON;
 -----Inserting data in DimStore Table----
INSERT INTO [RetailDataWarehouse].[dbo].[DimStore] ( 
        StoreID,
        StoreName,
        Province ,
        LoadDate  
)
SELECT DISTINCT
   CAST(S.StoreID AS INT), 
   CAST(S.StoreName AS NVARCHAR), 
   CAST(S.Province AS NVARCHAR), 
   GETDATE()
    
FROM
   [RetailStaging].[dbo].[RetailSalesData] AS S
WHERE NOT EXISTS (
    SELECT 1
    FROM [RetailDataWarehouse].[dbo].[DimStore]AS D
    WHERE S.StoreID= D.StoreID
);

GO  



CREATE   PROCEDURE [dbo].[SP_InsertInto_DimStoreTable] 
AS
BEGIN
SET NOCOUNT ON;
 -----Inserting data in FactTable----
INSERT INTO [RetailDataWarehouse].dbo.FactSales
(
    ProductKey,
    [StoreKey],
    [DateKey],
    CashierKey,
    ProvinceKey,
    Quantity,
    UnitPrice,
    TotalAmount
)
SELECT
    dp.ProductKey,
    ds.StoreKey,
    dd.DateKey,
    dc.CashierKey,
    dpr.ProvinceKey,
    CAST(s.Quantity AS INT),
    CAST(s.UnitPrice AS DECIMAL(18,2)),
    CAST(s.TotalAmount AS DECIMAL(18,2))
FROM [RetailStaging].[dbo].[RetailSalesData] AS s
JOIN [RetailDataWarehouse].dbo.DimProduct AS dp
    ON dp.ProductName = s.ProductName
JOIN [RetailDataWarehouse].dbo.DimCashier AS dc
    ON dc.CashierName = s.CashierName
JOIN [RetailDataWarehouse].dbo.DimProvince AS dpr
    ON dpr.Province = s.Province
JOIN [RetailDataWarehouse].[dbo].[DimStore] AS ds
    ON s.StoreID = ds.StoreID
JOIN [RetailDataWarehouse].dbo.DimDate AS dd
    ON dd.FullDate = s.SaleDate
WHERE NOT EXISTS
(
    SELECT 1
    FROM [RetailDataWarehouse].dbo.FactSales AS f
    WHERE f.ProductKey = dp.ProductKey
      AND f.CashierKey = dc.CashierKey
      AND f.ProvinceKey = dpr.ProvinceKey
      AND f.StoreKey = ds.StoreKey
      AND f.DateKey = dd.DateKey
      AND f.Quantity = CAST(s.Quantity AS INT)
      AND f.UnitPrice = CAST(s.UnitPrice AS DECIMAL(18,2))
      AND f.TotalAmount = CAST(s.TotalAmount AS DECIMAL(18,2))
);
END