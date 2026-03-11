-----creating a view to check Province Revenue
CREATE VIEW vw_ProvinceRevenue AS

SELECT DISTINCT
SUM(a.TotalAmount) as TotalSalesPerCashier,
b.Province
FROM [RetailDataWarehouse].[dbo].[FactSales] AS a
INNER JOIN [RetailDataWarehouse].[dbo].[DimProvince] as b
ON a.ProvinceKey = b.ProvinceKey
GROUP BY b.Province



SELECT * FROM vw_ProvinceRevenue