USE AdventureWorks2019;


GO
CREATE FUNCTION dbo.myFun ()
RETURNS INT
AS
BEGIN
	RETURN(SELECT SUM(SubTotal) FROM Sales.SalesOrderHeader)
END;


SELECT dbo.myFun(); --OR
SELECT x=dbo.myFun();
--SELECT x; --ERROR



--2nd example
CREATE FUNCTION dbo.myFun2 ()
RETURNS INT
AS
BEGIN
	RETURN(SELECT COUNT(Status) FROM Sales.SalesOrderHeader)
END;


--advanced example with arguments
CREATE FUNCTION dbo.myFunX(@xx INT, @yy INT)
RETURNS INT --it runs properly without the AS and the Go
BEGIN
	RETURN (@xx+@yy)
END;

SELECT dbo.myFunX(10,5);

--advanced example with arguments N.2

CREATE FUNCTION dbo.myFunY(@StartDate DATE, @EndDate DATE)
RETURNS INT
BEGIN
RETURN 
(SELECT COUNT(*) FROM AdventureWorks2019.dbo.Calendar
WHERE DateValue BETWEEN @StartDate AND @EndDate
AND WeekendFlag = 0 AND HolidayFlag = 0)
END;

--Using the function in a query
SELECT SalesOrderID,
ElapsedBusinessDays = dbo.myFunY(OrderDate,ShipDate)
FROM AdventureWorks2019.Sales.SalesOrderHeader
WHERE YEAR(OrderDate) = 2011;
