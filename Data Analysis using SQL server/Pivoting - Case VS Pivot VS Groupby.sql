--Pivoting Using PIVOT and CASE

--Let's start with a very simple example :

CREATE TABLE myPivot
(
ID VARCHAR,
LineTotal INT
);

--DROP TABLE myPivot

INSERT INTO myPivot (ID, LineTotal)
VALUES 
('A',50),
('A',541),
('B',234),
('B',356),
('B',12)
;

SELECT * FROM myPivot


--GROUP BY 
SELECT SUM(LineTotal)
FROM myPivot
GROUP BY ID;

--pivot table
SELECT A,B
FROM myPivot
PIVOT
(
SUM(LineTotal) FOR ID IN(A,B)
) AS x;

--Pivot Table Using Case
SELECT 
SUM(CASE WHEN ID='A' THEN LineTotal END ) AS A,
SUM(CASE WHEN ID='B' THEN LineTotal END ) AS B
FROM myPivot;



-- now let's see a more complicated example
USE AdventureWorks2019;


SELECT Sales.SalesOrderDetail.LineTotal ,Production.ProductCategory.Name
FROM
Sales.SalesOrderDetail JOIN Production.Product 
ON Sales.SalesOrderDetail.ProductID = Production.Product.ProductID
JOIN Production.ProductSubcategory 
ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID
JOIN Production.ProductCategory 
ON Production.ProductSubcategory.ProductCategoryID = Production.ProductCategory.ProductCategoryID
;

SELECT Accessories , Bikes , Clothing , Components --columns
FROM
(SELECT Sales.SalesOrderDetail.LineTotal ,Production.ProductCategory.Name
FROM
Sales.SalesOrderDetail JOIN Production.Product 
ON Sales.SalesOrderDetail.ProductID = Production.Product.ProductID
JOIN Production.ProductSubcategory 
ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID
JOIN Production.ProductCategory 
ON Production.ProductSubcategory.ProductCategoryID = Production.ProductCategory.ProductCategoryID) AS alpha
PIVOT
(
SUM(LineTotal)
FOR name IN(Accessories , Bikes , Clothing , Components)
) AS beta
ORDER BY 1


--Using CASE
SELECT 
SUM(CASE WHEN Name='Bikes' THEN LineTotal END) AS Bikes,
SUM(CASE WHEN Name='Accessories' THEN LineTotal END) AS Accessories,
SUM(CASE WHEN Name='Clothing' THEN LineTotal END) AS Clothing,
SUM(CASE WHEN Name='Components' THEN LineTotal END) AS Components
FROM
(SELECT Sales.SalesOrderDetail.LineTotal ,Production.ProductCategory.Name
FROM
Sales.SalesOrderDetail JOIN Production.Product 
ON Sales.SalesOrderDetail.ProductID = Production.Product.ProductID
JOIN Production.ProductSubcategory 
ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID
JOIN Production.ProductCategory 
ON Production.ProductSubcategory.ProductCategoryID = Production.ProductCategory.ProductCategoryID) AS alpha
;

--we could group our pivot table : 



SELECT *
FROM
(SELECT Sales.SalesOrderDetail.LineTotal ,Production.ProductCategory.Name,
OrderQty  -- group by order quantity
FROM
Sales.SalesOrderDetail JOIN Production.Product 
ON Sales.SalesOrderDetail.ProductID = Production.Product.ProductID
JOIN Production.ProductSubcategory 
ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID
JOIN Production.ProductCategory 
ON Production.ProductSubcategory.ProductCategoryID = Production.ProductCategory.ProductCategoryID) AS alpha
PIVOT
(
SUM(LineTotal)
FOR name IN(Accessories , Bikes , Clothing , Components)
) AS beta
ORDER BY 1