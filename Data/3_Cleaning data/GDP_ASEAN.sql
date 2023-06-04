select *
from ASEAN_Generall..GDP$

select *
from ASEAN_Generall..GDP_info$

--==========================================================================
Create View
ASEAN_GDP as
select *
from ASEAN_Generall..GDP$
	join ASEAN_Generall..GDP_info$
	ON ASEAN_Generall..GDP$.Code = ASEAN_Generall..GDP_info$.Code2
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