USE AdventureWorks2019;

--THEORY lookup tables vs common tables
/*
In Microsoft SQL Server, a table is a database object that stores data in rows and columns. 
It is used to store data in a structured manner, and is the most basic object used for storing data 
in a database.

A lookup table, on the other hand, is a type of table that is used to store data 
that is used for reference purposes. It is often used to store a small set of data 
that is used repeatedly in other tables, such as a list of product categories or a list of states.

The main differences between tables and lookup tables in Microsoft SQL Server are:
1)Purpose: Tables are used to store data, while lookup tables are used to store reference data.
2)Size: Tables can be large and complex, storing many rows and columns of data, 
while lookup tables are typically small and simple.
3)Use in other tables: Lookup tables are often used as a reference in other tables. 
For example, a product table may reference a category lookup table.
4)Indexing: Tables may have indexes created on one or more columns to improve query performance, 
while lookup tables are typically small enough to not require indexing.
5)Constraints: Tables may have various constraints applied to ensure data integrity, 
such as primary key constraints or foreign key constraints, while lookup tables 
may not require such constraints.

Overall, tables and lookup tables are both important components of a relational database, 
but they serve different purposes and have different characteristics.

*/





CREATE TABLE AdventureWorks2019.dbo.Calendar
-- database - schema - table name
(
DateValue DATE,
DayOfWeekNumber INT,
DayOfWeekName VARCHAR(32),
DayOfMonthNumber INT,
MonthNumber INT,
YearNumber INT,
WeekendFlag TINYINT,
HolidayFlag TINYINT
);--table columns and their types

--insert values
INSERT INTO Adventureworks2019.dbo.Calendar
(
DateValue,
DayOfWeekNumber,
DayOfWeekName,
DayOfMonthNumber,
MonthNumber,
YearNumber,
WeekendFlag,
HolidayFlag
)
VALUES
(CAST('01-01-2011' AS DATE),7,'Saturday',1,1,2011,1,1),
(CAST('01-02-2011' AS DATE),1,'Sunday',2,1,2011,1,0)
--as you can easily guess it is impossible two inster too many values this way....

SELECT * FROM Adventureworks2019.dbo.Calendar;

--let's clear our table 
TRUNCATE TABLE Adventureworks2019.dbo.Calendar;






--Insert dates to table with recursive CTE
WITH Dates AS
(
SELECT
 CAST('01-01-2011' AS DATE) AS MyDate
UNION ALL
SELECT
DATEADD(DAY, 1, MyDate)
FROM Dates
WHERE MyDate < CAST('12-31-2030' AS DATE)
)
INSERT INTO AdventureWorks2019.dbo.Calendar
(DateValue)
SELECT
MyDate
FROM Dates
OPTION (MAXRECURSION 10000);


--insert values in the null fields using dateformats
UPDATE AdventureWorks2019.dbo.Calendar
SET
DayOfWeekNumber = DATEPART(WEEKDAY,DateValue),
DayOfWeekName = FORMAT(DateValue,'dddd'),
DayOfMonthNumber = DAY(DateValue),
MonthNumber = MONTH(DateValue),
YearNumber = YEAR(DateValue);


UPDATE AdventureWorks2019.dbo.Calendar
SET WeekendFlag = 
CASE WHEN DayOfWeekNumber IN(1,7) THEN 1--try to return the same result using DateofWeekName
ELSE 0 END;


UPDATE AdventureWorks2019.dbo.Calendar
SET HolidayFlag =
CASE WHEN DayOfMonthNumber = 1 AND MonthNumber = 1 THEN 1
ELSE 0 END;


--SELECT * FROM Adventureworks2019.dbo.Calendar;



--Join the lookup table with another table
SELECT *
FROM AdventureWorks2019.Sales.SalesOrderHeader JOIN AdventureWorks2019.dbo.Calendar 
ON AdventureWorks2019.Sales.SalesOrderHeader.OrderDate = AdventureWorks2019.dbo.Calendar.DateValue;
--WHERE AdventureWorks2019.dbo.Calendar.WeekendFlag = 1;
