-- Count by day of week
SELECT 
day_of_week, 
COUNT(*) as day_count
FROM 
cyclistic_tripdata
GROUP BY 
day_of_week
ORDER BY 
day_count DESC;

-- 	Member casual by day of week
SELECT 
member_casual,
day_of_week, 
COUNT(*) as day_count
FROM 
cyclistic_tripdata
GROUP BY 
member_casual, day_of_week
ORDER BY 
member_casual, day_count DESC;

-- 	Member casual duration
SELECT
member_casual,
SUM(CAST(SUBSTR(ride_length, 3,2) AS INT) + CAST(SUBSTR(ride_length, 6,2) AS INT) / 60) AS total_duration
FROM 
cyclistic_tripdata
GROUP BY 
member_casual
ORDER BY 
member_casual, total_duration DESC;