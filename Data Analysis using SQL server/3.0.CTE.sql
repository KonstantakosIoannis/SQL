USE AdventureWorks2019;

--Sometimes subqueries can be very difficult to write and very confusing read
--in these cases we have the alternative solution of CTE

WITH myTemp AS
(
SELECT SalesOrderID, OrderDate ,TotalDue
FROM Sales.SalesOrderHeader
)
SELECT TotalDue FROM myTemp;

--we can have more that one virtual tables in our CTE's
WITH myTemp2 AS
(
SELECT SalesOrderID, OrderDate ,TotalDue
FROM Sales.SalesOrderHeader
),
myTemp2_1 AS
(
SELECT TotalDue
FROM myTemp2
WHERE SalesOrderID>44000
),  --SELECT * FROM myTemp2_1; --we could stop here or add more layers
myTemp3 AS
(
SELECT TotalDue FROM myTemp2_1
WHERE TotalDue>3000
)
--SELECT * FROM myTemp3; --OR
SELECT SUM(TotalDue) FROM myTemp3;


--Let's see a bigger example CTE VS SUBQUERY

--Subquery approach:

SELECT
A.OrderMonth,
A.Top10Total,
PrevTop10Total = B.Top10Total

FROM (
SELECT
OrderMonth,
Top10Total = SUM(TotalDue)
FROM (
SELECT 
       OrderDate
	  ,OrderMonth = DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1)
      ,TotalDue
	  ,OrderRank = ROW_NUMBER() OVER(PARTITION BY DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1) ORDER BY TotalDue DESC)
FROM AdventureWorks2019.Sales.SalesOrderHeader
) X
WHERE OrderRank <= 10
GROUP BY OrderMonth
) A

LEFT JOIN (
SELECT
OrderMonth,
Top10Total = SUM(TotalDue)
FROM (
SELECT 
       OrderDate
	  ,OrderMonth = DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1)
      ,TotalDue
	  ,OrderRank = ROW_NUMBER() OVER(PARTITION BY DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1) ORDER BY TotalDue DESC)
FROM AdventureWorks2019.Sales.SalesOrderHeader
) X
WHERE OrderRank <= 10
GROUP BY OrderMonth
) B
ON A.OrderMonth = DATEADD(MONTH,1,B.OrderMonth)

ORDER BY 1




--Refactored using CTE:

WITH Sales AS
(
SELECT 
       OrderDate
	  ,OrderMonth = DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1)
      ,TotalDue
	  ,OrderRank = ROW_NUMBER() OVER(PARTITION BY DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1) ORDER BY TotalDue DESC)
FROM AdventureWorks2019.Sales.SalesOrderHeader
)

,Top10Sales AS
(
SELECT
OrderMonth,
Top10Total = SUM(TotalDue)
FROM Sales
WHERE OrderRank <= 10
GROUP BY OrderMonth
)


SELECT
A.OrderMonth,
A.Top10Total,
PrevTop10Total = B.Top10Total

FROM Top10Sales A
	LEFT JOIN Top10Sales B
		ON A.OrderMonth = DATEADD(MONTH,1,B.OrderMonth)

ORDER BY 1

