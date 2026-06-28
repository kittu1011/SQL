-- Optimal Solution
SELECT DISTINCT(num) AS ConsecutiveNums
FROM (
    SELECT
        num,
        LAG(num) OVER (ORDER BY id) AS prev_one,
        LAG(num,2) OVER (ORDER BY id) AS prev_two
    FROM Logs
)
WHERE prev_one = num AND prev_one = prev_two
-- Original self join solution
SELECT 
    DISTINCT(i.num) AS ConsecutiveNums
FROM Logs i
JOIN Logs j ON j.id = i.id + 1 AND i.num = j.num
JOIN Logs k ON k.id = j.id + 1 AND j.num = k.num