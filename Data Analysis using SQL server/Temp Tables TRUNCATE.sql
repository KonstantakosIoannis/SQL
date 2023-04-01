USE AdventureWorks2019;

--

SELECT * FROM Sales.SalesOrderHeader;

CREATE TABLE #myTem
(
Dollars MONEY,
Id INT
);

INSERT INTO #myTem
SELECT TotalDue , SalesOrderID FROM Sales.SalesOrderHeader;

SELECT * FROM #myTem;



CREATE TABLE #myTot
(
Dollars MONEY,
Id INT
);
INSERT INTO #myTot
SELECT Max(Dollars), MAX(Id) FROM #myTem;

SELECT * FROM #myTot;


--remove everything from temp table #myTem;
TRUNCATE TABLE #myTem;

SELECT * FROM #myTem;

--fill it again with different values(same type though)


INSERT INTO #myTem
SELECT LineTotal , ProductID FROM Sales.SalesOrderDetail;

--no need to write this 2 lines again. we already have the above
INSERT INTO #myTot
SELECT Max(Dollars), MAX(Id) FROM #myTem;

SELECT * FROM #myTot;

