-- Original Solution
WITH TEMP AS (
    SELECT reports_to, COUNT(*) AS reports_count, ROUND(AVG(age)) as average_age
    FROM Employees
    WHERE reports_to IS NOT NULL
    GROUP BY reports_to
)
SELECT e.employee_id, e.name, t.reports_count, t.average_age
FROM Employees e
JOIN TEMP t ON e.employee_id = t.reports_to
ORDER BY e.employee_id
-- Self-Join Solution
SELECT 
    e.employee_id, 
    ANY_VALUE(e.name) AS name, 
    COUNT(*) AS reports_count, 
    ROUND(AVG(t.age)) AS average_age
FROM Employees e
JOIN Employees t ON e.employee_id = t.reports_to
GROUP BY e.employee_id
ORDER BY e.employee_id 