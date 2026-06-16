--Original Optimal Solution
SELECT 
    contest_id, 
    ROUND(COUNT(contest_id) * 100.0 / (SELECT COUNT(*) FROM Users),2) AS percentage
From Register
GROUP BY contest_id
ORDER BY percentage DESC, contest_id ASC