SELECT *
FROM ASEAN_Generall..Covid_Raw_Data_Clean$
--=================================================================================================================
-- ASEAN Groupping
select COUNT(DISTINCT ID), location
FROM ASEAN_Generall..Covid_Raw_Data_Clean$
WHERE location = 'Brunei' or
	  location = 'Cambodia' or
	  location = 'Indonesia' or
	  location = 'Laos' or
	  location = 'Malaysia' or
	  location = 'Myanmar' or
	  location = 'Philippines' or
	  location = 'Singapore' or
	  location = 'Thailand' or
	  location = 'Vietnam'
--Checking for groupped result view
--group by location

--Adding ASEAN category
alter table ASEAN_Generall..Covid_Raw_Data_Clean$
add special_group nvarchar(50)

--Filling value as ASEAN
update ASEAN_Generall..Covid_Raw_Data_Clean$
set special_group = 'ASEAN'
WHERE location = 'Brunei' or
	  location = 'Cambodia' or
	  location = 'Indonesia' or
	  location = 'Laos' or
	  location = 'Malaysia' or
	  location = 'Myanmar' or
	  location = 'Philippines' or
	  location = 'Singapore' or
	  location = 'Thailand' or
	  location = 'Vietnam'

update ASEAN_Generall..Covid_Raw_Data_Clean$
set special_group = 'N/a'
WHERE special_group is Null

alter table ASEAN_Generall..Covid_Raw_Data_Clean$
DROP COLUMN special_group

--=================================================================================================================
--Saving Table for Generall insight
Create View
ASEAN_Generall_Grouped_Info_Cle as
SELECT  ID, special_group, location, Date, Day, Month, Year,
		reproduction_rate, stringency_index, population_density,
		median_age, gdp_per_capita, extreme_poverty,
		life_expectancy, human_development_index, population
FROM ASEAN_Generall..Covid_Raw_Data_Clean$
WHERE location = 'Brunei' or
	  location = 'Cambodia' or
	  location = 'Indonesia' or
	  location = 'Laos' or
	  location = 'Malaysia' or
	  location = 'Myanmar' or
	  location = 'Philippines' or
	  location = 'Singapore' or
	  location = 'Thailand' or
	  location = 'Vietnam'

--Saving table for comparison purposes, covid case
Create View
Comparison_Country as
SELECT  ID, location, Date, Day,  Month, Year, 
		new_tests, new_cases, new_deaths, positive_rate,	
		total_cases, total_tests, total_deaths,	
		new_tests_per_thousand,	total_tests_per_thousand,	
		new_cases_per_million, new_deaths_per_million, total_deaths_per_million,
		icu_patients, hosp_patients,	
		weekly_icu_admissions, weekly_hosp_admissions,	
		hospital_beds_per_thousand,
		icu_patients_per_million, hosp_patients_per_million, weekly_icu_admissions_per_million,	weekly_hosp_admissions_per_million,
		handwashing_facilities, reproduction_rate, stringency_index
FROM ASEAN_Generall..Covid_Raw_Data_Clean$
WHERE location = 'Vietnam' or
	  location = 'Philippines'

-- CTE for easier usage of generall  info needed
Create View
General_Simplified as
with PopvsVac (location, avg_population, avg_GDP, avg_HDI, avg_density)
as
(
select location, AVG(population), round(AVG(gdp_per_capita), 2), round(avg(human_development_index), 2),
	   avg(population_density)
from  ASEAN_Generall..ASEAN_Generall_Grouped_Info_Cle
WHERE location = 'Vietnam' or
	  location = 'Philippines'
group by location
)
select *
from PopvsVac

--- Creating Vaccine information from given data
create table filled_total_vaccination
(
ID2 numeric,
location2 varchar(255),
Date2 datetime,
total_vaccinations_fill numeric,
total_boosters_fill numeric
)

INSERT INTO filled_total_vaccination 
	(
	ID2, location2, Date2, 
	total_vaccinations_fill, total_boosters_fill
	)
SELECT 
	ID, location, Date, 
	total_vaccinations, total_boosters
FROM ASEAN_Generall..Covid_Raw_Data_Clean$
WHERE location = 'Vietnam' or
	  location = 'Philippines'

select *
from filled_total_vaccination

create view
filled_data as
with filling_up as
(
select *,
	count(total_vaccinations_fill) over (partition by location2 order by Date2) as VCount, 
	count(total_boosters_fill) over (partition by location2 order by Date2) as BCount
from filled_total_vaccination
)
select ID2, location2, Date2,
	FIRST_VALUE(total_vaccinations_fill) over (partition by location2, VCount order by Date2) as filled_Total_Vaccine,
	FIRST_VALUE(total_boosters_fill) over (partition by location2, BCount order by Date2) as filled_Booster_Vaccine
from filling_up
