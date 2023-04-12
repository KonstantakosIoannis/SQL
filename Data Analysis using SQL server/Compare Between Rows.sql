CREATE TABLE loans 
(
  id INT,
  price INT,
  months INT
);


INSERT INTO loans (id, price, months)
VALUES (1, 100, 1),
       (1, 300, 2),
       (1, 200, 3),
	   (3, 20, 8),
	   (3, 2, 9),
	   (3, 2000, 10),
	   (3, 45, 11);


SELECT * FROM loans;

SELECT * FROM loans as l1
inner join loans as l2
on l1.id=l2.id
AND l1.months BETWEEN (l2.months-2) AND  (l2.months) 
order by l2.months;

SELECT l2.id , l2.months , MAX(l1.price) as XYZ FROM loans as l1
inner join loans as l2
on l1.id=l2.id
AND l1.months BETWEEN (l2.months-2) AND  (l2.months) 
GROUP BY l2.id , l2.months ;



