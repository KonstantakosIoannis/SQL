--Exercise 1
/*
Create a user-defined function that returns the percent that one number is of another.
For example, if the first argument is 8 and the second argument is 10, 
the function should return the string "80.00%".
*/

CREATE FUNCTION dbo.FunEx1(@x INT, @y INT)
RETURNS VARCHAR(8) 
BEGIN
DECLARE @Decimal FLOAT  = (@x * 1.0) / @y --float division
RETURN FORMAT(@Decimal, 'P') --0.8 to 80.00% (you could try the same function without this format)
END

SELECT dbo.FunEx1(8,10)


--Exercise 2
/*
Store the maximum amount of vacation time for any individual employee in a variable.
Then create a query that displays all rows and the following columns
from the AdventureWorks2019.HumanResources.Employee table:
BusinessEntityID
JobTitle
VacationHours

Then add a derived field called "PercentOfMaxVacation",
which returns the percent an individual employees' vacation hours
are of the maximum vacation hours for any employee.
*/

DECLARE @MaxVacationHours INT = (SELECT MAX(VacationHours) FROM AdventureWorks2019.HumanResources.Employee)

SELECT
	BusinessEntityID,
	JobTitle,
	VacationHours,
	PercentOfMaxVacation = dbo.FunEx1(VacationHours, @MaxVacationHours)

FROM AdventureWorks2019.HumanResources.Employee

