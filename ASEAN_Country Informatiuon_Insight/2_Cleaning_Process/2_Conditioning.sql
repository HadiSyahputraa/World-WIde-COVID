SELECT *
FROM ASEAN_Generall..Covid_Raw_Data_Clean$

--=================================================================================================================
-- ASEAN Groupping
select location
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
--group by location

--Adding ASEAN category
alter table ASEAN_Generall..Covid_Raw_Data_Clean$
add special_group varchar(50)

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

--=================================================================================================================
--Saving Table
Create View
ASEAN_Generall_Grouped_Info_Clean as
SELECT  special_group,
		location,
		Date,
		Day,
		Month,
		Year,
		reproduction_rate,
		stringency_index,
		population_density,
		median_age,
		gdp_per_capita,
		extreme_poverty,
		life_expectancy,
		human_development_index,
		population
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
