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

SELECT * FROM loans AS l1
INNER JOIN loans AS l2
ON l1.id=l2.id
AND l1.months BETWEEN (l2.months-2) AND  (l2.months) 
ORDER BY l2.months;

SELECT l2.id , l2.months , MAX(l1.price) AS XYZ FROM loans AS l1
INNER JOIN loans AS l2
ON l1.id=l2.id
AND l1.months BETWEEN (l2.months-2) AND  (l2.months) 
GROUP BY l2.id , l2.months ;



