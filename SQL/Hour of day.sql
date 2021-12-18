SELECT 
member_casual,
CAST(SUBSTR(started_at,INSTR(started_at,':'),-2) AS INT) AS hour_of_day,
COUNT(*) AS hour_count
FROM cyclistic_tripdata
GROUP BY 1,2
ORDER BY 2,3;