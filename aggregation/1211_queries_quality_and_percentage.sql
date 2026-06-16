-- Most elegant solution using a case statement
SELECT
    query_name, 
    ROUND(AVG(rating * 1.0 / position),2) as quality, 
    ROUND((SUM(CASE WHEN rating < 3 THEN 100.0 ELSE 0.0 END)) / COUNT(*), 2) as poor_query_percentage 
FROM Queries
GROUP BY query_name

-- Original but inefficient and ugly solution, uses coalesce and nested subquery
SELECT q1.query_name, ROUND(AVG(q1.rating * 1.0 / q1.position),2) as quality, 
    coalesce(ROUND((
        SELECT COUNT(*) * 100.0
        FROM Queries q2
        WHERE q2.rating < 3 AND q1.query_name = q2.query_name
        GROUP BY query_name
    ) / COUNT(*), 2),0) as poor_query_percentage 
FROM Queries q1
GROUP BY q1.query_name

-- WRONG SOLUTION if subquery returns nothing poor_query_percentage becomes NULL not zero
SELECT q1.query_name, ROUND(AVG(q1.rating * 1.0 / q1.position),2) as quality, 
    ROUND((
        SELECT COUNT(*) * 100.0
        FROM Queries q2
        WHERE q2.rating < 3 AND q1.query_name = q2.query_name
        GROUP BY query_name
    ) / COUNT(*), 2) as poor_query_percentage 
FROM Queries q1
GROUP BY q1.query_name