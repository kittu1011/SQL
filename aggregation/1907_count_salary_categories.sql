-- unnest solution with array only works with PostgreSQL
SELECT unnest(array['Low Salary', 'High Salary', 'Average Salary']) AS category,
    unnest(array[
        SUM(CASE WHEN income < 20000 THEN 1 ELSE 0 END),
        SUM(CASE WHEN income > 50000 THEN 1 ELSE 0 END), 
        SUM(CASE WHEN income >= 20000 AND income <= 50000 THEN 1 ELSE 0 END)
        ]) AS accounts_count
FROM Accounts
-- Less optimal but safer solution
SELECT 'Low Salary' AS category,
COUNT(*) AS accounts_count
FROM Accounts
WHERE income < 20000

UNION

SELECT 'High Salary' AS category,
COUNT(*) AS accounts_count
FROM Accounts
WHERE income > 50000

UNION

SELECT 'Average Salary' AS category,
COUNT(*) AS accounts_count
FROM Accounts
WHERE income >= 20000 AND income <= 50000