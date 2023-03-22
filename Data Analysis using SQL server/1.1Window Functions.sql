--WINDOW FUNCTIONS
/*A window function, also known as an analytic function, computes values over a group of rows 
and returns a single result for each row.
This is different from an aggregate function, which returns a single result for a group of rows.
A window function includes an OVER clause, which defines a window of rows around the row being evaluated.
*/

SELECT * FROM Sales.SalesPerson;

SELECT  BusinessEntityID , Bonus FROM Sales.SalesPerson;

-- debug example
SELECT  BusinessEntityID , Bonus , 'John' as myname FROM Sales.SalesPerson;

--now lets say that instead of the dumb myname column we want the sum of bonuses
--there are two ways :

SELECT SUM(Bonus) FROM Sales.SalesPerson;
 --48610.00 and then write it manually as i did before with my name 
 SELECT  BusinessEntityID , Bonus , 48610 FROM Sales.SalesPerson; --NOT A GOOD IDEA

 -- or if you are a SQL pro you could use a window function
 SELECT  BusinessEntityID , Bonus , SUM(Bonus) OVER() as BonusSUM FROM Sales.SalesPerson;
 -- obviously the two queries above returns exactly the same
 -- OBVIOUSLY we will ONLY use the second one ALWAYS ! ! !
 


 -- a very good example : 
 SELECT BusinessEntityID ,SalesYTD , MAX(SalesYTD) OVER()
 FROM Sales.SalesPerson;

 --ERROR  max needs a groupby or an OVER
-- SELECT BusinessEntityID ,SalesYTD , MAX(SalesYTD)
-- FROM Sales.SalesPerson;

 SELECT BusinessEntityID ,SalesYTD , SalesYTD/MAX(SalesYTD) OVER()
 FROM Sales.SalesPerson;

 --same ERROR :
 --SELECT BusinessEntityID ,SalesYTD , SalesYTD/MAX(SalesYTD) 
 --FROM Sales.SalesPerson;
