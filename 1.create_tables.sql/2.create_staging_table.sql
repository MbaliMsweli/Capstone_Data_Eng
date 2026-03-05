USE RetailStaging

IF OBJECT_ID('RetailStaging.dbo.RetailSalesData', 'U') IS NULL
BEGIN
    CREATE TABLE RetailStaging.dbo.RetailSalesData (
        ProductID tinyint,
        Barcode BIGINT ,
        ProductName nvarchar (50),
        Category nvarchar (50),
        StoreID tinyint,
        StoreName nvarchar (50),
        Province nvarchar (50),
        CashierName nvarchar (50),
        SaleDate date,
        Quantity tinyint,
        UnitPrice float,
        ToatalAmount float
    );
END
