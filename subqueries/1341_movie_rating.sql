-- More elegant solution
(
    SELECT ANY_VALUE(u.name) as results
    FROM MovieRating m
    JOIN Users u ON u.user_id = m.user_id
    GROUP BY m.user_id
    ORDER BY COUNT(*) DESC, ANY_VALUE(u.name) ASC
    LIMIT 1
)
UNION ALL
(
    SELECT ANY_VALUE(m.title)
    FROM MovieRating t
    JOIN Movies m ON m.movie_id = t.movie_id
    WHERE t.created_at >= '2020-02-1' AND t.created_at < '2020-03-1'
    GROUP BY t.movie_id
    ORDER by AVG(t.rating) DESC, ANY_VALUE(m.title) ASC
    LIMIT 1
)
-- Original Optimal Solution
(SELECT u.name as results
FROM (SELECT user_id, COUNT(*) AS cnt
    FROM MovieRating
    GROUP BY user_id) AS t
JOIN Users u ON u.user_id = t.user_id
ORDER BY t.cnt DESC, u.name ASC
LIMIT 1)

UNION ALL

(SELECT m.title as results
FROM (SELECT movie_id, AVG(rating) as avg
    FROM MovieRating
    WHERE created_at >= '2020-02-1' AND created_at < '2020-03-1'
    GROUP BY movie_id) AS t
JOIN Movies m ON m.movie_id = t.movie_id
ORDER by t.avg DESC, m.title ASC
LIMIT 1)

