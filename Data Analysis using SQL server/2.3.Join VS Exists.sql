USE AdventureWorks2019;

SELECT * FROM Sales.SalesOrderHeader WHERE SalesOrderID = 43683;  --1 row
SELECT * FROM Sales.SalesOrderDetail WHERE SalesOrderID = 43683;  --13 rows
-- one to many relationship

SELECT
Sales.SalesOrderHeader.SalesOrderID , Sales.SalesOrderHeader.OrderDate ,
Sales.SalesOrderHeader.TotalDue,
Sales.SalesOrderDetail.SalesOrderDetailID , Sales.SalesOrderDetail.LineTotal
FROM 
Sales.SalesOrderHeader INNER JOIN Sales.SalesOrderDetail
ON Sales.SalesOrderHeader.SalesOrderID=Sales.SalesOrderDetail.SalesOrderID
WHERE Sales.SalesOrderDetail.LineTotal>10000
ORDER BY 1;

-- now we want the same result with EXISTS 

SELECT
Sales.SalesOrderHeader.SalesOrderID , Sales.SalesOrderHeader.OrderDate ,
Sales.SalesOrderHeader.TotalDue
FROM 
Sales.SalesOrderHeader 
ORDER BY 1;


SELECT
Sales.SalesOrderHeader.SalesOrderID , Sales.SalesOrderHeader.OrderDate ,
Sales.SalesOrderHeader.TotalDue
FROM 
Sales.SalesOrderHeader 
WHERE EXISTS
(
SELECT '-' --id doesnt matter what we put here..... usually (1)
FROM Sales.SalesOrderDetail
WHERE Sales.SalesOrderDetail.LineTotal>10000
AND Sales.SalesOrderHeader.SalesOrderID=Sales.SalesOrderDetail.SalesOrderID
)
ORDER BY 1;



-- S O S --

SELECT
Sales.SalesOrderHeader.SalesOrderID , Sales.SalesOrderHeader.OrderDate ,
Sales.SalesOrderHeader.TotalDue
FROM 
Sales.SalesOrderHeader 
ORDER BY 1;


SELECT
Sales.SalesOrderHeader.SalesOrderID , Sales.SalesOrderHeader.OrderDate ,
Sales.SalesOrderHeader.TotalDue
FROM 
Sales.SalesOrderHeader 
WHERE NOT EXISTS
(
SELECT '-' --id doesnt matter what we put here..... usually (1)
FROM Sales.SalesOrderDetail
WHERE Sales.SalesOrderDetail.LineTotal>10000
AND Sales.SalesOrderHeader.SalesOrderID=Sales.SalesOrderDetail.SalesOrderID
)
ORDER BY 1;
--not a single value over 10.000 
--you cant do this with a single join as above  :

SELECT
Sales.SalesOrderHeader.SalesOrderID , Sales.SalesOrderHeader.OrderDate ,
Sales.SalesOrderHeader.TotalDue,
Sales.SalesOrderDetail.SalesOrderDetailID , Sales.SalesOrderDetail.LineTotal
FROM 
Sales.SalesOrderHeader INNER JOIN Sales.SalesOrderDetail
ON Sales.SalesOrderHeader.SalesOrderID=Sales.SalesOrderDetail.SalesOrderID
WHERE Sales.SalesOrderDetail.LineTotal<10000
ORDER BY 1;

-- check the differences
