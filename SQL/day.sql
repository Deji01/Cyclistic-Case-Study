SELECT
member_casual,
CASE
	WHEN CAST(day_of_week AS INT) = 1 THEN 'Sunday'
	WHEN CAST(day_of_week AS INT) = 2 THEN 'Monday'
	WHEN CAST(day_of_week AS INT) = 3 THEN 'Tuesday'
	WHEN CAST(day_of_week AS INT) = 4 THEN 'Wednesday'
	WHEN CAST(day_of_week AS INT) = 5 THEN 'Thursday'
	WHEN CAST(day_of_week AS INT) = 6 THEN 'Friday'
	WHEN CAST(day_of_week AS INT) = 7 THEN 'Saturday'

	ELSE NULL
END	day,
COUNT(*) AS ride_count,
ROUND(AVG((CAST(SUBSTR(ride_length,INSTR(ride_length,':'),-2) AS INT) * 60) + 
(CAST(SUBSTR(ride_length,3,2) AS INT) ) +
(CAST(SUBSTR(ride_length,6,2) AS INT) / 60)),2) AS average_duration
FROM cyclistic_tripdata
GROUP BY 1,2
ORDER BY 2
