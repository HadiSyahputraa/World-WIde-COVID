SELECT COUNT(DISTINCT ID)
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
--Saving Table
Create View
ASEAN_Generall_Grouped_Info_Cle as
SELECT  ID, special_group, location, Date, Day, Month, Year, 
		reproduction_rate, stringency_index, population_density, median_age, 
		gdp_per_capita, extreme_poverty, life_expectancy, human_development_index, population
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

Create View
COVID_Information as
SELECT  ID, new_tests, new_cases, new_deaths, positive_rate,	
		total_cases, total_tests, total_deaths,	
		new_tests_per_thousand,	total_tests_per_thousand,	
		new_cases_per_million, new_deaths_per_million, total_deaths_per_million
FROM ASEAN_Generall..Covid_Raw_Data_Clean$
WHERE location = 'Indonesia' or location = 'Singapore' 

Create View
Hospital_Information as
SELECT  ID, icu_patients, hosp_patients,	
		weekly_icu_admissions, weekly_hosp_admissions,	
		hospital_beds_per_thousand,
		icu_patients_per_million, hosp_patients_per_million, weekly_icu_admissions_per_million,	weekly_hosp_admissions_per_million	
FROM ASEAN_Generall..Covid_Raw_Data_Clean$
WHERE location = 'Indonesia' or location = 'Singapore' 

Create View
Vaccine_Information as
SELECT  ID, new_vaccinations, people_vaccinated, people_fully_vaccinated,	
		people_vaccinated_per_hundred, people_fully_vaccinated_per_hundred, total_boosters_per_hundred,		
		new_vaccinations_smoothed_per_million, new_people_vaccinated_smoothed, new_people_vaccinated_smoothed_per_hundred,
		total_vaccinations,	total_boosters,	total_vaccinations_per_hundred	
FROM ASEAN_Generall..Covid_Raw_Data_Clean$
WHERE location = 'Indonesia' or location = 'Singapore'

Create View
misc_information as
SELECT  ID, handwashing_facilities, reproduction_rate	
FROM ASEAN_Generall..Covid_Raw_Data_Clean$
WHERE location = 'Indonesia' or location = 'Singapore'
