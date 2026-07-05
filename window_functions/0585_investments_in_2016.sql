-- Optimal Solution
WITH TEMP AS (
    SELECT *,
    COUNT(*) OVER (PARTITION BY tiv_2015) AS cnt1,
    COUNT(*) OVER (PARTITION BY (lat,lon)) AS cnt2
    FROM Insurance
)

SELECT ROUND(SUM(tiv_2016)::numeric,2) AS tiv_2016
FROM TEMP
WHERE cnt1 > 1 AND cnt2 = 1
-- Original solution
WITH TEMP AS (
    SELECT tiv_2015
    FROM Insurance
    GROUP BY tiv_2015
    HAVING COUNT(*) > 1
), TEMP2 AS (
    SELECT lat, lon
    FROM Insurance
    GROUP BY lat, lon
    HAVING COUNT(*) = 1
)

SELECT ROUND(SUM(tiv_2016)::numeric,2) AS tiv_2016
FROM Insurance i
WHERE (i.lat,i.lon) IN (SELECT * FROM TEMP2) AND i.tiv_2015 IN (SELECT * FROM TEMP)