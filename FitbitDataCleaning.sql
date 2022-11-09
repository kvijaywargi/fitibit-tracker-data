/* 
Data Cleaning - FitBit Fitness Tracker Data
Data Source - www.kaggle.com
*/

-- While exploring data, date or datetime realted field was found in all the tables but the datatype was string
-- str_to_date() automatically formats the date to yyyy-mm-dd
select ActivityDate, str_to_date(ActivityDate,'%m/%d/%Y') FROM da_project.dailyactivity;

update dailyactivity set ActivityDate = str_to_date(ActivityDate, '%m/%d/%Y');
update dailycalories set ActivityDay = str_to_date(ActivityDay, '%m/%d/%Y');
update dailyintensities set ActivityDay = str_to_date(ActivityDay, '%m/%d/%Y');
update dailysteps set ActivityDay = str_to_date(ActivityDay, '%m/%d/%Y');

-- date field of 24hr format
update heartrate_seconds set Time = str_to_date(Time, '%m/%d/%Y %r'); 

update hourlycalories set ActivityHour = str_to_date(ActivityHour, '%m/%d/%Y %r'); 
update hourlyintensities set ActivityHour = str_to_date(ActivityHour, '%m/%d/%Y %r'); 
update hourlysteps set ActivityHour = str_to_date(ActivityHour, '%m/%d/%Y %r'); 

update minutecalorieswide set ActivityHour = str_to_date(ActivityHour, '%m/%d/%Y %r'); 
update minuteintensitieswide set ActivityHour = str_to_date(ActivityHour, '%m/%d/%Y %r'); 
update minutestepswide set ActivityHour = str_to_date(ActivityHour, '%m/%d/%Y %r'); 
-- update minutecaloriesnarrow set ActivityMinute = str_to_date(ActivityMinute, '%m/%d/%Y %r'); 
update minuteintensitiesnarrow set ActivityMinute = str_to_date(ActivityMinute, '%m/%d/%Y %r'); 
update minutestepsnarrow set ActivityMinute = str_to_date(ActivityMinute, '%m/%d/%Y %r'); 

update minutesleep set date = str_to_date(date, '%m/%d/%Y %r'); 
update sleepday set sleepday = str_to_date(sleepday, '%m/%d/%Y %r'); 
update weightloginfo set Date = str_to_date(Date, '%m/%d/%Y %r'); 

-- Changing data type 

alter table dailyactivity modify ActivityDate date;
alter table dailycalories modify ActivityDay date;
alter table dailyintensities modify ActivityDay date;
alter table dailysteps modify ActivityDay date;

alter table heartrate_seconds modify Time datetime;

alter table hourlycalories modify ActivityHour datetime;
alter table hourlyintensities modify ActivityHour datetime;
alter table hourlysteps modify ActivityHour datetime;

alter table minutecalorieswide modify ActivityHour datetime;
alter table minuteintensitieswide modify ActivityHour datetime;
alter table minutestepswide modify ActivityHour datetime;
-- alter table minutecaloriesnarrow modify ActivityMinute datetime;
alter table minuteintensitiesnarrow modify ActivityMinute datetime;
alter table minutestepsnarrow modify ActivityMinute datetime;

alter table minutesleep modify date datetime;
alter table sleepday modify sleepday datetime;
alter table weightloginfo modify date datetime;








