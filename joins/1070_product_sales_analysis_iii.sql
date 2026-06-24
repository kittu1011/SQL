-- Original Join solution
WITH TEMP AS (
    SELECT
        product_id,
        MIN(year) as year
    FROM Sales
    GROUP BY product_id
)
SELECT
    s.product_id,
    s.year AS first_year,
    s.quantity AS quantity,
    s.price as price
FROM Sales s
JOIN TEMP t ON t.product_id = s.product_id AND s.year = t.year
-- Sub-query solution
SELECT
    s.product_id,
    s.year AS first_year,
    s.quantity AS quantity,
    s.price as price
FROM Sales s
WHERE (s.product_id, s.year) IN (
    SELECT product_id, MIN(year)
    FROM Sales
    GROUP BY product_id
)
-- Window function solution
SELECT
    product_id,
    year AS first_year,
    quantity,
    price   
FROM (
    SELECT *, DENSE_RANK() OVER(PARTITION BY product_id ORDER BY year) as rank
    FROM Sales
)
WHERE rank = 1