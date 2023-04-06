USE AdventureWorks2019;

--CREATE
CREATE PROCEDURE dbo.myPro
AS
BEGIN
SELECT AVG(TaxAmt) FROM Sales.SalesOrderHeader 
WHERE ShipMethodID=5
END

EXEC dbo.myPro;


--ALTER 
ALTER PROCEDURE dbo.myPro(@x INT)
AS
BEGIN
SELECT MAX(TaxAmt)+@x FROM Sales.SalesOrderHeader
END

EXEC dbo.myPro 5;

--Exercise
/*
Create a stored procedure called "OrdersAboveThreshold" 
that pulls in all sales orders with a total due amount 
above a threshold specified in a parameter called "@Threshold". 
The value for threshold will be supplied by the caller of the stored procedure.

The proc should have two other parameters: 
"@StartYear" and "@EndYear" (both INT data types), 
also specified by the called of the procedure. 
All order dates returned by the proc should fall between these two years.
*/


CREATE PROCEDURE dbo.OrdersAboveThreshold(@Threshold MONEY, @StartYear INT, @EndYear INT)
AS
BEGIN
SELECT 
A.SalesOrderID, A.OrderDate, A.TotalDue
FROM  AdventureWorks2019.Sales.SalesOrderHeader AS A
JOIN AdventureWorks2019.dbo.Calendar AS B
ON A.OrderDate = B.DateValue
WHERE A.TotalDue >= @Threshold 
AND B.YearNumber BETWEEN @StartYear AND @EndYear
END

EXEC dbo.OrdersAboveThreshold 10000, 2011, 2013

DROP PROCEDURE IF EXISTS dbo.OrdersAboveThresholdl ;


