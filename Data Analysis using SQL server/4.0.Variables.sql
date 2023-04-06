DECLARE @xx INT;

SET @xx=666;

SELECT @xx;  

--OR

DECLARE @yy INT =667;


--example
USE AdventureWorks2019;

DECLARE @zz INT =30000;
SELECT * FROM Sales.SalesOrderHeader
WHERE TotalDue>@zz;--


--more advanced example:
DECLARE @AvgPrice MONEY = (SELECT AVG(ListPrice) FROM AdventureWorks2019.Production.Product)

SELECT 
ProductID , 
AvgListPrice = @AvgPrice ,
AvgListPriceDiff = ListPrice - @AvgPrice
FROM AdventureWorks2019.Production.Product
WHERE ListPrice > @AvgPrice
ORDER BY ListPrice ASC;
