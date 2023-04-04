USE AdventureWorks2019;

--things that slow down queries :
--joins between large tables(million of rows)


CREATE TABLE #mySales
(
SalesOrderID INT,
OrderDate DATE
)

INSERT INTO #mySales
(
SalesOrderID,
OrderDate
)
SELECT
SalesOrderID,
OrderDate
FROM AdventureWorks2019.Sales.SalesOrderHeader
WHERE YEAR(OrderDate) = 2012

SELECT * FROM #mySales;

--index creation

CREATE CLUSTERED INDEX mySalesIndex ON #mySales(SalesOrderID);--index name - table(column i want to index)

--CREATE CLUSTERED INDEX mySalesIndex2 ON #mySales(OrderDate)--ERROR
--Cannot create more than one clustered index

CREATE NONCLUSTERED INDEX mySalesIndex2 ON #mySales(OrderDate);
