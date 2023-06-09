--PARTITION BY

USE AdventureWorks2019;

--partition by vs group by vs window function

SELECT *FROM Sales.SalesOrderDetail;

--Group by
SELECT  ProductID , OrderQty , SUM(LineTotal) as SumLineTotal
FROM Sales.SalesOrderDetail
GROUP BY ProductID , OrderQty
ORDER BY 1,2;

-- for better understanding
SELECT ProductID , OrderQty 
FROM Sales.SalesOrderDetail
WHERE ProductID=707;


--Window function
SELECT  ProductID , OrderQty , SUM(LineTotal) OVER()
FROM Sales.SalesOrderDetail
ORDER BY 1;


--Partition by
--It's a combination of them :
SELECT  ProductID , OrderQty , SUM(LineTotal) OVER(PARTITION BY ProductID , OrderQty)
FROM Sales.SalesOrderDetail
ORDER BY 1;  --select distinct here is much more beautiful and useful

/*
In summary, GROUP BY is used to perform aggregation on data and returns a single row for each group, 
while PARTITION BY is used to divide a result set into partitions and assigns a rank or row number to each row within each partition
*/
