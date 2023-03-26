USE AdventureWorks2019;

SELECT SalesOrderID , OrderDate , SubTotal ,
TaxAmt , Freight , TotalDue
FROM Sales.SalesOrderHeader;

--we want to pass this informatino to the table above
SELECT SalesOrderID , OrderQty
FROM Sales.SalesOrderDetail
WHERE SalesOrderID=43659 AND OrderQty>1;

SELECT COUNT(*)
FROM Sales.SalesOrderDetail
WHERE SalesOrderID=43659 AND OrderQty>1;


SELECT SalesOrderID , OrderDate , SubTotal ,
TaxAmt , Freight , TotalDue,
(
SELECT COUNT(*)
FROM Sales.SalesOrderDetail
WHERE SalesOrderID=43659 AND OrderQty>1
) AS Quantity
FROM Sales.SalesOrderHeader;
-- now we need to modify the query because now it returns values only for id=436593


SELECT SalesOrderID , OrderDate , SubTotal ,
TaxAmt , Freight , TotalDue,
(
SELECT COUNT(*)
FROM Sales.SalesOrderDetail AS beta
WHERE beta.SalesOrderID=alpha.SalesOrderID AND beta.OrderQty>1
) AS Quantity
FROM Sales.SalesOrderHeader AS alpha;




--Exercise 1
/*
Write a query that outputs all records from the 
Purchasing.PurchaseOrderHeader table. 
Include the following columns from the table:
PurchaseOrderID ,VendorID ,OrderDate ,TotalDue
Add a derived column called NonRejectedItems which returns, 
for each purchase order ID in the query output, the number of line items 
from the Purchasing.PurchaseOrderDetail table which did not have any rejections 
(i.e., RejectedQty = 0). Use a correlated subquery to do this.
*/

SELECT COUNT(*)
FROM Purchasing.PurchaseOrderDetail
WHERE RejectedQty=0;

SELECT PurchaseOrderID ,VendorID ,OrderDate ,TotalDue,
NonRejectedItems = 
(
SELECT COUNT(*)
FROM Purchasing.PurchaseOrderDetail AS beta
WHERE alpha.PurchaseOrderID=beta.PurchaseOrderID AND beta.RejectedQty=0
)
FROM Purchasing.PurchaseOrderHeader AS alpha;


--Exercise 2
/*
Modify your query to include another derived field called MostExpensiveItem.
This field should return, for each purchase order ID, 
the UnitPrice of the most expensive item for that order in the Purchasing.PurchaseOrderDetail table.

Hint: Think of the most appropriate aggregate function to use in the correlated subquery for this scenario.
*/

SELECT * FROM Purchasing.PurchaseOrderDetail;

SELECT MAX(UnitPrice) 
FROM Purchasing.PurchaseOrderDetail
WHERE PurchaseOrderID=8;

SELECT PurchaseOrderID ,VendorID ,OrderDate ,TotalDue,
NonRejectedItems = 
(
SELECT COUNT(*)
FROM Purchasing.PurchaseOrderDetail AS beta
WHERE alpha.PurchaseOrderID=beta.PurchaseOrderID AND beta.RejectedQty=0
),
MostExpensiveItem=
(
SELECT MAX(UnitPrice) 
FROM Purchasing.PurchaseOrderDetail AS gamma
WHERE alpha.PurchaseOrderID=gamma.PurchaseOrderID
) 
FROM Purchasing.PurchaseOrderHeader AS alpha;
