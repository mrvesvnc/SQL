-- her magaza için her bir divisionýndaki toplam satýs tutarýný al 
select d.DepoRef, u.Division, sum(ps.Tutar_TRY) as ToplamSatisTutar
into #Tutar
from Perakende_Satis ps
join Dim_Depo d on d.DepoRef=ps.DepoRef
join Dim_Urun u on u.ProductRef=ps.UrunRef
where d.DepoGrupKod=5
group by  d.DepoRef, u.Division
order by sum(ps.Tutar_TRY) desc

--select * from #Tutar where DepoRef = 19

-- her magazanýn divisionlarýndaki max satýs tutarýna sahip divisioný al
select distinct DepoRef, Division  = (select top 1 Division from #Tutar t where t.DepoRef = tt.DepoRef)
into #Division
from #Tutar tt

--select * from #Division where DepoRef = 19

-- depo bilgilerini ve oradaki en çok satýþ yapýlan divisioný getir
select d.*, dd.Division 
from Dim_Depo d
join #Division dd on d.DepoRef = dd.DepoRef

