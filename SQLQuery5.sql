select Division,
case
	when Division='CITY FASHION'  then count(ProductCode)
	when Division='ACCESSORIES' then count(*)
	end
from Dim_Urun
where Division in ('CITY FASHION', 'ACCESSORIES')
group by Division



select Division, 
case when Division='CITY FASHION' then 1 else 0 end,
case when Division='ACCESSORIES' then 1 else 0 end

from Dim_Urun
where Division in ('CITY FASHION', 'ACCESSORIES')
