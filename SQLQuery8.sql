-- 2 sütunlu bir veri dönecek. Ýlk sütunda bölge ismi olacak. Ýkinci sütunda da yan yana aralarýnda virgülle ayrýlmýþ depo kodlarý olacak 
select 
    BolgeAdi,
    coalesce(string_agg(depokod, ', '), 'depo bulunmamaktadýr') AS Depo_Kodlarý
from Dim_Depo
where DepoGrupKod=5
group by BolgeAdi;

--her maðazanýn en çok satýþ yaptýðý tarihleri istiyorum
select ps.YilAyGun,d.DepoTanim, max(ps.SatisTutar_IlkFiyat_TRY_Kdvsiz) as MaxSatisTutar from Perakende_Satis ps
 join Dim_Depo d on d.DepoRef=ps.DepoRef
 where d.DepoGrupKod=5
 group by ps.YilAyGun, d.DepoTanim

 --select top 100 * from Dim_Depo
 /* kontrol edelim
 select ps.YilAyGun,d.DepoTanim, max(ps.SatisTutar_IlkFiyat_TRY_Kdvsiz) from Perakende_Satis ps
 join Dim_Depo d on d.DepoRef=ps.DepoRef
 where d.DepoTanim='GEO_Tbl_Gldani_Mll_Srs_Ktn'
 group by ps.YilAyGun,d.DepoTanim
 */

--select top 100 * from Dim_Urun
