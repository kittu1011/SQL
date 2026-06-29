-- Original Messy solution
WITH TEMP AS (
    SELECT *, RANK() OVER (PARTITION BY product_id ORDER BY change_date) AS rnk
    FROM Products
),
TEMP2 AS (
    SELECT t1.product_id, t1.new_price
    FROM TEMP t1
    LEFT JOIN TEMP t2 ON t2.product_id = t1.product_id AND t1.rnk + 1 = t2.rnk
    WHERE t1.change_date <= '2019-08-16' AND (t2.change_date is NULL OR t2.change_date > '2019-08-16')
)
SELECT DISTINCT
    p.product_id,
    COALESCE(t.new_price, 10) AS price
FROM Products p
LEFT JOIN TEMP2 t ON t.product_id = p.product_id
-- Optimal Solution
WITH TEMP AS (
    SELECT 
        product_id,
        new_price, 
        RANK() OVER (PARTITION BY product_id ORDER BY change_date DESC) AS rnk
    FROM Products
    WHERE change_date <= '2019-08-16'
)
SELECT product_id, new_price AS price
FROM Temp
WHERE rnk = 1

UNION

SELECT product_id, 10 AS price
FROM Products
WHERE product_id NOT IN (
    SELECT DISTINCT product_id FROM Products WHERE change_date <= '2019-08-16'
) 