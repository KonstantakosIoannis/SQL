--Exercise 1
/*
Create a query with the following columns:
FirstName and LastName, from the Person.Person table**
JobTitle, from the HumanResources.Employee table**
Rate, from the HumanResources.EmployeePayHistory table**
A derived column called "AverageRate" that returns the average of all values in the "Rate" column, in each row

**All the above tables can be joined on BusinessEntityID
All the tables can be inner joined, and you do not need to apply any criteria.
*/

--SOLUTION
--There are many ways to solve a task. Here is mine but feel free to explore more and fine your own way
--first lets have a look to these 3 tables
SELECT * FROM Person.Person;
SELECT * FROM HumanResources.Employee;
SELECT * FROM HumanResources.EmployeePayHistory;

--INNER JOIN the first two tables Person.Person and HumanResources.Employee
SELECT Person.Person.FirstName , Person.Person.LastName ,
HumanResources.Employee.JobTitle
FROM Person.Person INNER JOIN HumanResources.Employee
ON Person.Person.BusinessEntityID=HumanResources.Employee.BusinessEntityID; 

--inner join the third one HumanResources.EmployeePayHistory
SELECT Person.Person.FirstName , Person.Person.LastName ,
HumanResources.Employee.JobTitle,
HumanResources.EmployeePayHistory.Rate,
AVG(Rate)OVER() as AverageRate
FROM Person.Person INNER JOIN HumanResources.Employee
ON Person.Person.BusinessEntityID=HumanResources.Employee.BusinessEntityID
INNER JOIN HumanResources.EmployeePayHistory 
ON HumanResources.EmployeePayHistory.BusinessEntityID=HumanResources.Employee.BusinessEntityID; 

--another way to do it is with tables alias : 
SELECT 
 B.FirstName,
 B.LastName,
 C.JobTitle,
 A.Rate,
 AverageRate = AVG(A.Rate) OVER()

FROM AdventureWorks2019.HumanResources.EmployeePayHistory A
	JOIN AdventureWorks2019.Person.Person B
		ON A.BusinessEntityID = B.BusinessEntityID
	JOIN AdventureWorks2019.HumanResources.Employee C
		ON A.BusinessEntityID = C.BusinessEntityID;
--but i dont really like this form in these kind of queries




--Exercise 2
/*
Enhance your query from Exercise 1 by adding a derived column called
"MaximumRate" that returns the largest of all values in the "Rate" column, in each row
*/

SELECT Person.Person.FirstName , Person.Person.LastName ,
HumanResources.Employee.JobTitle,
HumanResources.EmployeePayHistory.Rate,
AVG(Rate)OVER() as AverageRate,
MAX(Rate)OVER() as MaximumRate
FROM Person.Person INNER JOIN HumanResources.Employee
ON Person.Person.BusinessEntityID=HumanResources.Employee.BusinessEntityID
INNER JOIN HumanResources.EmployeePayHistory 
ON HumanResources.EmployeePayHistory.BusinessEntityID=HumanResources.Employee.BusinessEntityID; 



--Exercise 3
/*
Enhance your query from Exercise 2 by adding a derived column called
"DiffFromAvgRate" that returns the result of the following calculation:
An employees's pay rate, MINUS the average of all values in the "Rate" column.
*/

SELECT Person.Person.FirstName , Person.Person.LastName ,
HumanResources.Employee.JobTitle,
HumanResources.EmployeePayHistory.Rate,
AVG(Rate)OVER() as AverageRate,
MAX(Rate)OVER() as MaximumRate,
(Rate-AVG(Rate)OVER()) as DiffFromAvgRate
FROM Person.Person INNER JOIN HumanResources.Employee
ON Person.Person.BusinessEntityID=HumanResources.Employee.BusinessEntityID
INNER JOIN HumanResources.EmployeePayHistory 
ON HumanResources.EmployeePayHistory.BusinessEntityID=HumanResources.Employee.BusinessEntityID; 




--Exercise 4
/*
Enhance your query from Exercise 3 by adding a derived column called
"PercentofMaxRate" that returns the result of the following calculation:
An employees's pay rate, DIVIDED BY the maximum of all values in the "Rate" column, times 100.
*/

SELECT Person.Person.FirstName , Person.Person.LastName ,
HumanResources.Employee.JobTitle,
HumanResources.EmployeePayHistory.Rate,
AVG(Rate)OVER() as AverageRate,
MAX(Rate)OVER() as MaximumRate,
(Rate-AVG(Rate)OVER()) as DiffFromAvgRate,
(Rate/MAX(Rate)OVER()*100)as PercentofMaxRate
FROM Person.Person INNER JOIN HumanResources.Employee
ON Person.Person.BusinessEntityID=HumanResources.Employee.BusinessEntityID
INNER JOIN HumanResources.EmployeePayHistory 
ON HumanResources.EmployeePayHistory.BusinessEntityID=HumanResources.Employee.BusinessEntityID; 
