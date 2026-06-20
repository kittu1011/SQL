-- Original Optimal Solution
WITH TEMP AS (
    SELECT 
        player_id,
        MIN(event_date) + 1 AS goal
    FROM Activity
    GROUP BY player_id
)
SELECT ROUND(COUNT(t.player_id)::numeric / COUNT(DISTINCT a.player_id),2) AS fraction
FROM Activity a
LEFT JOIN TEMP t ON a.player_id = t.player_id AND a.event_date = t.goal