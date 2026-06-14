-- Original solution
SELECT p.product_id, 
    CASE
        WHEN SUM(u.units) IS NULL THEN 0
        ELSE ROUND(SUM(u.units * p.price) * 1.0 / SUM(u.units),2) -- numeric operation on NULL returns NULL
    END AS average_price
FROM Prices p
LEFT JOIN UnitsSold u ON p.product_id = u.product_id AND u.purchase_date BETWEEN p.start_date AND p.end_date
GROUP BY p.product_id
-- Cleaner solution that uses coalesce
SELECT p.product_id, 
    ROUND(COALESCE(SUM(u.units * p.price) * 1.0 / SUM(u.units),0),2) -- coalesce will return the first non-null value in its args
    AS average_price
FROM Prices p
LEFT JOIN UnitsSold u ON p.product_id = u.product_id AND u.purchase_date BETWEEN p.start_date AND p.end_date
GROUP BY p.product_id
