SELECT e2.name
FROM Employee e1
JOIN Employee e2 ON e1.managerId = e2.id -- self join
GROUP BY e1.managerId,e2.name 
HAVING COUNT(*) >= 5