Create View
HDI_ASEAN as
select *
from ASEAN_Generall..HDI$
WHERE Country like 'Brunei%' or
	  Country = 'Cambodia' or
	  Country = 'Indonesia' or
	  Country like 'Lao%' or
	  Country = 'Malaysia' or
	  Country = 'Myanmar' or
	  Country = 'Philippines' or
	  Country = 'Singapore' or
	  Country = 'Thailand' or
	  Country like 'Viet%'