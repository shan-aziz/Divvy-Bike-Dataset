-- Combining all data into a single table
CREATE table `combined_table_2023`
SELECT *
FROM `202301_divvy_tripdata`
UNION ALL
SELECT *
FROM `202302_divvy_tripdata`
UNION ALL
SELECT *
FROM `202303_divvy_tripdata`
UNION ALL
SELECT *
FROM `202304_divvy_tripdata`
UNION ALL
SELECT *
FROM `202305_divvy_tripdata`
UNION ALL
SELECT *
FROM `202306_divvy_tripdata`
UNION ALL
SELECT *
FROM `202307_divvy_tripdata`
UNION ALL
SELECT *
FROM `202308_divvy_tripdata`
UNION ALL
SELECT *
FROM `202309_divvy_tripdata`
UNION ALL
SELECT *
FROM `202310_divvy_tripdata`
UNION ALL
SELECT *
FROM `202311_divvy_tripdata`
UNION ALL
SELECT *
FROM `202312_divvy_tripdata`;


-- Running the analysis
SELECT
    member_casual, -- Rider type (member or casual).
    rideable_type, -- Type of vehicle.
    cast(str_to_date(substring_index(started_at, ' ', 1),'%Y-%m-%d') as date) as date, -- Extracts ride date.
    cast((substring_index(started_at, ' ', -1)) as time) as start_time, -- Extracts ride start time.
    cast((substring_index(ended_at, ' ', -1)) as time) as end_time, -- Extracts ride end time.
    TIMEDIFF(
        cast((substring_index(ended_at, ' ', -1)) as time),
        cast((substring_index(started_at, ' ', -1)) as time)
    ) as duration, -- Calculates ride duration.
    CASE
        WHEN MINUTE(TIMEDIFF(
            CAST((SUBSTRING_INDEX(ended_at, ' ', -1)) AS TIME),
            CAST((SUBSTRING_INDEX(started_at, ' ', -1)) AS TIME)
        )) <= 5 THEN '0-5 minutes'
        WHEN MINUTE(TIMEDIFF(
            CAST((SUBSTRING_INDEX(ended_at, ' ', -1)) AS TIME),
            CAST((SUBSTRING_INDEX(started_at, ' ', -1)) AS TIME)
        )) <= 10 THEN '5-10 minutes'
        WHEN MINUTE(TIMEDIFF(
            CAST((SUBSTRING_INDEX(ended_at, ' ', -1)) AS TIME),
            CAST((SUBSTRING_INDEX(started_at, ' ', -1)) AS TIME)
        )) <= 30 THEN '10-30 minutes'
        WHEN MINUTE(TIMEDIFF(
            CAST((SUBSTRING_INDEX(ended_at, ' ', -1)) AS TIME),
            CAST((SUBSTRING_INDEX(started_at, ' ', -1)) AS TIME)
        )) <= 60 THEN '30-60 minutes'
        ELSE '60+ minutes'
    END AS time_bucket, -- Categorizes ride duration into time buckets.
    CASE WEEKDAY(cast(str_to_date(substring_index(started_at, ' ', 1),'%Y-%m-%d') as date))
        WHEN 0 THEN 'Monday'
        WHEN 1 THEN 'Tuesday'
        WHEN 2 THEN 'Wednesday'
        WHEN 3 THEN 'Thursday'
        WHEN 4 THEN 'Friday'
        WHEN 5 THEN 'Saturday'
        WHEN 6 THEN 'Sunday'
    END as weekday -- Maps weekday numbers to names.
FROM combined_table_2023; -- Data source.


