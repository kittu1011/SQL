-- Original sub-optimal solution
WITH TEMP AS (
    SELECT patient_id, patient_name, STRING_TO_TABLE(conditions, ' ') as sub
    FROM Patients
), TEMP2 AS (
    SELECT DISTINCT patient_id
    FROM TEMP
    WHERE LEFT(sub,5) = 'DIAB1'
)
SELECT *
FROM Patients
WHERE patient_id IN (SELECT * FROM TEMP2)
-- Optimal Solution
SELECT *
FROM Patients
WHERE conditions LIKE 'DIAB1%' OR conditions LIKE '% DIAB1%'