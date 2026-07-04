-- Original Optimal Solution
WITH TEMP AS (
    SELECT visited_on, SUM(amount) as sum
    FROM  Customer
    GROUP BY visited_on
)
SELECT visited_on,
    SUM(sum) OVER (
        ORDER BY visited_on
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) AS amount,
    ROUND(AVG(sum) OVER (
        ORDER BY visited_on
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ),2) AS average_amount
FROM TEMP
ORDER BY visited_on
OFFSET 6