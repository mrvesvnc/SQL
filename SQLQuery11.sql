-- her magazada en fazla satýþ adedine sahip division


select d.DepoRef, u.Division, count(u.Division) as DivisionCount 
into #DivCount
from Perakende_Satis ps
join Dim_Depo d on d.DepoRef=ps.DepoRef
join Dim_Urun u on u.ProductRef=ps.UrunRef
where d.DepoGrupKod=5
group by  d.DepoRef, u.Division
order by count(u.Division) desc


select distinct DepoRef, Division =(select top 1 Division from #DivCount dc where dc.DepoRef=dcc.DepoRef)
into #Division
from #DivCount dcc

select d.*, dd.Division from Dim_Depo d
join #Division dd on dd.DepoRef=d.DepoRef