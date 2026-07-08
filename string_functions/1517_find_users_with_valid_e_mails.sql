-- Original Optimal Solution
SELECT *
FROM Users
WHERE mail ~ '^[A-Za-z][A-Za-z0-9_.-]*@leetcode\.com$'
 -- postgre doesn't need '\\' to escape character in postgre thereforc '\.' is correct 