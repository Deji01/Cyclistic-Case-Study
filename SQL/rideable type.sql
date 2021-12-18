SELECT
member_casual,
rideable_type,
CAST(SUBSTR(started_at,4,2) AS INT) AS month,
CAST(SUBSTR(started_at,7,4) AS INT) AS year,
CASE
	WHEN CAST(SUBSTR(started_at,4,2) AS INT) = 1 THEN 'January'
	WHEN CAST(SUBSTR(started_at,4,2) AS INT) = 2 THEN 'February'
	WHEN CAST(SUBSTR(started_at,4,2) AS INT) = 3 THEN 'March'
	WHEN CAST(SUBSTR(started_at,4,2) AS INT) = 4 THEN 'April'
	WHEN CAST(SUBSTR(started_at,4,2) AS INT) = 5 THEN 'May'
	WHEN CAST(SUBSTR(started_at,4,2) AS INT) = 6 THEN 'June'
	WHEN CAST(SUBSTR(started_at,4,2) AS INT) = 7 THEN 'July'
	WHEN CAST(SUBSTR(started_at,4,2) AS INT) = 8 THEN 'August'
	WHEN CAST(SUBSTR(started_at,4,2) AS INT) = 9 THEN 'September'
	WHEN CAST(SUBSTR(started_at,4,2) AS INT) = 10 THEN 'October'
	WHEN CAST(SUBSTR(started_at,4,2) AS INT) = 11 THEN 'November'
	WHEN CAST(SUBSTR(started_at,4,2) AS INT) = 12 THEN 'December'
	ELSE NULL
END	month_name,
COUNT(*) AS ride_count
FROM cyclistic_tripdata
GROUP BY 1,2,5
ORDER BY 4 ASC,3 ASC
