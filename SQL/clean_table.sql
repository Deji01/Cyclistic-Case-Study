-- Selecting all rows with headers
SELECT *
FROM cyclistic_tripdata
WHERE field1 = 'ride_id';

-- Deleting the selected rows 
DELETE
FROM cyclistic_tripdata
WHERE field1 = 'ride_id';