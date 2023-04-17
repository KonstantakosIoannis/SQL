--ROW NUMBER

--rank data within a group

USE AdventureWorks2019;

SELECT SalesOrderID , LineTotal, 
SUM(LineTotal) OVER(PARTITION BY SalesOrderID) as SumTotal
FROM Sales.SalesOrderDetail;

--we want to rank-order the data within the created groups by LineTotal

SELECT SalesOrderID , LineTotal, 
SUM(LineTotal) OVER(PARTITION BY SalesOrderID) as SumTotal,
ROW_NUMBER() OVER (PARTITION BY SalesOrderID ORDER BY LineTotal) as MyRank
FROM Sales.SalesOrderDetail
ORDER BY SalesOrderID;

-- Row number could be also used to rank the whole set and not the groups
-- something like order but with a new column that shows the ranks


SELECT SalesOrderID , LineTotal, 
ROW_NUMBER() OVER (ORDER BY LineTotal) as MyRank
FROM Sales.SalesOrderDetail
ORDER BY SalesOrderID;

-- order by rank to see it clearly :
SELECT SalesOrderID , LineTotal, 
ROW_NUMBER() OVER (ORDER BY LineTotal) as MyRank
FROM Sales.SalesOrderDetail
ORDER BY MyRank;