with Sezon as (
select ps.MusteriRef,
case 
	when sum(case when u.ProductionSeason='SS' then 1 else 0 end) > sum(case when u.ProductionSeason='AW' then 1 else 0 end) then 'SS'
	else 'AW'
	end as PopulerSezon
from Perakende_Satis ps
join Dim_Urun u on u.ProductRef=ps.UrunRef
group by ps.MusteriRef) 

select m.MusteriRef, m.CinsiyetKod, s.PopulerSezon,
case
	when count(distinct ps.FaturaID)>=3 then 'Mukemmel Musteri'
	when count(distinct ps.FaturaID)=1 and sum(ps.Tutar_TRY)<250 then 'Yeni Musteri'
	when count(distinct ps.FaturaID)=1 and sum(ps.Tutar_TRY)>250 then 'Sadýk Olabilir Musteri'
	when count(distinct ps.FaturaID)=2 and sum(ps.Tutar_TRY)<250 then 'Dusuk Profil Musteri'
	when count(distinct ps.FaturaID)=2 and sum(ps.Tutar_TRY)>250 then 'Sadýk Musteri'
	else 'Bilinmiyor'
	end as MusteriProfili

from Perakende_Satis ps
left join Dim_Musteri m on m.MusteriRef=ps.MusteriRef
left join Sezon s on s.MusteriRef=ps.MusteriRef
where ps.MusteriRef=1009
group by  m.MusteriRef, m.CinsiyetKod, s.PopulerSezon


select * from Dim_Musteri
select top 100 * from Perakende_Satis where MusteriRef=4069167
select * from Dim_Urun
