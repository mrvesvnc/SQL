declare @hafta int
select @hafta=datepart(week, dateadd(year, -2, getdate())) 

select t.YilAyGun,
sum(ps.Miktar) as 'miktar',
sum(ps.Tutar_TRY) as 'tutar',
count(distinct ps.FaturaID) as 'fatura sayisi',
count(distinct ps.MusteriRef) as 'musteri sayisi'
from Perakende_Satis ps
join Dim_Depo d on d.DepoRef=PS.DepoRef
join Dim_Tarih t on t.YilAyGun=ps.YilAyGun
where t.MerchHafta in (@hafta, @hafta-1, @hafta-2) and t.Yil=datepart(year, dateadd(year, -2, getdate())) and d.DepoGrupKod=5 and d.KanalKod in ('2', '7')
group by t.YilAyGun
order by YilAyGun

SELECT TOP 100 * FROM Dim_Tarih
where MerchYilHafta is not NULL


--(SUM(PS.Tutar_TRY)-SUM(PS.SatilanMalinMaliyeti_TR))/ SUM(PS.Tutar_TRY) * 100 AS 'Perakende Brut Kar Marjý',
--(1- (SUM(PS.Tutar_TRY)/SUM(PS.SatisTutar_IlkFiyat_TRY_Kdvsiz))) * 100 AS 'Perakende Ýndirim Oraný',

select distinct Tanim from  ProcessHelper.Dim_InnerProcess 

DECLARE @WEEK INT
SET @WEEK = DATEPART(WEEK,GETDATE())

SELECT * FROM(
SELECT  datepart(HOUR,she.IslemSaat) AS Saat, p.Tanim AS Tanim, ISNULL(SUM(she.Miktar),' ') AS Miktar FROM StokHareketEkstre she
join ProcessHelper.Dim_InnerProcess p ON p.InnerProcessRef = she.InnerProcessRef
join Dim_Tarih t ON t.YilAyGun = she.YilAyGun
join Dim_Depo d ON d.DepoRef = she.DepoRef
WHERE t.MerchHafta in (@WEEK,@WEEK-1,@WEEK-2) AND t.Yil = DATEPART(YEAR, GETDATE())
	AND d.DepoGrupKod = 5
	AND d.KanalKod in ('2','7')
	AND p.Tanim <> 'F_Depo_Depo' AND p.Tanim <> 'Sayim_Eksigi_Depo' AND p.Tanim <> 'Sayim_FazlASi_ReyON' AND p.Tanim <> 'C_Depo_Depo' AND p.Tanim <> 'Depo_C_Depo' 
	AND p.Tanim <> 'Depo_F_Depo' AND p.Tanim <> 'Sayim_Eksigi_ReyON' AND p.Tanim <> 'Sayim_FazlASi_Depo' 
GROUP BY p.Tanim,datepart(HOUR,she.IslemSaat)
) AS x
pivot( SUM(Miktar) for Saat in ([0],[1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12],[13],[14],[15],[16],[17],[18],[19],[20],[21],[22],[23])) PivotTable
