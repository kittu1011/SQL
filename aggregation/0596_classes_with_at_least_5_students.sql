-- Original Optimal Solution
SELECT class
FROM Courses
GROUP BY class
HAVING COUNT(*) > 4