
--  Which rideable type do casuals and members prefer?
SELECT member_casual, rideable_type, COUNT(rideable_type) AS rideable_count
FROM cyclistic_tripdata
GROUP BY member_casual, rideable_type
ORDER BY member_casual DESC, rideable_count DESC;

--  What is the average ride length for each member type
SELECT member_casual, day_of_week, ROUND(AVG(ride_length),3) AS average_ride_length
FROM cyclistic_tripdata
GROUP BY member_casual, day_of_week
ORDER BY member_casual DESC, average_ride_length DESC;