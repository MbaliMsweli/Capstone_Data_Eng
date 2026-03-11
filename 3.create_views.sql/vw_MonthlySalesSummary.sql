-----creating a view to check Monthly sales Summary
CREATE VIEW  vw_MonthlySalesSummary AS

SELECT DISTINCT
SUM(a.TotalAmount) as TotalSalesPerCashier,
b.[MonthName]
FROM [RetailDataWarehouse].[dbo].[FactSales] AS a
INNER JOIN [RetailDataWarehouse].[dbo].[DimDate] as b
ON a.DateKey = b.DateKey
GROUP BY b.[MonthName]



SELECT * FROM  vw_MonthlySalesSummary
order by [MonthName] desc
