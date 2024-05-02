-- create a join table
SELECT * FROM Absenteeism_at_work AS a
LEFT JOIN compensation AS b
ON a.ID = b.ID
LEFT JOIN Reasons AS r
ON a.Reason_for_absence = r.Number

-- Filtering the healthy people
SELECT * FROM Absenteeism_at_work
WHERE Social_drinker = 0 AND Social_smoker = 0 AND Body_mass_index < 25 AND
Absenteeism_time_in_hours < (SELECT AVG(Absenteeism_time_in_hours) FROM Absenteeism_at_work)

-- Number of people who don't smoke
SELECT COUNT(*) AS Non_Smoker FROM Absenteeism_at_work
WHERE Social_smoker = 0

-- Optimizing the query
SELECT
a.ID,
r.Reason,
Month_of_absence,
CASE WHEN Month_of_absence IN (3,4,5) THEN 'Summer'
     WHEN Month_of_absence IN (6,7,8,9,10) THEN 'Rainy Season'
	 WHEN Month_of_absence IN (11,12,1,2) THEN 'Winter' 
	 ELSE 'Other' END AS Season_Name,
Body_mass_index,
CASE WHEN Body_mass_index < 18.5 THEN 'Underweight'
	 WHEN Body_mass_index BETWEEN 18.5 AND 25 THEN 'Healthy Weight'
	 WHEN Body_mass_index BETWEEN 25 AND 30 THEN 'Overweight'
	 WHEN Body_mass_index > 30 THEN 'Obese'
	 ELSE 'Unknown' END AS BMI_Category,
Day_of_the_week,
Transportation_expense,
Education,
Son,
Social_drinker,
Social_smoker,
Pet,
Disciplinary_failure,
Age,
Work_load_Average_day,
Absenteeism_time_in_hours
FROM Absenteeism_at_work AS a
LEFT JOIN compensation AS b
ON a.ID = b.ID
LEFT JOIN Reasons AS r
ON a.Reason_for_absence = r.Number
