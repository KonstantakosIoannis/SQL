USE AdventureWorks2019; -- our database will be AdventureWorks2019 and this is how you select it
-- if you have many databases you have to be sure every time which one you have selected 
-- the selected database is displayed in the top left cell(you could also choose your DB there)


SELECT 'John K';

-- one of our database tables is Sales.Currency

-- you can select this way:
SELECT * FROM Sales.Currency;
-- or this way :
SELECT * FROM AdventureWorks2019.Sales.Currency; -- this is bigger but better :D , 
-- especially when you work with multiple DBs
--We could also do this : 
SELECT * FROM [AdventureWorks2019].[Sales].[Currency]; -- BUT NO 


--Only show the first x Rows(ex=10)
SELECT TOP(10)* FROM AdventureWorks2019.Sales.Currency;
--This is a difference between server and mysql. mysql has the LIMIT here we have SELECT TOP

--GROUP BY (STEP BY STEP)
SELECT * FROM Sales.SalesOrderHeader; -- there many columns we could work with

-- we chooose the territoty ID and the totaldue
SELECT Sales.SalesOrderHeader.TerritoryID , Sales.SalesOrderHeader.TotalDue FROM Sales.SalesOrderHeader;

SELECT DISTINCT  Sales.SalesOrderHeader.TerritoryID FROM Sales.SalesOrderHeader ORDER BY 1;
-- there are 10 different territories given ID's from 1 to 10.

--so we could group totaldue by teritory and the order it by DESC to see which of them has the bigger
SELECT TerritoryID , SUM(TotalDue)  
FROM Sales.SalesOrderHeader
GROUP BY TerritoryID
ORDER BY 2 DESC; -- 2=SUM(TotalDue)
--Territory Number 4 has the biggest Due

/*SOS  : the form above is simple easy and fast to write
BUT it could by very hard for somebody to read and understand it 
espacially when he is not familiar with the code or when we have complex database systems 
So i strongly reccomend to write your queries like this : */

SELECT AdventureWorks2019.Sales.SalesOrderHeader.TerritoryID , 
SUM(AdventureWorks2019.Sales.SalesOrderHeader.TotalDue)  
FROM AdventureWorks2019.Sales.SalesOrderHeader
GROUP BY AdventureWorks2019.Sales.SalesOrderHeader.TerritoryID
ORDER BY SUM(AdventureWorks2019.Sales.SalesOrderHeader.TotalDue)  DESC;
-- this is the best form you could have

-- Alias , there are two way , i prefer the first one
SELECT AdventureWorks2019.Sales.SalesOrderHeader.TotalDue as nickname
FROM AdventureWorks2019.Sales.SalesOrderHeader;

SELECT nickname=AdventureWorks2019.Sales.SalesOrderHeader.TotalDue
FROM AdventureWorks2019.Sales.SalesOrderHeader;


-- SELECT - FROM - WHERE - GROUP BY - HAVING - ORDER BY

SELECT TerritoryID , SUM(TotalDue) as SumTotalDue
FROM Sales.SalesOrderHeader
WHERE OnlineOrderFlag=1
GROUP BY TerritoryID  -- run this query step by step to fully understand it 
HAVING TerritoryID>5
ORDER BY SumTotalDue DESC;

 -- run this query step by step to fully understand it  : 

 --STEP 1 :
 SELECT * FROM Sales.SalesOrderHeader;

 --STEP 2 : 
 SELECT TerritoryID , TotalDue
FROM Sales.SalesOrderHeader
WHERE OnlineOrderFlag=1;

--STEP 3:
SELECT TerritoryID , SUM(TotalDue) as SumTotalDue
FROM Sales.SalesOrderHeader
WHERE OnlineOrderFlag=1
GROUP BY TerritoryID;

--and then the final query 

