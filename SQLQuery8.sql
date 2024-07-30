-- 2 s�tunlu bir veri d�necek. �lk s�tunda b�lge ismi olacak. �kinci s�tunda da yan yana aralar�nda virg�lle ayr�lm�� depo kodlar� olacak 
select 
    BolgeAdi,
    coalesce(string_agg(depokod, ', '), 'depo bulunmamaktad�r') AS Depo_Kodlar�
from Dim_Depo
where DepoGrupKod=5
group by BolgeAdi;

--her ma�azan�n en �ok sat�� yapt��� tarihleri istiyorum
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
