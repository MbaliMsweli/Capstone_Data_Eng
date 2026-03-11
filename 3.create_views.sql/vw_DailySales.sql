
-----creating a view to check daily sales
CREATE VIEW vw_DailySales AS

SELECT DISTINCT
SUM(a.TotalAmount)AS TotalADay,
b.DayInMonth,
b.[MonthName],
b.[DayName],
b.FullDate
FROM [dbo].[FactSales] AS a
INNER JOIN [dbo].[DimDate] AS b
ON a.DateKey = b.DateKey
GROUP BY b.DayInMonth,
b.[MonthName],
b.[DayName],
b.FullDate




