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


-- 2023 SONBAHAR SEZON GURUBUNA A�T PANTOLONLARIN  GUN BAZLI TOPLAM SATI� TUTARINI GET�R
select t.YilAyGun, sum(ps.SatisTutar_IlkFiyat_TRY_Kdvsiz) tutar from Perakende_Satis ps
join Dim_Urun u on u.ProductRef=ps.UrunRef
join Dim_Tarih t on t.YilAyGun=ps.YilAyGun
where t.yil=2023 and u.ItemDescription='PANTOLON' and u.ProductionSeasonGroup='AW'
group by t.YilAyGun
order by t.YilAyGun

-- KOLONLARA B�LGE ADLARINI YERLE�T�R, O B�LGELERDEK� TOPLAM SATI� ADETLER�N� TOPLA SATIRLARDA itemdescription URUNLER OLACAK
select Division, [Marmara B�lgesi]  as Marmara, [Karadeniz B�lgesi] as Karadeniz, [Ege B�lgesi] as Ege, [Akdeniz B�lgesi] as Akdeniz, [G�ney Do�u Anadolu B�lgesi] as G�neyDoguAnadolu, [Do�u Anadolu B�lgesi] as DoguAnadolu from (
select d.BolgeAdi, u.Division, sum(du.SatisAdet) toplam
from StokSatis_GunDepoUrun du
join Dim_Depo d on d.DepoRef=du.DepoRef
join Dim_Urun u on u.ProductRef=du.UrunRef
where d.BolgeAdi in ('Marmara B�lgesi', 'Karadeniz B�lgesi', 'Ege B�lgesi', 'Akdeniz B�lgesi', 'G�ney Do�u Anadolu B�lgesi', 'Do�u Anadolu B�lgesi')
group by d.BolgeAdi, u.Division) as x
pivot (sum(toplam) for BolgeAdi in ([Marmara B�lgesi], [Karadeniz B�lgesi], [Ege B�lgesi], [Akdeniz B�lgesi], [G�ney Do�u Anadolu B�lgesi], [Do�u Anadolu B�lgesi])) as pivottable

