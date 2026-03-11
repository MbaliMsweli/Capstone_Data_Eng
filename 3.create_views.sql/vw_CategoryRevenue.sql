-----creating a view to check store perfomance
CREATE VIEW vw_CategoryRevenue AS

SELECT DISTINCT
SUM(a.TotalAmount)AS TotalSold,
b.ProductName,
b.Category,
c.[DayName],
c.[MonthName],
c.FullDate
FROM [dbo].[FactSales] AS a
INNER JOIN [RetailDataWarehouse].[dbo].[DimProduct] AS b
ON a.ProductKey = b.ProductKey
INNER JOIN[RetailDataWarehouse].[dbo].[DimDate] AS c
ON a.DateKey=c.DateKey
GROUP BY b.ProductName,
b.Category,
c.[DayName],
c.[MonthName],
c.FullDate




SELECT * FROM vw_CategoryRevenue