-----creating a view to check store perfomance
CREATE VIEW vw_StorePerformance AS

SELECT DISTINCT
SUM(a.TotalAmount)AS TotalSold,
b.StoreID,
b.StoreName,
c.[MonthName],
c.FullDate,
c.[DayName],
b.Province
FROM [dbo].[FactSales] AS a
INNER JOIN [RetailDataWarehouse].[dbo].[DimStore] AS b
ON a.StoreKey = b.StoreKey
INNER JOIN[RetailDataWarehouse].[dbo].[DimDate] AS c
ON a.DateKey=c.DateKey
GROUP BY b.StoreID,
b.StoreName,
c.[MonthName],
c.FullDate,
c.[DayName],
b.Province

SELECT * FROM vw_StorePerformance