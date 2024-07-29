DECLARE @baslatarih int, @bitistarih int
select @baslatarih=MIN(yilaygun), @bitistarih=cast(convert(varchar, getdate(), 112) as int)
from Dim_Tarih
where Ay=datepart(MONTH, cast(dateadd(month, -1, GETDATE()) as date)) AND Yil=datepart(YEAR, cast(GETDATE() as date))

--select @baslatarih, @bitistarih 


SELECT d.DepoTanim, sum(ps.Miktar) as toplam FROM Perakende_Satis ps
JOIN Dim_Depo d on d.DepoRef=ps.DepoRef
where ps.YilAyGun between @baslatarih and @bitistarih
group by d.DepoTanim;

/*
declare @t1 int, @t2 int
select @t1=min(yilaygun), @t2=cast(convert(varchar, getdate(), 112)as int)
from Dim_Tarih 
where Ay=DATEPART(month, cast(dateadd(month, -1, getdate()) as date)) and yil =DATEPART(year, cast(getdate() as date))

select d.DepoKod, sum(ps.Miktar) as sums from Perakende_Satis ps
join Dim_Depo d on d.DepoRef=ps.DepoRef
where ps.YilAyGun between @t1 and @t2 
group by d.DepoKod

*/

------------------------------------------------------------------------------------------------------------

declare @baslangic int, @bitis int
select @baslangic=cast(convert(varchar,datefromparts(year(getdate()),1,1),112) as int), @bitis=cast(convert(varchar, getdate(), 112) as int) 
FROM Dim_Tarih
--select @baslangic, @bitis
select d.Division, d.Department, d.SubDepartment, d.Category, d.Class, sum(ps.miktar) as miktar from Perakende_Satis ps
join Dim_Urun d on d.ProductRef=ps.UrunRef
where ps.YilAyGun between @baslangic and @bitis
group by d.Division, d.Department, d.SubDepartment, d.Category, d.Class
order by sum(ps.miktar) desc;


--select min(yilaygun) from Dim_Tarih
--where yil=cast(year(getdate()) as int)
/*
declare @trh1 int, @trh2 int
select @trh1=min(yilaygun) , @trh2=cast(convert(varchar, getdate(), 112) as int) 
from Dim_Tarih
where Yil=datepart(YEAR, cast(GETDATE() as date))

--select @trh1, @trh2

select d.Division, d.Department, d.SubDepartment, d.Category, d.Class, sum(ps.miktar) as toplam 
from Perakende_Satis ps
join Dim_Urun d on d.ProductRef=ps.UrunRef
where ps.YilAyGun between @trh1 and @trh2
group by d.Division, d.Department, d.SubDepartment, d.Category, d.Class
*/

-----------------------------------------------------------------------------------------------



declare @start int, @end int
select @start=cast(convert(varchar, dateadd(year, -3, dateadd(month, -3, GETDATE())), 112) as int), @end=cast(convert(varchar, dateadd(year, -3, getdate()), 112) as int) from Dim_Tarih;

--select @start , @end 
select t.YilHafta, d.DepoTanim, sum(du.SatisTutar_TRY_KDVsiz) from StokSatis_GunDepoUrun du
join  Dim_Tarih t on t.YilAyGun=du.YilAyGun
join Dim_Depo d on d.DepoRef=du.DepoRef and d.DepoGrupKod=5 --depogrupkod 5 magazalar
where t.YilAyGun between @start and @end and UlkeTanim='Rusya'
group by t.YilHafta, d.DepoTanim
order by t.YilHafta;



declare @bas int, @bit int
select @bas=cast(convert(varchar, dateadd(year, -3, dateadd(month, -3, getdate())), 112) as int), @bit=cast(convert(varchar, dateadd(year, -3, getdate()), 112) as int)

select t.YilHafta, d.DepoTanim, sum(du.SatisTutar_TRY_KDVsiz) from StokSatis_GunDepoUrun du
join Dim_Tarih t on t.YilAyGun= du.YilAyGun
join Dim_Depo d on d.DepoRef=du.DepoRef and d.DepoGrupKod= 5
where t.YilAyGun between @bas and @bit and d.UlkeTanim='Rusya'
group by t.YilHafta, d.DepoTanim
order by t.YilHafta, d.DepoTanim

/*select distinct UlkeTanim from Dim_Depo
order by UlkeTanim
*/
--------------------------------------------------------------------------------------------------

select du.Deporef, du.yilaygun, sum(du.SatisTutar_TRY_KDVsiz) from StokSatis_GunDepoUrun du
join Dim_Depo d on d.DepoRef=du.DepoRef
join Dim_Tarih t on t.YilAyGun=du.YilAyGun
where  d.UlkeTanim='Türkiye' and Yil=2021
group by du.DepoRef, du.YilAyGun
having sum(du.SatisTutar_TRY_KDVsiz)>10000
order by du.DepoRef, du.YilAyGun;




select d.DepoRef, du.YilAyGun, sum(du.SatisTutar_TRY_KDVsiz) from StokSatis_GunDepoUrun du
join Dim_Depo d on d.DepoRef=du.DepoRef
join Dim_Tarih t on t.YilAyGun= du.YilAyGun
where Yil=2021 and d.UlkeTanim='Türkiye'
group by d.DepoRef, du.YilAyGun
having sum(du.SatisTutar_TRY_KDVsiz)>10000
order by d.DepoRef, du.YilAyGun


---------------------------------------------------------------------------------------------------
--tr rusya kim büyükse tr r yazdýr gün bazlý

select YilAyGun, sum(turkiyemiktar) trmiktar, sum(rusyamiktar) rsmiktar,
case 
    when sum(turkiyemiktar)>sum(rusyamiktar) then 'TR'
	when sum(rusyamiktar)> sum(turkiyemiktar) then 'RS'
	end buyuk
from (
select ps.YilAyGun, d.UlkeTanim,
case 
    when d.UlkeTanim='Türkiye' then ps.Miktar
	else 0 
	end as turkiyemiktar,
case 
     when d.UlkeTanim='Rusya' then ps.Miktar
	 else 0
	 end as rusyamiktar
   
from Perakende_Satis ps
join Dim_Depo d on d.DepoRef=ps.DepoRef
join Dim_Tarih t on t.YilAyGun=ps.YilAyGun) as x

where UlkeTanim in ('Türkiye', 'Rusya')
group by YilAyGun

-------------------------------------------------------

select DepoTanim, [20210101],[20210102],[20210103],[20210104],[20210105],[20210106],[20210107]  from (
select du.YilAyGun, d.DepoTanim, sum(du.SatisAdet) toplam
from StokSatis_GunDepoUrun du
join Dim_Depo d on d.DepoRef=du.DepoRef
where du.YilAyGun between 20210101 and 20210107 and d.UlkeTanim='Türkiye'
group by d.DepoTanim, du.YilAyGun) as x
pivot( sum(toplam) for yilaygun in ([20210101],[20210102],[20210103],[20210104],[20210105],[20210106],[20210107])) as pivottable

select top 100 *from StokSatis_GunDepoUrun
order by YilAyGun 