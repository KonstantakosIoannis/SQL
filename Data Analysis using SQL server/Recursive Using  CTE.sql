USE AdventureWorks2019;

--SOS loops limit=100(by default) - we can change the limit as we will se in the next example
WITH NumberSeries AS
(
SELECT
 12 AS MyNumber  --Start from number 12

UNION  ALL

SELECT 
MyNumber + 3 ----in every loop +3
FROM NumberSeries
WHERE MyNumber < 60 --until i reach 60
--WHERE MyNumber < 600 -- ERROR The maximum recursion 100 has been exhausted before statement completion
)
SELECT
MyNumber
FROM NumberSeries;



--Recursive with Dates
WITH Dates AS
(
SELECT
 CAST('01-01-2021' AS DATE) AS MyDate --REMINDER : month-day-year format

UNION ALL

SELECT
DATEADD(DAY, 1, MyDate)
FROM Dates
WHERE MyDate < CAST('12-31-2021' AS DATE)
)
SELECT
MyDate
FROM Dates
OPTION (MAXRECURSION 365) -- SOS
--This is how we extend the recursion limit

