USE AdventureWorks2019;
--write a query as a string variable
DECLARE @DynamicSQL VARCHAR(MAX)
SET @DynamicSQL = 'SELECT TOP 100 * FROM AdventureWorks2019.Production.Product'

SELECT @DynamicSQL --try this one first

EXEC(@DynamicSQL)--and the this one(WITHOUT the select above)

--Advanced example

SELECT MAX(ReorderPoint) FROM Production.Product WHERE MakeFlag=1;--750
SELECT AVG(ReorderPoint) FROM Production.Product WHERE MakeFlag=1;--267
SELECT AVG(ReorderPoint) FROM Production.Product WHERE MakeFlag=0;--522

DECLARE @aggFun VARCHAR(10)='AVG';--try MAX and AVG
DECLARE @flag INT = 0;--TRY 0 and 1
DECLARE @SqlDynamicX VARCHAR(MAX);

SET @SqlDynamicX = 
'SELECT ' +
@aggFun+
'(ReorderPoint) FROM Production.Product WHERE MakeFlag='+
CAST(@flag AS VARCHAR)

EXEC(@SqlDynamicX)


--better format STORED PROCEDURE : 
CREATE PROCEDURE dbo.myDynamicSQLx(@aggFunction VARCHAR(10) , @myFlag INT)
AS
BEGIN
	DECLARE @SqlDynamicX VARCHAR(MAX);
	SET @SqlDynamicX = 
	'SELECT ' +
	@aggFunction+
	'(ReorderPoint) FROM Production.Product WHERE MakeFlag='+
	CAST(@myFlag AS VARCHAR)
	EXEC(@SqlDynamicX)
END;

EXEC dbo.myDynamicSQLx 'AVG' , 0;
EXEC dbo.myDynamicSQLx 'AVG' , 1;
EXEC dbo.myDynamicSQLx 'MAX' , 0;
