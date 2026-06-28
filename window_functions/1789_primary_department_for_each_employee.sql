-- Optimal Solution
SELECT employee_id, department_id
FROM (   
    SELECT 
    employee_id, 
    department_id,
    primary_flag,
    COUNT(*) OVER (PARTITION BY employee_id) AS count
    FROM Employee
)
WHERE primary_flag = 'Y' OR count = 1
-- Original Self Join Solution
SELECT e.employee_id, e.department_id
FROM Employee e
LEFT JOIN Employee m ON e.employee_id = m.employee_id AND m.primary_flag = 'Y'
WHERE e.primary_flag = 'Y' OR m.employee_id IS NULL