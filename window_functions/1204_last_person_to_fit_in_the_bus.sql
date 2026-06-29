-- Original Optimal Solution
WITH TEMP AS (
    SELECT person_name,
    SUM(Weight) OVER (ORDER BY Turn) AS total_weight
    FROM Queue
)
SELECT person_name
FROM TEMP
WHERE total_weight <= 1000
ORDER BY total_weight DESC
LIMIT 1