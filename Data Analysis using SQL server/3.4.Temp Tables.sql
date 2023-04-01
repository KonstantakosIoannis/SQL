USE AdventureWorks2019;

SELECT CustomerID , StoreID , TerritoryID 
INTO #mytemp --temp table alias
FROM Sales.Customer;

SELECT * FROM #mytemp; --always with #

DROP TABLE #mytemp;

--overall it is a better option than CTE

--More advancned Temp Table Creation

CREATE TABLE #mySales --table creation
(
OrderDate DATE,
OrderMonth DATE,
TotalDue MONEY,
OrderRank INT
);



INSERT INTO #mySales  --insert values
(  --insert into these columns
OrderDate,
OrderMonth,
TotalDue,
OrderRank
)
SELECT --these values
OrderDate,
OrderMonth = DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1),
TotalDue,
OrderRank = ROW_NUMBER() OVER(PARTITION BY DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1) ORDER BY TotalDue DESC)
FROM AdventureWorks2019.Sales.SalesOrderHeader;


SELECT * FROM #mySales;




--example N.2
CREATE TABLE #mySales2
(
OrderMonth DATE,
Top10Total MONEY
)

INSERT INTO #mySales2
--here i omit the columns i want to insert in data
--in this case SQL inserts automatic the data into the columns by the default order
--so we need to be very carefull
SELECT
OrderMonth,
Top10Total = SUM(TotalDue)
FROM #mySales
WHERE OrderRank <= 10
GROUP BY OrderMonth;
--the previous format was much more scecific so we prefer that one
--instead of this , that could lead to mistakes

