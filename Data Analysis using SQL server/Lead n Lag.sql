--LEAD AND LAG

USE AdventureWorks2019;

SELECT SalesOrderId , OrderDate , TotalDue,
LEAD(TotalDue) OVER(ORDER BY SalesOrderId) as [next],
LAG(TotalDue) OVER(ORDER BY SalesOrderId) as [previous]
FROM Sales.SalesOrderHeader 
ORDER BY 1; 


SELECT SalesOrderId , CustomerId, OrderDate , TotalDue,
LEAD(TotalDue) OVER(ORDER BY SalesOrderId) as [next],
LAG(TotalDue) OVER(ORDER BY SalesOrderId) as [previous],
LEAD(TotalDue) OVER(PARTITION BY CustomerId ORDER BY SalesOrderId) as [next in category],
LAG(TotalDue) OVER(PARTITION BY CustomerId ORDER BY SalesOrderId) as [next in category]
FROM Sales.SalesOrderHeader 
ORDER BY 2,1; 