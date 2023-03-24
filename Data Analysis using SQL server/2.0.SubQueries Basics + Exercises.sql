--Sub Query

--we have this query :

USE AdventureWorks2019;

SELECT SalesOrderID , SalesOrderDetailID , LineTotal ,
LTRank = ROW_NUMBER()OVER(PARTITION BY SalesOrderID ORDER BY LineTotal DESC)
FROM Sales.SalesOrderDetail;

--and we want to select only the rows with LTRank=1

--notice that the following leads to an error :
SELECT SalesOrderID , SalesOrderDetailID , LineTotal ,
LTRank = ROW_NUMBER()OVER(PARTITION BY SalesOrderID ORDER BY LineTotal DESC)
FROM Sales.SalesOrderDetail
WHERE LTRank=1;

--this too:
SELECT SalesOrderID , SalesOrderDetailID , LineTotal ,
LTRank = ROW_NUMBER()OVER(PARTITION BY SalesOrderID ORDER BY LineTotal DESC)
FROM Sales.SalesOrderDetail
WHERE ROW_NUMBER()OVER(PARTITION BY SalesOrderID ORDER BY LineTotal DESC)=1;
--Windowed functions can only appear in the SELECT or ORDER BY clauses.

--we need a subquery : 

SELECT * FROM 
(
SELECT SalesOrderID , SalesOrderDetailID , LineTotal ,
LTRank = ROW_NUMBER()OVER(PARTITION BY SalesOrderID ORDER BY LineTotal DESC)
FROM Sales.SalesOrderDetail
) as x -- this alias here is necessary , reminder(as x=x , we could write an alias without the keyword as)
WHERE LTRank=1;



--Exercise 1
/*
Write a query that displays the three most expensive orders, 
per vendor ID, from the Purchasing.PurchaseOrderHeader table. 
There should ONLY be three records per Vendor ID, even if some of the total amounts due are identical. 
"Most expensive" is defined by the amount in the "TotalDue" field.

Include the following fields in your output:
PurchaseOrderID , VendorID , OrderDate , TaxAmt , Freight , TotalDue

Hints:
You will first need to define a field that assigns a unique rank to every purchase order, 
within each group of like vendor IDs.

You'll probably want to use a Window Function with PARTITION BY and ORDER BY to do this.

The last step will be to apply the appropriate criteria to the field you created with your Window Function.
*/

--It is a pretty complex exercise so we will do it step by step as usual: 
SELECT *
FROM Purchasing.PurchaseOrderHeader;

SELECT PurchaseOrderID , VendorID , OrderDate , TaxAmt , Freight , TotalDue
FROM Purchasing.PurchaseOrderHeader;

SELECT PurchaseOrderID , VendorID , OrderDate , TaxAmt , Freight , TotalDue,
ROW_NUMBER()OVER(PARTITION BY VendorId ORDER BY TotalDue DESC)
FROM Purchasing.PurchaseOrderHeader
ORDER BY VendorID;

SELECT * FROM 
(
SELECT PurchaseOrderID , VendorID , OrderDate , TaxAmt , Freight , TotalDue,
ROW_NUMBER()OVER(PARTITION BY VendorId ORDER BY TotalDue DESC) as dueRank
FROM Purchasing.PurchaseOrderHeader
--ORDER BY 2 The ORDER BY clause is invalid in views, inline functions, derived tables, subqueries
)as a
WHERE dueRank<4
ORDER BY VendorID; --order by only HERE



--Exercise 2
/*
Modify your query from the first problem, such that the top three purchase order amounts are returned, 
regardless of how many records are returned per Vendor Id.
In other words, if there are multiple orders with the same total due amount, 
all should be returned as long as the total due amount for these orders is one of the top three.
*/

-- instead of rownumber we should use denserank

SELECT * FROM 
(
SELECT PurchaseOrderID , VendorID , OrderDate , TaxAmt , Freight , TotalDue,
DENSE_RANK()OVER(PARTITION BY VendorId ORDER BY TotalDue DESC) as dueRank
FROM Purchasing.PurchaseOrderHeader
--ORDER BY 2 The ORDER BY clause is invalid in views, inline functions, derived tables, subqueries
)as a
WHERE dueRank<4
ORDER BY VendorID; 
