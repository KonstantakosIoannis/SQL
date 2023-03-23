--ROW_NUMBER VS RANK VS DENSE_RANK

USE AdventureWorks2019;

SELECT Production.Product.Name as Product_Name , Production.Product.ListPrice,
Production.ProductSubcategory.Name as ProductSubcategory,
Production.ProductCategory.Name as [Product Category],
ROW_NUMBER() OVER(ORDER BY ListPrice DESC)as PriceRank,
RANK()OVER (ORDER BY ListPrice DESC) as [Price Rank With Rank],
RANK()OVER(PARTITION BY Production.ProductCategory.Name ORDER BY ListPrice DESC) as [Category Price Rank With Rank],
ROW_NUMBER() OVER(PARTITION BY Production.ProductCategory.Name ORDER BY ListPrice DESC ) as [Category Price Rank],
CASE WHEN ROW_NUMBER() OVER(PARTITION BY Production.ProductCategory.Name ORDER BY ListPrice DESC) <= 5 THEN 'Yes'
ELSE 'No'
END as [Top 5 Price In Category]
FROM Production.Product INNER JOIN Production.ProductSubcategory
ON Production.Product.ProductSubcategoryID=Production.ProductSubcategory.ProductSubcategoryID
INNER JOIN Production.ProductCategory
ON Production.ProductSubcategory.ProductCategoryID=Production.ProductCategory.ProductCategoryID
;

--Exercise
/*
Modify your query by adding a derived column called "Category Price Rank With Dense Rank" 
that uses the DENSE_RANK function to rank all products by ListPrice  ++(within each category) 
in descending order
*/

SELECT Production.Product.Name as Product_Name , Production.Product.ListPrice,
Production.ProductSubcategory.Name as ProductSubcategory,
Production.ProductCategory.Name as [Product Category],
ROW_NUMBER() OVER(ORDER BY ListPrice DESC)as PriceRank,
ROW_NUMBER() OVER(PARTITION BY Production.ProductCategory.Name ORDER BY ListPrice DESC ) as [Category Price Rank],
RANK()OVER (ORDER BY ListPrice DESC) as [Price Rank With Rank],
RANK()OVER(PARTITION BY Production.ProductCategory.Name ORDER BY ListPrice DESC) as [Category Price Rank With Rank],
DENSE_RANK() OVER(ORDER BY ListPrice) as [Price Rank With Dense Rank],
DENSE_RANK() OVER(PARTITION BY Production.ProductCategory.Name ORDER BY ListPrice DESC) as[Production.ProductCategory.Name],
CASE WHEN ROW_NUMBER() OVER(PARTITION BY Production.ProductCategory.Name ORDER BY ListPrice DESC) <= 5 THEN 'Yes'
ELSE 'No'
END as [Top 5 Price In Category]
FROM Production.Product INNER JOIN Production.ProductSubcategory
ON Production.Product.ProductSubcategoryID=Production.ProductSubcategory.ProductSubcategoryID
INNER JOIN Production.ProductCategory
ON Production.ProductSubcategory.ProductCategoryID=Production.ProductCategory.ProductCategoryID
;

--OVERALL : 
/*
In summary, the key difference between RANK and DENSE_RANK is that RANK may skip ranks, 
while DENSE_RANK will not. 
ROW_NUMBER is different in that it assigns a unique sequential number to each row, 
regardless of whether or not it has the same value as another row.
*/
