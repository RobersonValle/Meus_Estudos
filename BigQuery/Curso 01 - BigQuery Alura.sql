SELECT 
    ct.GENDER
    ,ct.TRIPDURATION/60 as duration_minutes
FROM `bigquery-public-data`.new_york_citibike.citibike_trips ct
WHERE ct.TRIPDURATION < 600 
    AND ct.TRIPDURATION >= 300 
    AND ct.GENDER = 'female'
limit 5;

---------------------------------------------------------------------------------

WITH all_trips AS (
SELECT 
    ct.GENDER
    ,ct.TRIPDURATION/60 as duration_minutes
FROM `bigquery-public-data`.new_york_citibike.citibike_trips ct)
SELECT * FROM all_trips

-----------------------------------

SELECT 
    GENDER
    ,ARRAY_AGG(NUMTRIPS ORDER BY YEAR) 
FROM 
    (SELECT GENDER,EXTRACT(YEAR FROM STARTTIME) AS YEAR, COUNT(1) AS NUMTRIPS
        FROM `bigquery-public-data`.new_york_citibike.citibike_trips AS ct
        WHERE GENDER != 'unknown' AND starttime IS NOT NULL
        GROUP BY GENDER, YEAR
        HAVING YEAR > 2016)
GROUP BY GENDER;

------------------------------------

SELECT [
    STRUCT('MALE' AS GENDER, [12,13,14] AS NUMTRIPS),
    STRUCT('FEMALE' AS GENDER, [15,16,17] AS NUMTRIPS)
] AS BIKERIDES;

-------------------------------------------------------------

SELECT ARRAY_LENGTH(BIKERIDES), BIKERIDES[OFFSET(0)].GENDER AS FIRST_GENTDER FROM
(SELECT [
    STRUCT('MALE' AS GENDER, [12,13,14] AS NUMTRIPS),
    STRUCT('FEMALE' AS GENDER, [15,16,17] AS NUMTRIPS)
] AS BIKERIDES);

-------------------------------------------------------------

SELECT ARRAY_LENGTH(BIKERIDES), BIKERIDES[OFFSET(0)].NUMTRIPS[OFFSET(0)] AS FIRST_GENTDER FROM
(SELECT [
    STRUCT('MALE' AS GENDER, [12,13,14] AS NUMTRIPS),
    STRUCT('FEMALE' AS GENDER, [15,16,17] AS NUMTRIPS)
] AS BIKERIDES);

-------------------------------------------------------------------
SELECT GENDER, NUMTRIPS[OFFSET (0)] AS FIRST_ELEMENTS FROM UNNEST
([
    STRUCT('MALE' AS GENDER, [12,13,14] AS NUMTRIPS),
    STRUCT('FEMALE' AS GENDER, [15,16,17] AS NUMTRIPS)
]);
-------------------------------------------------------------------
SELECT COUNT(starttime) as num_trips,
EXTRACT(DATE from starttime) as trip_date
FROM `bigquery-public-data`.new_york_citibike.citibike_trips
GROUP BY trip_date;

SELECT date, IF(element = 'PRCP', value/10, NULL) as prcp
FROM `bigquery-public-data.ghcn_d.ghcnd_2016`
WHERE id = `USW00094728`