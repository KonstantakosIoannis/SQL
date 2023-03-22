--Exercise 1

--we have the following query from a previous exercise:
SELECT Production.Product.Name as Product_Name , Production.Product.ListPrice,
Production.ProductSubcategory.Name as ProductSubcategory,
Production.ProductCategory.Name as ProductCategory
FROM Production.Product INNER JOIN Production.ProductSubcategory
ON Production.Product.ProductSubcategoryID=Production.ProductSubcategory.ProductSubcategoryID
INNER JOIN Production.ProductCategory
ON Production.ProductSubcategory.ProductCategoryID=Production.ProductCategory.ProductCategoryID
;

/*
Enhance your query  by adding a derived column called "Price Rank " 
that ranks all records in the dataset by ListPrice, in descending order. 
That is to say, the product with the most expensive price should have a rank of 1, 
and the product with the least expensive price 
should have a rank equal to the number of records in the dataset.
*/

SELECT Production.Product.Name as Product_Name , Production.Product.ListPrice,
Production.ProductSubcategory.Name as ProductSubcategory,
Production.ProductCategory.Name as ProductCategory,
ROW_NUMBER() OVER(ORDER BY ListPrice DESC)as PriceRank
FROM Production.Product INNER JOIN Production.ProductSubcategory
ON Production.Product.ProductSubcategoryID=Production.ProductSubcategory.ProductSubcategoryID
INNER JOIN Production.ProductCategory
ON Production.ProductSubcategory.ProductCategoryID=Production.ProductCategory.ProductCategoryID
;




--Exercise 3
/*
Enhance your query from Exercise 2 by adding a derived column called
"Category Price Rank" that ranks all products by ListPrice – within each category - in descending order. 
In other words, every product within a given category should be ranked 
relative to other products in the same category.
*/


SELECT Production.Product.Name as Product_Name , Production.Product.ListPrice,
Production.ProductSubcategory.Name as ProductSubcategory,
Production.ProductCategory.Name as [Product Category],
ROW_NUMBER() OVER(ORDER BY ListPrice DESC)as PriceRank,
ROW_NUMBER() OVER(PARTITION BY Production.ProductCategory.Name ORDER BY ListPrice DESC ) as [Category Price Rank]
FROM Production.Product INNER JOIN Production.ProductSubcategory
ON Production.Product.ProductSubcategoryID=Production.ProductSubcategory.ProductSubcategoryID
INNER JOIN Production.ProductCategory
ON Production.ProductSubcategory.ProductCategoryID=Production.ProductCategory.ProductCategoryID
;



--Exercise 4
/*
Enhance your query from Exercise 3 by adding a derived column called
"Top 5 Price In Category" that returns the string “Yes” 
if a product has one of the top 5 list prices in its product category, 
and “No” if it does not. 
You can try incorporating your logic from Exercise 3 into a CASE statement to make this work.
*/

SELECT Production.Product.Name as Product_Name , Production.Product.ListPrice,
Production.ProductSubcategory.Name as ProductSubcategory,
Production.ProductCategory.Name as [Product Category],
ROW_NUMBER() OVER(ORDER BY ListPrice DESC)as PriceRank,
ROW_NUMBER() OVER(PARTITION BY Production.ProductCategory.Name ORDER BY ListPrice DESC ) as [Category Price Rank],
CASE WHEN ROW_NUMBER() OVER(PARTITION BY roduction.ProductCategory.Name ORDER BY ListPrice DESC) <= 5 THEN 'Yes'
ELSE 'No'
END as [Top 5 Price In Category]
FROM Production.Product INNER JOIN Production.ProductSubcategory
ON Production.Product.ProductSubcategoryID=Production.ProductSubcategory.ProductSubcategoryID
INNER JOIN Production.ProductCategory
ON Production.ProductSubcategory.ProductCategoryID=Production.ProductCategory.ProductCategoryID
;