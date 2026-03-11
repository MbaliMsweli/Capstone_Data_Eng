--1. Which store generated the highest total revenue?
SELECT TOP 1 StoreID,
StoreName,
SUM(TotalAmount) AS TotalSales
FROM [RetailDataWarehouse].[dbo].[FactSales] AS a
INNER JOIN [dbo].[DimStore] AS b
ON a.StoreKey = b.StoreKey
GROUP BY StoreID,
StoreName


--2. Which province performs best overall?
SELECT TOP 1 Province,
SUM(TotalAmount) AS TotalSales
FROM [RetailDataWarehouse].[dbo].[FactSales] AS a
INNER JOIN [dbo].[DimProvince] AS b
ON a.ProvinceKey = b.ProvinceKey
GROUP BY Province


--3. Which product category contributes the highest revenue?
SELECT TOP 1 b.Category ,
SUM(a.TotalAmount) AS TotalSales
FROM [RetailDataWarehouse].[dbo].[FactSales] AS a
INNER JOIN [dbo].[DimProduct] AS b
ON a.ProductKey = b.ProductKey
GROUP BY b.Category


--4. Who is the top-performing cashier?
SELECT TOP 1 CashierName,
SUM(TotalAmount) AS TotalSales
FROM [RetailDataWarehouse].[dbo].[FactSales] AS a
INNER JOIN [dbo].[DimCashier] AS b
ON a.CashierKey = b.CashierKey
GROUP BY CashierName

--5. What is the average daily revenue?
SELECT AVG(a.TotalAmount) AS AVGDailyRevenue,
b.DayInYear,
b.[MonthName]
FROM [RetailDataWarehouse].[dbo].[FactSales] AS a
INNER JOIN [dbo].[DimDate] AS b
ON a.DateKey = b.DateKey
GROUP BY b.DayInYear,
b.[MonthName]
ORDER BY AVGDailyRevenue DESC

--6. Which month had the highest sales?
SELECT TOP 1 b.[MonthName],
SUM(a.TotalAmount) AS TotalSales
FROM [RetailDataWarehouse].[dbo].[FactSales] AS a
INNER JOIN[dbo].[DimDate]  AS b
ON a.DateKey = b.DateKey
GROUP BY b.[MonthName]