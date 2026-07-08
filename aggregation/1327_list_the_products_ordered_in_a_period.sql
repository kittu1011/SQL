-- Original Optiamal Solution
SELECT ANY_VALUE(p.product_name) AS product_name, SUM(o.unit) AS unit
FROM Orders o
JOIN Products p ON o.product_id = p.product_id
WHERE o.order_date BETWEEN '2020-02-1' AND '2020-02-29'
GROUP BY o.product_id
HAVING SUM(o.unit) >= 100