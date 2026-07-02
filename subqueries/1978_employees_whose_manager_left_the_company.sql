-- Optimal Solution
SELECT employee_id
FROM Employees
WHERE manager_id NOT IN (
    SELECT employee_id
    FROM Employees
) AND salary < 30000
ORDER BY employee_id
-- Original Self-Join solution
FROM Employees e1
LEFT JOIN Employees e2 ON e1.manager_id = e2.employee_id
WHERE e1.manager_id IS NOT NULL AND e1.salary < 30000 AND e2.employee_id IS NULL
ORDER BY employee_id