/* 
Data Exploration - FitBit Fitness Tracker Data
Data Source - www.kaggle.com
Data Collaborator - Möbius (Owner)
*/

SELECT 
    COUNT(DISTINCT Id)
FROM
    dailyactivity;

-- dailyIntensities, dailyCalories and dailySteps table are subsets of dailyActivity table
-- all of them contain same number of records #940
SELECT 
    *
FROM
    dailyactivity act,
    dailyintensities intn
WHERE
    act.Id = intn.Id
        AND act.ActivityDate = intn.ActivityDay;

SELECT 
    *
FROM
    dailyactivity act,
    dailycalories cal
WHERE
    act.Id = cal.Id
        AND act.ActivityDate = cal.ActivityDay;

SELECT 
    *
FROM
    dailyactivity act,
    dailySteps stp
WHERE
    act.Id = stp.Id
        AND act.ActivityDate = stp.ActivityDay;

-- Count of days recorded for each user (max 31 days)
SELECT 
    Id, COUNT(DISTINCT ActivityDate)
FROM
    dailyactivity
GROUP BY Id
ORDER BY 2 DESC;

-- ActivityDate field is String, parsing it in Date first
-- Data collection period recorded is from 2016-04-12 to 2016-05-12
-- some users have recorded data for whole period, others have recorded for less than 31 days
SELECT 
    MIN(STR_TO_DATE(ActivityDate, '%m/%d/%Y')),
    MAX(STR_TO_DATE(ActivityDate, '%m/%d/%Y'))
FROM
    dailyactivity;


-- hourlyCalories, hourlyIntensities and hourlySteps combinely shows hourly activity of a user
-- all of them contain same number of records #22099
SELECT 
    COUNT(*)
FROM
    hourlycalories;

-- lets join all of them for hourly based summary

SELECT 
    cal.Id ID,
    cal.ActivityHour ActivityHour,
    cal.Calories Calories,
    stp.StepTotal TotalSteps,
    intn.TotalIntensity TotalIntensity,
    intn.AverageIntensity AvgIntensity
FROM
    hourlycalories cal,
    hourlyintensities intn,
    hourlysteps stp
WHERE
    cal.Id = intn.Id
        AND cal.ActivityHour = intn.ActivityHour
        AND cal.Id = stp.Id
        AND cal.ActivityHour = stp.ActivityHour;

-- Average daily activity of users
SELECT 
    id,
    AVG(totalsteps),
    AVG(calories),
    AVG(totaldistance),
    AVG(VeryActiveDistance),
    AVG(ModeratelyActiveDistance),
    AVG(LightActiveDistance),
    AVG(SedentaryActiveDistance),
    AVG(VeryActiveMinutes),
    AVG(FairlyActiveMinutes),
    AVG(LightlyActiveMinutes),
    AVG(SedentaryMinutes)
FROM
    dailyactivity
GROUP BY 1
ORDER BY 3 DESC;


-- ******** Deriving useful and meaningful data for visualizations *******
SELECT 
    *
FROM
    dailyactivity;

-- 1. Daily Activity Summary


CREATE TABLE dailyActivitySummary AS (SELECT id,
    activityDate,
    totalSteps,
    totalDistance,
    Calories,
    (VeryActiveMinutes + FairlyActiveMinutes + LightlyActiveMinutes) AS totalActivityTime,
    VeryActiveMinutes AS intenseActivityTime,
    SedentaryMinutes AS idleTime FROM
    dailyactivity
ORDER BY id , activityDate);

-- 2. Daily Sleep Summary
CREATE TABLE sleepDaySummary AS (SELECT id,
    sleepDay AS sleepDate,
    TotalSleepRecords,
    TotalMinutesAsleep,
    TotalTimeInBed,
    (TotalTimeInBed - TotalMinutesAsleep) AS awakeInBed FROM
    sleepday
ORDER BY id , sleepday);

-- 3. Daily Weightlog Summary
SELECT 
    id, Date AS weightDate, WeightKg, WeightPounds, BMI
FROM
    weightloginfo
ORDER BY id , Date;

-- 4. Hourly Activity Summary
CREATE TABLE hourlyActivitySummary AS (SELECT cal.Id ID,
    cal.ActivityHour ActivityHour,
    cal.Calories Calories,
    stp.StepTotal TotalSteps,
    intn.TotalIntensity TotalIntensity,
    intn.AverageIntensity AvgIntensity FROM
    hourlycalories cal,
    hourlyintensities intn,
    hourlysteps stp
WHERE
    cal.Id = intn.Id
        AND cal.ActivityHour = intn.ActivityHour
        AND cal.Id = stp.Id
        AND cal.ActivityHour = stp.ActivityHour);

-- 5. Week Segment based Activity Summary

-- set some variables for segregated analysis
set @morningStart='06:00:00', @morningEnd= '12:00:00', @noonEnd='18:00:00' , @eveEnd='21:00:00';
set @officeHourStart='09:00:00', @officeHourEnd='05:00:00', @sleepHourStart='22:00:00';

SELECT 
    CASE
        WHEN DATE_FORMAT(ActivityHour, '%W') IN ('Sunday' , 'Saturday') THEN 'Weekend'
        ELSE 'Weekday'
    END AS part_of_week,
    DATE_FORMAT(ActivityHour, '%W') AS day_of_week,
    CASE
        WHEN TIME(ActivityHour) BETWEEN @morningstart AND @morningEnd THEN 'Morning'
        WHEN TIME(ActivityHour) BETWEEN @morningEnd AND @noonEnd THEN 'Afternoon'
        WHEN TIME(ActivityHour) BETWEEN @noonEnd AND @eveEnd THEN 'Evening'
        ELSE 'Night'
    END AS time_of_day,
    SUM(TotalSteps) AS total_steps,
    AVG(TotalSteps) AS avg_steps,
    SUM(Calories) AS total_calories,
    AVG(Calories) AS avg_calories,
    SUM(TotalIntensity) AS total_intensity,
    AVG(TotalIntensity) AS avg_intensity
FROM
    hourlyActivitySummary
GROUP BY 1 , 2 , 3

