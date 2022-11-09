# Fitbit User Fitness Data Analysis

Data Analysis on Fitbit users’ fitness dataset (Kaggle) to gain insight into the users activity like workout, total steps, calories and sleep.

**Dataset**: Publicly available Dataset from [Kaggle](https://www.kaggle.com/arashnic/fitbit)

**Tableau Dashboard**: Created as a part of the analysis - [Here](#data-visualization)

## About the Dataset
The dataset consists of 18 different CSVs consisting data about daily activity, hourly activity, minute based activity, sleep activity and weight log activity on 33 different users for a period of 31 days.

## Data Preparation
Description of Dataset :

1. dailyactivity - Useful data about daily steps, calories, distance, sedentary and active minutes of 33 users over 31 days
1. dailycalories - subset of dailyactivity
1. dailyintensities - subset of dailyactivity
1. dailysteps - subset of dailyactivity
1. heartrate_seconds - small dataset with only 14 users activity, will not be helpful for insights
1. hourlycalories - Insightful data about hourly activities of the all the users in the scope 
1. hourlyintensities - Insightful data about hourly activities of the all the users in the scope 
1. hourlysteps - Insightful data about hourly activities of the all the users in the scope 
1. minutecalorieswide - Data about calories burned every minute of the hour of the day
1. minutecaloriesnarrow - Data about calories burned every minute of the hour of the day but in a long format. Will not use for the analysis
1. minuteintensitiesnarrow - Data about intense activity every minute of the hour of the day
1. minuteintensitieswide - Data about intense activity every minute of the hour of the day but in a long format. Will not use for the analysis
1. minutesleep - Doesn't have valuable information for the analysis
1. minutestepsnarrow - Data about steps every minute of the hour of the day but in a long format. Will not use for the analysis
1. minutestepswide - Data about steps every minute of the hour of the day
1. sleepday - Small dataset with 24 users sleep data consisting of total time spent in bed and actual time spent in sleeping.
1. weightloginfo - No useful information found
1. minuteMETsNarrow - No useful information found

## Data Processing and Cleaning

While exploring data, date or datetime realated field was found in all the tables with different formatting and datatype was string.
Date field was updated to a propert format and Date datatype.

Unwanted datasets that does not align with the scope of the project were removed.

File : FitbitDataCleaning.sql

## Data Exploratory Analysis

Key findings from the data analysis : 
1. Most users are reaching the fitness advised 10k steps goal. Average steps of all the users over the period is only 7406 steps.
1. Popular workout day is Saturday. But Tuesday is the day where more intense workout is being done.
1. Popular workout time is in the evening between 5pm - 7pm and during 12pm
1. Sunday is the least active day. Mostly users prefer to rest on sunday
1. Users are not getting health advised 8 hours of sleep daily
1. Users spend ~30 minutes in bed awake, could be before or after sleeping

Some Data limitations and Assumptions:
1. Data pool is quite small and very old for getting any absolute insights. 
1. No gender information is available. Assumption : Sex/Gender does not play a part in findings
1. Data is recorded over 24 hours of day. Limitation: Data might be skewed because of different sleeping hours of each user
1. Some activity data are manually logged. Limitation: This might skew the analysis. 

File: FitbitDataExploration.sql

## Data Visualization

Access the Tableau Dashboard here - 
1. For [Daily Steps and Activity Analysis](https://public.tableau.com/app/profile/khushbu.v2161/viz/FitbitActivityTracker/Dashboard1?publish=yes)
2. For [Popular workout times](https://public.tableau.com/app/profile/khushbu.v2161/viz/FitbitActivityTracker/Dashboard2?publish=yes)
3. For [Sleep Time Analysis](https://public.tableau.com/app/profile/khushbu.v2161/viz/FitbitActivityTracker/Dashboard3?publish=yes)
4. For [Active Minutes in a Day](https://public.tableau.com/app/profile/khushbu.v2161/viz/FitbitActivityTracker/Dashboard4?publish=yes)



