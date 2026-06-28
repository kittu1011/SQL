-- Original Optimal Solution
SELECT 
    *,
    CASE 
        WHEN (x < (y + z) and y < (x + z) and z < (y + x)) THEN 'Yes'
        ELSE 'No'
    END AS triangle
FROM Triangle