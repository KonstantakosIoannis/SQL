USE MyEx02 ;

SELECT * FROM myPivot;

UPDATE myPivot
SET ID='C'
WHERE ID='A';

UPDATE myPivot
SET ID='A'
WHERE ID='C';





UPDATE myPivot
SET LineTotal=LineTotal+999;


UPDATE myPivot
SET LineTotal=LineTotal-999;



ALTER TABLE myPivot
ADD XXX INT;

SELECT * FROM myPivot;


UPDATE myPivot
SET XXX=LineTotal+999;


DELETE FROM myPivot
WHERE XXX=1540;



ALTER TABLE myPivot
DROP COLUMN XXX;

