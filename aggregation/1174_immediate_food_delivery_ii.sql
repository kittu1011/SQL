-- Unconventional solution that works because order_date <= customer_pref_delivery_date
With TEMP AS (
    SELECT 
        customer_id,
        MIN(order_date) AS first_order,
        MIN(customer_pref_delivery_date) AS pref_date -- not guaranteed to be from same row as first_order if it is not immediate order 
    FROM Delivery
    GROUP BY customer_id
)
SELECT
ROUND(SUM(CASE WHEN first_order = pref_date THEN 100.0 ELSE 0.0 END) / COUNT(*),2) AS immediate_percentage 
FROM TEMP

-- Clean window function approach
With TEMP AS (
    SELECT 
        order_date = customer_pref_delivery_date AS is_immediate,
        ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date) AS n
    FROM Delivery
)
SELECT
ROUND(AVG(is_immediate::int) * 100,2) AS immediate_percentage 
FROM TEMP
WHERE n < 2

-- ugly window function approach
With TEMP AS (
    SELECT 
        customer_id,
        order_date,
        customer_pref_delivery_date,
        ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date) AS n
    FROM Delivery
)
SELECT
ROUND(SUM(
    CASE 
        WHEN order_date = customer_pref_delivery_date THEN 100.0
        ELSE 0.0
    END
) / COUNT(*),2) AS immediate_percentage 
FROM TEMP
WHERE n < 2