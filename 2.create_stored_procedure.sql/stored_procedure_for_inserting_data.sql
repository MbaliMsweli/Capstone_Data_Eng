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
END;

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
END;

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
END;

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
   CAST(S.StoreID AS BIGINT), 
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
END;