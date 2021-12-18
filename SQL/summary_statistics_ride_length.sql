-- SUMMARY STATISTICS 
SELECT 
MAX(CAST(SUBSTR(ride_length, 3,2) AS INT) + CAST(SUBSTR(ride_length, 6,2) AS INT) / 60) AS max_ride_length,
MIN(CAST(SUBSTR(ride_length, 3,2) AS INT) + CAST(SUBSTR(ride_length, 6,2) AS INT) / 60) AS min_ride_length,
AVG(CAST(SUBSTR(ride_length, 3,2) AS INT) + CAST(SUBSTR(ride_length, 6,2) AS INT) / 60) AS average_ride_length
FROM cyclistic_tripdata;