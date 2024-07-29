/* declare @week int

select @week=MerchHafta from Dim_Tarih
where Tarih=convert(date, getdate())

select @week
select t1.DepoKod, t1.DepoTanim, Tutar, Miktar, TutarOY, MiktarOY from (
select d.DepoKod DepoKod, d.DepoTanim as DepoTanim , ps.SatisTutar_IlkFiyat_TRY_Kdvsiz as Tutar, ps.Miktar as Miktar from Perakende_Satis ps
join Dim_Depo d on d.DepoRef= ps.DepoRef
join Dim_Urun u on u.ProductRef= ps.UrunRef
join Dim_Tarih t on t.YilAyGun=ps.YilAyGun
where d.DepoGrupKod=5 and d.KanalKod=21 
and u.Division not in ('NON TRADING')
and t.MerchHafta=@week-1 or t.MerchHafta=@week
and t.yil=datepart(year, getdate())
) as t1
join (
select d.DepoKod as DepoKod, d.DepoTanim as DepoTanim, ps.SatisTutar_IlkFiyat_TRY_Kdvsiz as TutarOY, ps.Miktar as MiktarOY from Perakende_Satis ps
join Dim_Depo d on d.DepoRef= ps.DepoRef
join Dim_Urun u on u.ProductRef= ps.UrunRef
join Dim_Tarih t on t.YilAyGun=ps.YilAyGun
where d.DepoGrupKod=5 and d.KanalKod=21 
and u.Division not in ('NON TRADING')
and t.MerchHafta=@week-1 or t.MerchHafta=@week
and t.yil=datepart(year, dateadd(year, -1, getdate()))
) as t2
on t1.DepoKod=t2.DepoKod;

------------------------------------------------------------------
declare @x int
select @x=t.MerchYilHafta from Dim_Tarih t
where Tarih=convert(date,getdate())
select @x-100

---------------------------------------------------------

declare @week int

select @week=MerchHafta from Dim_Tarih
where Tarih=convert(date, getdate())

select d.DepoKod from Perakende_Satis ps
join Dim_Depo d on d.DepoRef= ps.DepoRef
join Dim_Urun u on u.ProductRef= ps.UrunRef
join Dim_Tarih t on t.YilAyGun=ps.YilAyGun
where d.DepoGrupKod=5 and d.KanalKod=21 
and u.Division not in ('NON TRADING')
and t.MerchHafta=@week-1 or t.MerchHafta=@week
and t.yil=datepart(year, getdate())
union 
select d.DepoKod from Perakende_Satis ps
join Dim_Depo d on d.DepoRef= ps.DepoRef
join Dim_Urun u on u.ProductRef= ps.UrunRef
join Dim_Tarih t on t.YilAyGun=ps.YilAyGun
where d.DepoGrupKod=5 and d.KanalKod=21 
and u.Division not in ('NON TRADING')
and t.MerchHafta=@week-1 or t.MerchHafta=@week
and t.yil=datepart(year, dateadd(year, -1, getdate()))

--------------------------------------------------------------------

declare @week int
 
select @week=MerchHafta from Dim_Tarih
where Tarih=convert(date, getdate())
 
select d.DepoKod into #Key from Perakende_Satis ps
join Dim_Depo d on d.DepoRef= ps.DepoRef
join Dim_Urun u on u.ProductRef= ps.UrunRef
join Dim_Tarih t on t.YilAyGun=ps.YilAyGun
where d.DepoGrupKod=5 and d.KanalKod='21' 
and u.Division not in ('NON TRADING')
and t.MerchHafta=@week-1 or t.MerchHafta=@week
and t.yil=datepart(year, getdate())
union 
select d.DepoKod from Perakende_Satis ps
join Dim_Depo d on d.DepoRef= ps.DepoRef
join Dim_Urun u on u.ProductRef= ps.UrunRef
join Dim_Tarih t on t.YilAyGun=ps.YilAyGun
where d.DepoGrupKod=5 and d.KanalKod='21'  
and u.Division not in ('NON TRADING')
and t.MerchHafta=@week-1 or t.MerchHafta=@week
and t.yil=datepart(year, dateadd(year, -1, getdate()))


select d.DepoKod DepoKod, d.DepoTanim as DepoTanim 
	,sum(ps.Tutar_TRY) as Tutar
	,sum(ps.Miktar) as Miktar 
into #BuYilSatis
from Perakende_Satis ps
join Dim_Depo d on d.DepoRef= ps.DepoRef
join Dim_Urun u on u.ProductRef= ps.UrunRef
join Dim_Tarih t on t.YilAyGun=ps.YilAyGun
where d.DepoGrupKod=5 and d.KanalKod='21' 
	and u.Division not in ('NON TRADING')
	and t.MerchHafta=@week-1 or t.MerchHafta=@week
	and t.yil=datepart(year, getdate())
group by d.DepoKod, d.DepoTanim


select d.DepoKod as DepoKod, d.DepoTanim as DepoTanim
	,sum(ps.Tutar_TRY) as TutarOY
	,sum(ps.Miktar) as MiktarOY 
into #OYSatis
from Perakende_Satis ps
join Dim_Depo d on d.DepoRef= ps.DepoRef
join Dim_Urun u on u.ProductRef= ps.UrunRef
join Dim_Tarih t on t.YilAyGun=ps.YilAyGun
where d.DepoGrupKod=5 and d.KanalKod='21'  
	and u.Division not in ('NON TRADING')
	and t.MerchHafta=@week-1 or t.MerchHafta=@week
	and t.yil=datepart(year, dateadd(year, -1, getdate()))
group by d.DepoKod, d.DepoTanim



select k.DepoKod
	,bs.Miktar
	,bs.Tutar
	,os.MiktarOY
	,os.TutarOY
from #Key k
left join #BuYilSatis bs on bs.DepoKod = k.DepoKod
left join #OYSatis os on os.DepoKod = k.DepoKod
*/
-------------------------------------------------------------------
declare @ayingunu int
select @ayingunu=t.AyinGunu from Dim_Tarih t where Tarih=convert(date, getdate())

select d.DepoKod into #main_
from Perakende_Satis ps
join Dim_Tarih t on t.YilAyGun=ps.YilAyGun
join Dim_Depo d on d.DepoRef=ps.DepoRef
join Dim_Urun u on u.ProductRef=ps.UrunRef
where d.DepoGrupKod=5 and d.KanalKod=2
	and u.Division not in ('NON TRADING')
	and t.Yil=datepart(year,dateadd(year, -1, getdate()))
	and t.Ay=datepart(month,dateadd(year, -1, getdate()))
	and t.AyinGunu between 1 and @ayingunu
union
select d.DepoKod
from Perakende_Satis ps
join Dim_Tarih t on t.YilAyGun=ps.YilAyGun
join Dim_Depo d on d.DepoRef=ps.DepoRef
join Dim_Urun u on u.ProductRef=ps.UrunRef
where d.DepoGrupKod=5 and d.KanalKod=2
	and u.Division not in ('NON TRADING')
	and t.Yil=datepart(year,dateadd(year, -1, getdate()))
	and t.MerchAy=datepart(month,dateadd(year, -1, getdate()))
	and t.MerchAyinGunu between 1 and @ayingunu


declare @ayingunu int
select @ayingunu=t.AyinGunu from Dim_Tarih t where Tarih=convert(date, getdate())
select d.DepoKod DepoKod, d.DepoTanim as DepoTanim 
	,sum(ps.Tutar_TRY) as TutarOY
	,sum(ps.Miktar) as MiktarOY
into #Satis_OY_
from Perakende_Satis ps
join Dim_Tarih t on t.YilAyGun=ps.YilAyGun
join Dim_Depo d on d.DepoRef=ps.DepoRef
join Dim_Urun u on u.ProductRef=ps.UrunRef
where d.DepoGrupKod=5 and d.KanalKod=2
	and u.Division not in ('NON TRADING')
	and t.Yil=datepart(year,dateadd(year, -1, getdate()))
	and t.Ay=datepart(month,dateadd(year, -1, getdate()))
	and t.AyinGunu between 1 and @ayingunu
group by d.DepoKod, d.DepoTanim

select d.DepoKod as DepoKod, d.DepoTanim as DepoTanim
	,sum(ps.Tutar_TRY) as TutarOYM
	,sum(ps.Miktar) as MiktarOYM
into #Satis_OYM_
from Perakende_Satis ps
join Dim_Depo d on d.DepoRef= ps.DepoRef
join Dim_Urun u on u.ProductRef= ps.UrunRef
join Dim_Tarih t on t.YilAyGun=ps.YilAyGun
where d.DepoGrupKod=5 and d.KanalKod=2
	and u.Division not in ('NON TRADING')
	and t.Yil=datepart(year,dateadd(year, -1, getdate()))
	and t.MerchAy=datepart(month,dateadd(year, -1, getdate()))
	and t.MerchAyinGunu between 1 and @ayingunu
group by d.DepoKod, d.DepoTanim


select m.DepoKod, os.MiktarOY, os.TutarOY ,osm.MiktarOYM ,osm.TutarOYM
from #main_ m
left join #Satis_OY_ os on os.DepoKod = m.DepoKod
left join #Satis_OYM_ osm on osm.DepoKod = m.DepoKod

