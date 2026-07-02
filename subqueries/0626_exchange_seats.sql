-- Optimal Solution
SELECT 
    CASE 
        WHEN id % 2 = 1 AND id = (SELECT MAX(ID) FROM SEAT) THEN id
        WHEN id % 2 = 0 THEN id - 1
        ELSE id + 1
    END AS id, student
FROM Seat
ORDER BY id
-- Original Sub-optimal solution self join solution
SELECT * 
FROM
(SELECT s1.id, s2.student
FROM Seat s1
JOIN Seat s2 ON s1.id = s2.id - 1
WHERE s1.id % 2 = 1

UNION

SELECT s1.id, s2.student
FROM Seat s1
JOIN Seat s2 ON s1.id = s2.id + 1
WHERE s1.id % 2 = 0

UNION

SELECT s1.id, s1.student
FROM Seat s1
LEFT JOIN Seat s2 ON s1.id = s2.id - 1
WHERE s1.id % 2 = 1 AND s2.id IS NULL)
ORDER BY id