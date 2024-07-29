SELECT * FROM Dim_IadeNedenleri
select * from Dim_Musteri
select * from Dim_Depo 
select * from Dim_Tarih 
SELECT * FROM Dim_IptalNedenleri
SELECT * FROM Dim_SiparisDetayIslem
select top 200 * from ETicaret_Siparis_2021_2022
select * from Perakende_Satis
select TOP 100 * from Perakende_Satis ps
select top 100 * from Dim_Urun u
select top 100 * from StokSatis_GunDepoUrun
--where u.ItemDescription='SWEATSHIRTS'


-- 2023 SONBAHAR SEZON GURUBUNA AÝT PANTOLONLARIN  GUN BAZLI TOPLAM SATIÞ TUTARINI GETÝR
select t.YilAyGun, sum(ps.SatisTutar_IlkFiyat_TRY_Kdvsiz) tutar from Perakende_Satis ps
join Dim_Urun u on u.ProductRef=ps.UrunRef
join Dim_Tarih t on t.YilAyGun=ps.YilAyGun
where t.yil=2023 and u.ItemDescription='PANTOLON' and u.ProductionSeasonGroup='AW'
group by t.YilAyGun
order by t.YilAyGun

-- KOLONLARA BÖLGE ADLARINI YERLEÞTÝR, O BÖLGELERDEKÝ TOPLAM SATIÞ ADETLERÝNÝ TOPLA SATIRLARDA itemdescription URUNLER OLACAK
select Division, [Marmara Bölgesi]  as Marmara, [Karadeniz Bölgesi] as Karadeniz, [Ege Bölgesi] as Ege, [Akdeniz Bölgesi] as Akdeniz, [Güney Doðu Anadolu Bölgesi] as GüneyDoguAnadolu, [Doðu Anadolu Bölgesi] as DoguAnadolu from (
select d.BolgeAdi, u.Division, sum(du.SatisAdet) toplam
from StokSatis_GunDepoUrun du
join Dim_Depo d on d.DepoRef=du.DepoRef
join Dim_Urun u on u.ProductRef=du.UrunRef
where d.BolgeAdi in ('Marmara Bölgesi', 'Karadeniz Bölgesi', 'Ege Bölgesi', 'Akdeniz Bölgesi', 'Güney Doðu Anadolu Bölgesi', 'Doðu Anadolu Bölgesi')
group by d.BolgeAdi, u.Division) as x
pivot (sum(toplam) for BolgeAdi in ([Marmara Bölgesi], [Karadeniz Bölgesi], [Ege Bölgesi], [Akdeniz Bölgesi], [Güney Doðu Anadolu Bölgesi], [Doðu Anadolu Bölgesi])) as pivottable

