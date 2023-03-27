USE AdventureWorks2019;

SELECT * 
FROM Sales.SalesOrderDetail
WHERE SalesOrderID=43659;
--we want to flatten these data for the linetotal(12 rows to 1)

--1st step XML format
SELECT LineTotal 
FROM Sales.SalesOrderDetail
WHERE SalesOrderID=43659
FOR XML PATH('');
--click at the ouptut link

--2nd step : one line(still xml)
--SELECT ',' + CAST(LineTotal AS VARCHAR), -- casting FLOAT to VARCHAR and then
SELECT ',' + CAST(CAST(LineTotal) AS MONEY) AS VARCHAR--EVEN BETTER!!(less 000)
--concatenate the values in one row using comma 
FROM Sales.SalesOrderDetail
WHERE SalesOrderID=43659
FOR XML PATH(''); -- it is still xml format

--3rd step
SELECT STUFF --returns VARCHAR - takes 4 arguments
(
	
	(SELECT ',,,,,,,,' + CAST(CAST (LineTotal AS MONEY) AS VARCHAR)--more commas for better print :D
	FROM Sales.SalesOrderDetail
	WHERE SalesOrderID=43659
	FOR XML PATH('')), --1st argument subquery
	1, --2nd argument starting position
	1, --3rd argument how many characters to clip off(only one the first comma)
	''--4th and last argument , where to write it. in an empty string
)