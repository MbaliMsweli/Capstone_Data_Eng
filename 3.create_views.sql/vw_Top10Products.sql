-----creating a view to check Top 10 Products
CREATE VIEW vw_Top10Products AS

SELECT TOP 10
ProductID,
ProductName
FROM [RetailDataWarehouse].[dbo].[DimProduct] 



SELECT * FROM vw_Top10Products
