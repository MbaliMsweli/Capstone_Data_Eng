-----creating a view to check Cashier Perfomance
CREATE VIEW vw_CashierPerformance AS

SELECT DISTINCT
SUM(a.TotalAmount) as TotalSalesPerCashier,
b.CashierKey,
b.CashierName
FROM [RetailDataWarehouse].[dbo].[FactSales] AS a
INNER JOIN [RetailDataWarehouse].[dbo].[DimCashier] as b
ON a.CashierKey = b.CashierKey
GROUP BY b.CashierKey,
b.CashierName



SELECT * FROM vw_CashierPerformance











