--her maðazada en çok satýþ yapan division

--  her maðazadaki her bir divisionýn toplam satýþ tutarlarýný al
 with Division_Satislari as (
	select d.DepoTanim, u.Division, sum(ps.SatisTutar_IlkFiyat_TRY_Kdvsiz) as ToplamSatisTutar
	from Perakende_Satis ps
	join Dim_Depo d on d.DepoRef=ps.DepoRef
	join Dim_Urun u on u.ProductRef=ps.UrunRef
	where d.DepoGrupKod=5
    group by  d.DepoTanim, u.Division
),

--her divisiondaki toplam satýþ tutarlarýnýn maximumunu al
Max_Division_Satislari as(
	select DepoTanim, max(ToplamSatisTutar) as MaxSatisTutar
	from Division_Satislari
	group by DepoTanim
)

-- her magazadaki mmax satýþ tutarýna sahip divisionu al
select ds.DepoTanim, ds.Division, ds.ToplamSatisTutar as MaxTutar from Division_Satislari ds
join Max_Division_Satislari mds on mds.DepoTanim=ds.DepoTanim
								and ds.ToplamSatisTutar=mds.DepoTanim
order by ds.DepoTanim, ds.Division