-- Original Optimal Solution
WITH TEMP AS (
    SELECT name, salary, departmentId,
    DENSE_RANK() OVER (PARTITION BY departmentId ORDER BY salary DESC) AS rnk
    FROM Employee
)
SELECT d.name AS Department, t.name as Employee, t.salary
FROM TEMP t
JOIN Department d ON d.id = t.departmentId
WHERE t.rnk <= 3 