USE AdventureWorks2019;

--EXERCISE 1
/*
Using PIVOT, write a query against the HumanResources.Employee table
that summarizes the average amount of vacation time for Sales Representatives, Buyers, and Janitors.
*/
SELECT * FROM HumanResources.Employee;

--With group by
SELECT JobTitle , AVG(VacationHours)
FROM HumanResources.Employee
GROUP BY JobTitle
HAVING JobTitle IN('Buyer','Janitor','Sales Representative');

--With pivot 
SELECT * FROM
(SELECT JobTitle , VacationHours
FROM HumanResources.Employee) AS alpha
PIVOT
(
AVG(VacationHours)
FOR JobTitle IN(Buyer,Janitor,[Sales Representative])
)AS beta

--With CASE
SELECT
AVG(CASE WHEN JobTitle='Buyer' THEN VacationHours END),
AVG(CASE WHEN JobTitle='Janitor' THEN VacationHours END),
AVG(CASE WHEN JobTitle='Sales Representative' THEN VacationHours END)
FROM HumanResources.Employee;


--EXERCISE 2
/*
Modify your query from Exercise 1 
such that the results are broken out by Gender. 
Alias the Gender field as "Employee Gender" in your output.
*/

--Pivot
SELECT * FROM
(SELECT JobTitle , VacationHours ,Gender as [Employee Gender]
FROM HumanResources.Employee) AS alpha
PIVOT
(
AVG(VacationHours)
FOR JobTitle IN(Buyer,Janitor,[Sales Representative])
)AS beta


--Group By
SELECT JobTitle , AVG(VacationHours) , Gender
FROM HumanResources.Employee
GROUP BY JobTitle , Gender
HAVING JobTitle IN('Buyer','Janitor','Sales Representative');


--Case
SELECT
AVG(CASE WHEN JobTitle='Buyer' AND Gender='F' THEN VacationHours END) AS Buyer_Female ,
AVG(CASE WHEN JobTitle='Buyer' AND Gender='M' THEN VacationHours END) AS Buyer_Male,
AVG(CASE WHEN JobTitle='Janitor' AND Gender='F' THEN VacationHours END) AS Janitor_Female ,
AVG(CASE WHEN JobTitle='Janitor' AND Gender='M' THEN VacationHours END) AS Janitor_Male,
AVG(CASE WHEN JobTitle='Sales Representative' AND Gender='F' THEN VacationHours END) AS SalesRepresentative_Female ,
AVG(CASE WHEN JobTitle='Sales Representative' AND Gender='M' THEN VacationHours END) AS SalesRepresentative_Male
FROM HumanResources.Employee;
