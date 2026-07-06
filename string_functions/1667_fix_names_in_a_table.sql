-- Original Optimal Solution
SELECT user_id, 
UPPER(LEFT(name,1)) || LOWER(SUBSTR(name,2)) AS name
FROM Users
ORDER BY user_id