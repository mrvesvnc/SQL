-- her magaza i�in her bir division�ndaki toplam sat�s tutar�n� al 
select d.DepoRef, u.Division, sum(ps.Tutar_TRY) as ToplamSatisTutar
into #Tutar
from Perakende_Satis ps
join Dim_Depo d on d.DepoRef=ps.DepoRef
join Dim_Urun u on u.ProductRef=ps.UrunRef
where d.DepoGrupKod=5
group by  d.DepoRef, u.Division
order by sum(ps.Tutar_TRY) desc

--select * from #Tutar where DepoRef = 19

-- her magazan�n divisionlar�ndaki max sat�s tutar�na sahip division� al
select distinct DepoRef, Division  = (select top 1 Division from #Tutar t where t.DepoRef = tt.DepoRef)
into #Division
from #Tutar tt

--select * from #Division where DepoRef = 19

-- depo bilgilerini ve oradaki en �ok sat�� yap�lan division� getir
select d.*, dd.Division 
from Dim_Depo d
join #Division dd on d.DepoRef = dd.DepoRef

