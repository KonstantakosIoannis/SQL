--Exercise 1
--Use a recursive CTE to generate a list of all odd numbers between 1 and 100.

USE AdventureWorks2019;

WITH Odds AS
(
SELECT 1 AS MyOddNumber
UNION  ALL
SELECT MyOddNumber + 2
FROM Odds
WHERE MyOddNumber < 99
)
SELECT MyOddNumber
FROM Odds;




--Exercise 2
--Use a recursive CTE to generate a date series of all FIRST days of the month (1/1/2021, 2/1/2021, etc.)
--from 1/1/2020 to 12/1/2029.

WITH Dates AS
(
SELECT
 CAST('01-01-2020' AS DATE) AS MyDate

UNION ALL

SELECT
DATEADD(MONTH, 1, MyDate)
FROM Dates
WHERE MyDate < CAST('12-01-2029' AS DATE)
)
SELECT
MyDate
FROM Dates
OPTION (MAXRECURSION 120)