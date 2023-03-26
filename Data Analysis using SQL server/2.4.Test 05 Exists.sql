USE AdventureWorks2019;

--Exercise 1
/*
Select all records from the Purchasing.PurchaseOrderHeader table 
such that there is at least one item in the order with an order quantity greater than 500. 
The individual items tied to an order can be found in the Purchasing.PurchaseOrderDetail table.

Select the following columns:
PurchaseOrderID , OrderDate , SubTotal , TaxAmt
Sort by purchase order ID.
*/

SELECT * FROM Purchasing.PurchaseOrderDetail;

SELECT PurchaseOrderID , OrderDate , SubTotal , TaxAmt
FROM Purchasing.PurchaseOrderHeader
WHERE EXISTS
(
SELECT 1 
FROM Purchasing.PurchaseOrderDetail
WHERE OrderQty>500 AND
Purchasing.PurchaseOrderDetail.PurchaseOrderID=Purchasing.PurchaseOrderHeader.PurchaseOrderID
)
ORDER BY 1;




--Exercise 2
/*
Modify your query from Exercise 1 as follows:
Select all records from the Purchasing.PurchaseOrderHeader table 
such that there is at least one item in the order with an order quantity greater than 500, 
AND a unit price greater than $50.00.

Select ALL columns from the Purchasing.PurchaseOrderHeader table for display in your output.
*/

SELECT *
FROM Purchasing.PurchaseOrderHeader
WHERE EXISTS
(
SELECT 1 
FROM Purchasing.PurchaseOrderDetail
WHERE OrderQty>500 AND UnitPrice>50 AND
Purchasing.PurchaseOrderDetail.PurchaseOrderID=Purchasing.PurchaseOrderHeader.PurchaseOrderID
)
ORDER BY 1;




--Exercise 3
/*
Select all records from the Purchasing.PurchaseOrderHeader 
table such that NONE of the items within the order have a rejected quantity greater than 0.

Select ALL columns from the Purchasing.PurchaseOrderHeader table 
*/

SELECT * FROM Purchasing.PurchaseOrderDetail;

SELECT *
FROM Purchasing.PurchaseOrderHeader
WHERE NOT EXISTS
(
SELECT 1 FROM  Purchasing.PurchaseOrderDetail
WHERE RejectedQty>0 AND
Purchasing.PurchaseOrderDetail.PurchaseOrderID=Purchasing.PurchaseOrderHeader.PurchaseOrderID
);
