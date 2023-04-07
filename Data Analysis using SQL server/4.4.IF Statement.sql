-- a simple example
DECLARE @MyInput INT = 1 --try different values greater , equal and lower than 1

IF @MyInput > 1
	BEGIN
		SELECT 'Hello World'
	END
ELSE
	BEGIN
		SELECT 'Farewell For Now!'
	END

--simple IFs can be written in one row
DECLARE @x INT = 1
IF @x =1 SELECT '111';


--more advanced example with Function
CREATE FUNCTION dbo.goX(@xx INT, @yy INT, @zz INT)
RETURNS INT
AS
BEGIN
    IF @zz = 1
        RETURN (@xx + @yy);
    RETURN (@xx - @yy);
END

SELECT dbo.goX(10,5,4);
SELECT dbo.goX(10,5,1);

--THEORY
--every function should close with a return statement(outside the if)
--so after the if statement write a dumb return (it will never run anyway)
CREATE FUNCTION dbo.goY(@xx INT, @yy INT, @zz INT)
RETURNS INT
AS
BEGIN
    IF @zz = 1
        RETURN (@xx + @yy);
	ELSE
		RETURN (@xx - @yy);
	RETURN 0;
END

SELECT dbo.goY(10,5,10);
SELECT dbo.goY(10,5,1);


--advanced example with stored procedure
USE AdventureWorks2019;
ALTER PROCEDURE dbo.OrdersAboveThreshold
(@Threshold MONEY, @StartYear INT, @EndYear INT, @OrderType INT)
AS
BEGIN
IF @OrderType = 1
	BEGIN
	SELECT A.SalesOrderID, A.OrderDate, A.TotalDue
	FROM  AdventureWorks2019.Sales.SalesOrderHeader A
	JOIN AdventureWorks2019.dbo.Calendar B
	ON A.OrderDate = B.DateValue
	WHERE A.TotalDue >= @Threshold
	AND B.YearNumber BETWEEN @StartYear AND @EndYear
	ORDER BY A.TotalDue DESC
	END

	ELSE
	BEGIN
	SELECT 
	A.PurchaseOrderID, A.OrderDate, A.TotalDue
	FROM  AdventureWorks2019.Purchasing.PurchaseOrderHeader A
	JOIN AdventureWorks2019.dbo.Calendar B
	ON A.OrderDate = B.DateValue
	WHERE A.TotalDue >= @Threshold
	AND B.YearNumber BETWEEN @StartYear AND @EndYear
	ORDER BY A.TotalDue DESC
	END
END



--Call modified procedure


EXEC dbo.OrdersAboveThreshold 10000, 2011, 2013, 1

EXEC dbo.OrdersAboveThreshold 10000, 2011, 2013, 2
