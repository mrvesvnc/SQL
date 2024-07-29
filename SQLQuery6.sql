declare @buhafta int
select @buhafta=datepart(week, getdate())
--select @buhafta

select d.DepoRef, 
	SUM(case when t.MerchHafta = @buhafta THEN ps.Miktar else 0 end) as BuHafta,
	SUM(case when t.MerchHafta = @buhafta-1 then ps.Miktar else 0 end) as GecenHafta,
	case 
	      when SUM(case when t.MerchHafta = @buhafta THEN ps.Miktar else 0 end)>SUM(case when t.MerchHafta = @buhafta-1 then ps.Miktar else 0 end) then 'BuHafta'
		  when SUM(case when t.MerchHafta = @buhafta-1 then ps.Miktar else 0 end)>SUM(case when t.MerchHafta = @buhafta THEN ps.Miktar else 0 end) then 'GecenHafta'
		  else 'Esit'
		  end as EniyiHafta
from  Perakende_Satis ps
join Dim_Depo d on d.DepoRef=ps.DepoRef
join Dim_Urun u on u.ProductRef= ps.UrunRef
join Dim_Tarih t on t.YilAyGun= ps.YilAyGun
where t.Yil= datepart(year,getdate()) and t.MerchHafta in (@buhafta , @buhafta-1) 
and DepoGrupKod = 5 and u.Division='MENSWEAR'
group by d.DepoRef


-- KÜMÜLATÝF TOPLAM
declare @buhafta int
select @buhafta=datepart(week, getdate())
select DepoRef, YilAyGun, sum(Miktar) over (partition by DepoRef order by YilAyGun) as KümülatifMiktar
from(
select d.DepoRef, t.YilAyGun, sum(ps.Miktar) as Miktar from Perakende_Satis ps
join Dim_Depo d on d.DepoRef=ps.DepoRef
join Dim_Tarih t on t.YilAyGun=ps.YilAyGun
where d.DepoGrupKod=5  and d.UlkeKod='TR' and t.Yil= datepart(year,getdate()) and t.MerchHafta=@buhafta 
group by d.DepoRef, t.YilAyGun) as x
order by DepoRef, YilAyGun

--[11:28] TR'deki maðazalardaki satýþ adetler lazým ama þu þekilde; sütunlarda bölge isimleri olacak ve satýrlarda divisionlar olacak. 
select Division, [Marmara Bölgesi]  as MarmaraBolgesi, [Ýç Anadolu Bölgesi] as IcAnadoluBolgesi, [Karadeniz Bölgesi] as KaradenizBolgesi, [Ege Bölgesi] as EgeBolgesi, [Akdeniz Bölgesi] as AkdenizBolgesi, [Güney Doðu Anadolu Bölgesi] as GüneyDoguAnadoluBolgesi, [Merkez] as Merkez
from 
(select d.BolgeAdi, u.Division, sum(du.SatisAdet) as ToplamSatis from StokSatis_GunDepoUrun du
join Dim_Depo d on d.DepoRef=du.DepoRef
join Dim_Urun u on u.ProductRef=du.UrunRef
where d.DepoGrupKod=5 and d.UlkeKod='TR'
group by d.BolgeAdi, u.Division) as x
pivot(sum(ToplamSatis) for BolgeAdi in ([Marmara Bölgesi], [Ýç Anadolu Bölgesi],[Karadeniz Bölgesi], [Ege Bölgesi], [Akdeniz Bölgesi], [Güney Doðu Anadolu Bölgesi], [Merkez])) as pivottable

