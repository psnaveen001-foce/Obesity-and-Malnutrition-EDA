CREATE DATABASE IF NOT EXISTS Nutrition_paradox;
USE Nutrition_paradox;

CREATE TABLE obesity_data (
    id INT AUTO_INCREMENT PRIMARY KEY,
    Region VARCHAR(50),
    Year INT,
    Gender VARCHAR(10),
    LowerBound FLOAT,
    UpperBound FLOAT,
    Mean_Estimate FLOAT,
    Country VARCHAR(80),
    age_group VARCHAR(30),
    CI_Width FLOAT,
    obesity_level VARCHAR(20)
);

CREATE TABLE malnutrition_data (
    id INT AUTO_INCREMENT PRIMARY KEY,
    Region VARCHAR(50),
    Year INT,
    Gender VARCHAR(10),
    LowerBound FLOAT,
    UpperBound FLOAT,
    Mean_Estimate FLOAT,
    Country VARCHAR(80),
    age_group VARCHAR(30),
    CI_Width FLOAT,
    malnutrition_level VARCHAR(20)
);

SHOW GRANTS FOR 'EUjgzHgiZeB3XXi.root';

SELECT * FROM obesity_data;
SELECT * FROM malnutrition_data;

# obesity_data Queries
#1 Top 5 regions with the highest average obesity levels in the most recent year(2022)

SELECT Region,
       ROUND(AVG(Mean_Estimate),2) AS Avg_Obesity
FROM obesity_data
WHERE Year = 2022
GROUP BY Region
ORDER BY Avg_Obesity DESC
LIMIT 5;

#2 Top 5 countries with highest obesity estimates

SELECT Country,
       ROUND(AVG(Mean_Estimate),2) AS Avg_Obesity
FROM obesity_data
GROUP BY Country
ORDER BY Avg_Obesity DESC
LIMIT 5;

#3 Obesity trend in India over the years(Mean_estimate)

SELECT Year,
       ROUND(AVG(Mean_Estimate),2) AS Obesity
FROM obesity_data
WHERE Country = 'India'
GROUP BY Year
ORDER BY Year;

#4 Average obesity by gender

SELECT Gender,
       ROUND(AVG(Mean_Estimate),2) AS Avg_Obesity
FROM obesity_data
GROUP BY Gender;

#5 Country count by obesity level category and age group

SELECT 
    age_group,
    CASE 
        WHEN Mean_Estimate < 10 THEN 'Low'
        WHEN Mean_Estimate BETWEEN 10 AND 20 THEN 'Medium'
        ELSE 'High'
    END AS Obesity_Level,
    COUNT(DISTINCT Country) AS Country_Count
FROM obesity_data
GROUP BY 
    age_group,
    CASE 
        WHEN Mean_Estimate < 10 THEN 'Low'
        WHEN Mean_Estimate BETWEEN 10 AND 20 THEN 'Medium'
        ELSE 'High'
    END;
    
    #6 Top 5 countries least reliable countries(with highest CI_Width) and Top 5 most consistent countries (smallest average CI_Width)
    
  #Highest  
    SELECT Country,
       ROUND(AVG(UpperBound - LowerBound),2) AS Avg_CI_Width
FROM obesity_data
GROUP BY Country
ORDER BY Avg_CI_Width DESC
LIMIT 5;

# Lowest
SELECT Country,
       ROUND(AVG(UpperBound - LowerBound),2) AS Avg_CI_Width
FROM obesity_data
GROUP BY Country
ORDER BY Avg_CI_Width ASC
LIMIT 5;

#7 Average obesity by age group

SELECT age_group,
       ROUND(AVG(Mean_Estimate),2) AS Avg_Obesity
FROM obesity_data
GROUP BY age_group;

#8 Top 10 Countries with consistent low obesity (low average + low CI)over the years

SELECT Country,
       ROUND(AVG(Mean_Estimate),2) AS Avg_Obesity,
       ROUND(AVG(UpperBound - LowerBound),2) AS Avg_CI
FROM obesity_data
GROUP BY Country
HAVING Avg_Obesity < 15 AND Avg_CI < 3
ORDER BY Avg_Obesity
LIMIT 10;

#9 Countries where female obesity exceeds male by large margin (same year)

SELECT f.Country,
       f.Year,
       ROUND(f.Mean_Estimate - m.Mean_Estimate,2) AS Gender_Gap
FROM obesity_data f
JOIN obesity_data m
ON f.Country = m.Country AND f.Year = m.Year
WHERE f.Gender='Female' AND m.Gender='Male'
ORDER BY Gender_Gap DESC;

#10 Global average obesity percentage per year

SELECT Year,
       ROUND(AVG(Mean_Estimate),2) AS Global_Obesity
FROM obesity_data
GROUP BY Year
ORDER BY Year;

# malnutrition_data Queries

#1 Avg. malnutrition by age group

SELECT age_group,
       ROUND(AVG(Mean_Estimate),2) AS Avg_Malnutrition
FROM malnutrition_data
GROUP BY age_group;

#2 Top 5 countries with highest malnutrition(mean_estimate)

SELECT Country,
       ROUND(AVG(Mean_Estimate),2) AS Avg_Malnutrition
FROM malnutrition_data
GROUP BY Country
ORDER BY Avg_Malnutrition DESC
LIMIT 5;

#3 Malnutrition trend in African region over the years

SELECT Year,
       ROUND(AVG(Mean_Estimate),2) AS Malnutrition
FROM malnutrition_data
WHERE Region='Africa'
GROUP BY Year
ORDER BY Year;

#4 Gender-based average malnutrition

SELECT Gender,
       ROUND(AVG(Mean_Estimate),2) AS Avg_Malnutrition
FROM malnutrition_data
GROUP BY Gender;

#5 Malnutrition level-wise (average CI_Width by age group)

SELECT age_group,
       ROUND(AVG(UpperBound-LowerBound),2) AS Avg_CI
FROM malnutrition_data
GROUP BY age_group;

#6 Yearly malnutrition change in specific countries(India, Nigeria, Brazil)

SELECT Country, Year,
       ROUND(AVG(Mean_Estimate),2) AS Malnutrition
FROM malnutrition_data
WHERE Country IN ('India','Nigeria','Brazil')
GROUP BY Country, Year
ORDER BY Country, Year;

#7 Regions with lowest malnutrition averages

SELECT Region,
       ROUND(AVG(Mean_Estimate),2) AS Avg_Malnutrition
FROM malnutrition_data
GROUP BY Region
ORDER BY Avg_Malnutrition ASC;

#8 Countries with increasing malnutrition 

SELECT Country,
       MIN(Mean_Estimate) AS Min_Level,
       MAX(Mean_Estimate) AS Max_Level
FROM malnutrition_data
GROUP BY Country
HAVING (Max_Level - Min_Level) > 0;

#9 Min/Max malnutrition levels year-wise comparison

SELECT Year,
       MIN(Mean_Estimate) AS Min_Malnutrition,
       MAX(Mean_Estimate) AS Max_Malnutrition
FROM malnutrition_data
GROUP BY Year;

#10 High CI_Width flags for monitoring(CI_width > 5)

SELECT *
FROM malnutrition_data
WHERE (UpperBound - LowerBound) > 5;

#combined obesity_data and malnutrition_data

#1 Obesity vs malnutrition comparison by country(5 countries)

SELECT o.Country,
       ROUND(AVG(o.Mean_Estimate),2) AS Obesity,
       ROUND(AVG(m.Mean_Estimate),2) AS Malnutrition
FROM obesity_data o
JOIN malnutrition_data m
ON o.Country=m.Country AND o.Year=m.Year
WHERE o.Country IN ('India','USA','Brazil','China','Nigeria')
GROUP BY o.Country;

#2 Gender-based disparity in both obesity and malnutrition

SELECT o.Gender,
       ROUND(AVG(o.Mean_Estimate),2) AS Obesity,
       ROUND(AVG(m.Mean_Estimate),2) AS Malnutrition
FROM obesity_data o
JOIN malnutrition_data m
ON o.Country=m.Country AND o.Year=m.Year AND o.Gender=m.Gender
GROUP BY o.Gender;

#3 Region-wise avg estimates side-by-side(Africa and America)

SELECT o.Region,
       ROUND(AVG(o.Mean_Estimate),2) AS Obesity,
       ROUND(AVG(m.Mean_Estimate),2) AS Malnutrition
FROM obesity_data o
JOIN malnutrition_data m
ON o.Country=m.Country AND o.Year=m.Year
WHERE o.Region IN ('Africa','Americas')
GROUP BY o.Region;

#4 Countries with obesity up & malnutrition down

SELECT 
    o.Country,

    -- Obesity trend
    ROUND(MIN(o.Mean_Estimate),2) AS Obesity_Earliest,
    ROUND(MAX(o.Mean_Estimate),2) AS Obesity_Latest,
    ROUND(MAX(o.Mean_Estimate) - MIN(o.Mean_Estimate),2) AS Obesity_Change,

    -- Malnutrition trend
    ROUND(MAX(m.Mean_Estimate),2) AS Malnutrition_Earliest,
    ROUND(MIN(m.Mean_Estimate),2) AS Malnutrition_Latest,
    ROUND(MIN(m.Mean_Estimate) - MAX(m.Mean_Estimate),2) AS Malnutrition_Change

FROM obesity_data o
JOIN malnutrition_data m
  ON o.Country = m.Country 
 AND o.Year = m.Year

GROUP BY o.Country

HAVING 
    (MAX(o.Mean_Estimate) - MIN(o.Mean_Estimate)) > 0      -- obesity increased
AND (MIN(m.Mean_Estimate) - MAX(m.Mean_Estimate)) < 0;    -- malnutrition decreased


#5 Age-wise trend analysis

SELECT o.age_group,
       o.Year,
       ROUND(AVG(o.Mean_Estimate),2) AS Obesity,
       ROUND(AVG(m.Mean_Estimate),2) AS Malnutrition
FROM obesity_data o
JOIN malnutrition_data m
ON o.Country=m.Country AND o.Year=m.Year AND o.age_group=m.age_group
GROUP BY o.age_group, o.Year
ORDER BY o.age_group, o.Year;
