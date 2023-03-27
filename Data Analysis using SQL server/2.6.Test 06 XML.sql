--Exercise 1
/*
Create a query that displays all rows from the Production.ProductSubcategory table, 
and includes the following fields:

The "Name" field from Production.ProductSubcategory, which should be aliased as "SubcategoryName"

A derived field called "Products" which displays, 
for each Subcategory in Production.ProductSubcategory, 
a semicolon-separated list of all products from Production.Product contained within the given subcategory
*/

USE AdventureWorks2019;

SELECT Name AS SubcategoryName,
Products = 
STUFF(
(SELECT';' + beta.Name
FROM AdventureWorks2019.Production.Product AS beta
WHERE alpha.ProductSubcategoryID = beta.ProductSubcategoryID
FOR XML PATH('')
),1,1,''
)
FROM  Production.ProductSubcategory AS alpha;



--Exercise 2
/*
Modify the query from Exercise 1 such that only products with a ListPrice value greater than $50 
are listed in the "Products" field.
*/

SELECT Name AS SubcategoryName,
Products = 
STUFF(
(SELECT';' + beta.Name
FROM AdventureWorks2019.Production.Product AS beta
WHERE alpha.ProductSubcategoryID = beta.ProductSubcategoryID
AND ListPrice>50 --just add this line of code
FOR XML PATH('')
),1,1,''
)
FROM  Production.ProductSubcategory AS alpha;
