--Exercise 1
/*
Update your calendar lookup table with a few holidays 
of your choice that always fall on the same day of the year  
for example, New Year's.
*/

USE AdventureWorks2019;

UPDATE AdventureWorks2019.dbo.Calendar
SET HolidayFlag =
CASE
WHEN DayOfMonthNumber = 1 AND MonthNumber = 1 THEN 1
WHEN DayOfMonthNumber = 4 AND MonthNumber = 7 THEN 1
WHEN DayOfMonthNumber = 11 AND MonthNumber = 11 THEN 1
WHEN DayOfMonthNumber = 25 AND MonthNumber = 12 THEN 1
ELSE 0 END;

SELECT * FROM AdventureWorks2019.dbo.Calendar;

--Exercise 2
--Using your updated calendar table, pull all purchasing orders that were made on a holiday. 

SELECT *
FROM AdventureWorks2019.Purchasing.PurchaseOrderHeader
JOIN AdventureWorks2019.dbo.Calendar 
ON AdventureWorks2019.Purchasing.PurchaseOrderHeader.OrderDate = AdventureWorks2019.dbo.Calendar.DateValue
WHERE AdventureWorks2019.dbo.Calendar.HolidayFlag = 1;
