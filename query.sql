-- customer addition procedure

CREATE OR REPLACE PROCEDURE ekle_musteri(
    
	ad VARCHAR,
    soyad VARCHAR,
    eposta VARCHAR,
    telefon VARCHAR,
	adres VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO Musteriler ( ad, soyad, eposta, telefon, adres)
    VALUES (ad, soyad, eposta, telefon, adres);
END;
$$;

-- we call the procedure with call 
CALL ekle_musteri('Arda', 'Çalık', 'calik@gmail.com','05045678918', 'Kepez/Antalya')
CALL ekle_musteri('Orçun', 'Balcı', 'horcun@gmail.com','05078946109', 'Kaş/Antalya')

-----------------------------------------------------------------------------------------

-- product addition procedure

CREATE OR REPLACE PROCEDURE urun_ekle(
    urun_adi VARCHAR,
    urun_fiyati NUMERIC,
    urun_aciklamasi TEXT,
    stok_durumu VARCHAR,
    stok_miktari INTEGER,
    kategori VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO public.Urunler (UrunAdi, UrunFiyati, UrunAciklamasi, stokdurumu, stok_miktari, kategori)
    VALUES (urun_adi, urun_fiyati, urun_aciklamasi, stok_durumu, stok_miktari, kategori);
END;
$$;

CALL urun_ekle('Dizüstü Bilgisayar', 6000.00, '16GB RAM, 512GB SSD', 'Stokta Var', 30, 'Teknoloji');
CALL urun_ekle('Çamaşır Makinesi', 3000.00, '9 kg, enerji tasarruflu', 'Stokta Var', 45, 'Beyaz Eşya');
CALL urun_ekle('Televizyon', 4000.00, '55 inç, 4K UHD', 'Stokta Var', 60, 'Elektronik');
CALL urun_ekle('Blender', 250.00, '5 hız, paslanmaz çelik bıçaklar', 'Stokta Var', 150, 'Mutfak Aletleri');
CALL urun_ekle('Saç Kurutma Makinesi', 150.00, '2000 watt, iyon teknolojisi', 'Stokta Var', 100, 'Kişisel Bakım');
CALL urun_ekle('Tablet', 2000.00, '10 inç, 64GB depolama', 'Stokta Var', 75, 'Elektronik');
CALL urun_ekle('Klavye', 150.00, 'Mekanik, RGB aydınlatmalı', 'Stokta Var', 200, 'Bilgisayar Aksesuarları');
CALL urun_ekle('Ofis Sandalyesi', 600.00, 'Ergonomik, ayarlanabilir', 'Stokta Var', 80, 'Ofis Mobilyası');
CALL urun_ekle('Yazıcı', 700.00, 'Kablosuz, çok fonksiyonlu', 'Stokta Var', 50, 'Ofis Ekipmanları');
CALL urun_ekle('Klima', 5000.00, '18000 BTU, enerji tasarruflu', 'Stokta Var', 30, 'Ev Aletleri');
CALL urun_ekle('Masa Lambası', 100.00, 'LED, dokunmatik kontrol', 'Stokta Var', 150, 'Aydınlatma');

-----------------------------------------------------------------------------------------

-- sales detail addition procedure

CREATE OR REPLACE PROCEDURE satisdetayi_ekle(
    p_satisid INT,
    p_urunid INT,
    p_miktar INT,
    p_toplamtutar NUMERIC
)
LANGUAGE plpgsql
AS $$
DECLARE
    mevcut_stok INT;
BEGIN
  
    -- Check the available stock of the product
    SELECT stok_miktari
    INTO mevcut_stok
    FROM urunler
    WHERE urunid = p_urunid;
    
    -- Check stock quantity
    IF mevcut_stok <= 0 THEN
        RAISE EXCEPTION 'Ürün stokta yok!';
    ELSIF mevcut_stok < p_miktar THEN
        RAISE EXCEPTION 'Yeterli stok yok!';
    ELSE
        -- Add sale details
        INSERT INTO satisdetaylari (satisid, urunid, miktar, toplamtutar)
        VALUES (p_satisid, p_urunid, p_miktar, p_toplamtutar);
        
        -- Update stock quantity
        UPDATE urunler
        SET stok_miktari = mevcut_stok - p_miktar
        WHERE urunid = p_urunid;
    END IF;
END;
$$;


CALL satisdetayi_ekle(13, 5, 101, 6000.0);

-----------------------------------------------------------------------------------------
	
-- PROCEDURE FOR ADDING STOCK QUANTITY

CREATE OR REPLACE PROCEDURE stok_miktari_arttir(
    p_urunid INT,
    p_artis_miktari INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE Urunler
    SET stok_miktari = stok_miktari + p_artis_miktari
    WHERE UrunID = p_urunid;
END;
$$;


CALL stok_miktari_arttir(1, 10);  -- Increase the stock quantity of the product with UrunID 1 by 10

-----------------------------------------------------------------------------------------

-- STORED PROCEDURE FOR ADDING EVENTS

CREATE OR REPLACE PROCEDURE etkinlik_ekle(
    p_etkinlik_basligi VARCHAR,
    p_etkinlik_tarihi DATE,
    p_etkinlik_yeri VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO Etkinlikler (EtkinlikBasligi, EtkinlikTarihi, EtkinlikYeri)
    VALUES (p_etkinlik_basligi, p_etkinlik_tarihi, p_etkinlik_yeri);
END;
$$;

-- We call the procedure we created using CALL

CALL etkinlik_ekle('Sushi Partisi', '2024-04-08', 'Balıkesir');

CALL etkinlik_ekle('Sempozyum', '2024-01-10', 'Ankara');
CALL etkinlik_ekle('Escape Room', '2024-07-15', 'İstanbul');            -- Team Building Activities
CALL etkinlik_ekle('Doğa Yürüyüşü ve Kamp', '2024-08-20', 'Bolu');
CALL etkinlik_ekle('Takım Yarışmaları', '2024-09-10', 'Antalya');


CALL etkinlik_ekle('Workshop ve Seminer', '2024-06-05', 'Ankara');  -- Training and Development Activities
CALL etkinlik_ekle('Online Eğitimler', '2024-10-10', 'Online');
CALL etkinlik_ekle('Kariyer Gelişim Günleri', '2024-11-15', 'İzmir');


CALL etkinlik_ekle('Gönüllü Çalışmalar', '2024-05-12', 'İzmir');       -- Social Responsibility Projects
CALL etkinlik_ekle('Bağış Kampanyaları', '2024-07-25', 'Bursa');


CALL etkinlik_ekle('Şirket Piknikleri', '2024-04-30', 'Ankara');     -- -- Social Events
CALL etkinlik_ekle('Tema Partileri', '2024-12-01', 'İstanbul');
CALL etkinlik_ekle('Kültürel Geziler', '2024-03-22', 'İstanbul');


CALL etkinlik_ekle('Yoga ve Meditasyon Seansları', '2024-09-05', 'Bodrum'); -- Health and Wellness Events
CALL etkinlik_ekle('Spor Aktiviteleri', '2024-10-05', 'Antalya');
CALL etkinlik_ekle('Sağlıklı Yaşam Seminerleri', '2024-11-20', 'Ankara');


CALL etkinlik_ekle('Yılbaşı Partisi', '2024-12-31', 'İstanbul');          -- Special Days and Celebrations
CALL etkinlik_ekle('Şirket Yıldönümü Kutlamaları', '2024-01-15', 'İstanbul');
CALL etkinlik_ekle('Başarı Kutlamaları', '2024-02-20', 'İstanbul');


-----------------------------------------------------------------------------------------

--FUNCTIONS

-- function showing the number of customers participating in the event

CREATE OR REPLACE FUNCTION etkinlige_katilan_musteriler(etkinlik_id INT)
RETURNS TABLE (
    EtkinlikMusteriID INT,
    EtkinlikID INT,
    MusteriI INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT em.EtkinlikMusteriID, em.EtkinlikID, em.MusteriID
    FROM EtkinlikMusteri em
    WHERE em.EtkinlikID = etkinlik_id;
END;
$$;
select * from etkinlige_katilan_musteriler(5)
-----------------------------------------------------------------------------------------

-- TABLE VALUED FUNCTION
  
CREATE OR REPLACE FUNCTION kampanya_katilim(kampanya_id INT)
RETURNS TABLE (
    MusteriAdi VARCHAR,
    eposta VARCHAR,
    telefon CHAR,
    KampanyaAdi VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT 
        CAST(m.ad || ' ' || m.soyad AS VARCHAR) AS MusteriAdi, 
        m.eposta, 
        m.telefon, 
        k.KampanyaAdi
    FROM 
        Musteriler m
    JOIN 
        EtkinlikMusteri em ON m.MusteriID = em.MusteriID
    JOIN 
        Kampanyalar k ON em.EtkinlikID = k.KampanyaID
    WHERE 
        k.KampanyaID = kampanya_id;
END;
$$;

select * from kampanya_katilim(2);

-----------------------------------------------------------------------------------------



-----------------------------------------------------------------------------------------
-- TRİGGERS
-----------------------------------------------------------------------------------------

 --STOCK QUANTITY

CREATE OR REPLACE FUNCTION stok_guncelle()
RETURNS TRIGGER AS $$
BEGIN
    -- Reduce stock quantity when sales details are added
    UPDATE Urunler
    SET stok_miktari = stok_miktari - NEW.Miktar
    WHERE UrunID = NEW.UrunID;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER satis_detayi_ekle_guncelle
AFTER INSERT OR UPDATE ON SatisDetaylari
FOR EACH ROW
EXECUTE FUNCTION stok_guncelle();

-----------------------------------------------------------------------------------------

-- IN STOCK - NONE

CREATE OR REPLACE FUNCTION stok_durumunu_guncelle()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.stok_miktari < 1 THEN
        NEW.stokdurumu := 'Stokta Yok';
    ELSE
        NEW.stokdurumu := 'Stokta Var';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER stok_durumunu_guncelle_trigger
BEFORE INSERT OR UPDATE OF stok_miktari ON public.Urunler
FOR EACH ROW
EXECUTE FUNCTION stok_durumunu_guncelle();

-----------------------------------------------------------------------------------------
-- VİEW
-----------------------------------------------------------------------------------------


CREATE OR REPLACE VIEW kampanya_etkilesim_view AS
SELECT 
    CONCAT(m.ad, ' ', m.soyad) AS musteri,
    k.kampanyaadi,
    ke.etkilesimturu,
    ke.etkilesimsonucu
FROM 
    kampanyaetkilesimleri ke
JOIN 
    musteriler m ON ke.musteriid = m.musteriid
JOIN 
    kampanyalar k ON ke.kampanyaid = k.kampanyaid;

SELECT * FROM kampanya_etkilesim_view;

-----------------------------------------------------------------------------------------

--INSERT QUERIES

-----------------------------------------------------------------------------------------

-- ADDED INTERACTION  

INSERT INTO etkilesimler (musteriid, etkilesimtarihi, etkilesimturu, etkilesimnotlari)
VALUES (7, current_date, 'SMS', 'Müşteriye ödeme hatırlatması gönderildi.');

INSERT INTO etkilesimler ( musteriid, etkilesimtarihi, etkilesimturu, etkilesimnotlari)
VALUES (8, current_date, 'SMS', 'Yeni ürünler hakkında bilgilendirme yapıldı.');

INSERT INTO etkilesimler ( musteriid, etkilesimtarihi, etkilesimturu, etkilesimnotlari)
VALUES (9, current_date, 'Eposta', 'Kampanya hakkında bilgilendirme yapıldı.');

INSERT INTO etkilesimler ( musteriid, etkilesimtarihi, etkilesimturu, etkilesimnotlari)
VALUES (10, current_date, 'Eposta', 'Müşteri memnuniyet anketi gönderildi.');

INSERT INTO etkilesimler ( musteriid, etkilesimtarihi, etkilesimturu, etkilesimnotlari)
VALUES (11, current_date, 'Telefon Araması', 'Teknik destek sağlandı.');

INSERT INTO etkilesimler ( musteriid, etkilesimtarihi, etkilesimturu, etkilesimnotlari)
VALUES (12, current_date, 'Telefon Araması', 'Satış sonrası hizmetler hakkında bilgi verildi.');

-----------------------------------------------------------------------------------------

-- ADDED SALES 
INSERT INTO Satislar (MusteriID, SatisTarihi)
VALUES (1, '2024-05-20');

-----------------------------------------------------------------------------------------

-- ADDED SALE DETAİLS
INSERT INTO SatisDetaylari (SatisID, UrunID, Miktar, ToplamTutar)
VALUES 
(3, 13, 2, 1400.00), 
(4, 9, 1, 150.00),
(5, 2, 1, 7500.00),
(6, 4, 3, 2400.00),
(7, 8, 1, 250.00),
(8, 14, 1, 5000.00),
(9, 5, 1, 6000.00); 

-----------------------------------------------------------------------------------------

-- ADDED CUSTOMER SEGMENTS
INSERT INTO public.MusteriSegmentleri (SegmentAd) 
VALUES ('Gençler'), ('Yetişkinler'), ('Yaşlılar'),('Erkekler'),('Kadınlar'),('Yeni Müşteri'), ('Potansiyel Müşteri'), ('Kayıp Müşteri'),('Eski Müşteri'),('Sadık Müşteri');


-----------------------------------------------------------------------------------------

--ADDED CAMPAİGN

INSERT INTO Kampanyalar (SegmentID, BaslangicTarihi, BitisTarihi, KampanyaAdi)
VALUES (1, '2024-06-01', '2024-06-30', 'Gençler İçin Yaz İndirimi');

INSERT INTO Kampanyalar (SegmentID, BaslangicTarihi, BitisTarihi, KampanyaAdi)
VALUES (2, '2024-07-01', '2024-07-31', 'Yetişkinler İçin Yaz Tatili İndirimi');

INSERT INTO Kampanyalar (SegmentID, BaslangicTarihi, BitisTarihi, KampanyaAdi)
VALUES (3, '2024-08-01', '2024-08-31', 'Yaşlılar İçin Sağlık Ürünleri İndirimi');

INSERT INTO Kampanyalar (SegmentID, BaslangicTarihi, BitisTarihi, KampanyaAdi)
VALUES (4, '2024-09-01', '2024-09-30', 'Kadınlar İçin Sonbahar Modası İndirimi');

INSERT INTO Kampanyalar (SegmentID, BaslangicTarihi, BitisTarihi, KampanyaAdi)
VALUES (5, '2024-10-01', '2024-10-31', 'Erkekler İçin Spor Ürünleri İndirimi');

INSERT INTO Kampanyalar (SegmentID, BaslangicTarihi, BitisTarihi, KampanyaAdi)
VALUES (6, '2024-11-01', '2024-11-30', 'Yeni Müşterilere Hoş Geldiniz İndirimi');

INSERT INTO Kampanyalar (SegmentID, BaslangicTarihi, BitisTarihi, KampanyaAdi)
VALUES (7, '2024-12-01', '2024-12-31', 'Potansiyel Müşterilere Özel Yılbaşı İndirimi');

INSERT INTO Kampanyalar (SegmentID, BaslangicTarihi, BitisTarihi, KampanyaAdi)
VALUES (8, '2025-01-01', '2025-01-31', 'Geri Dönüş İndirimi');


INSERT INTO Kampanyalar (SegmentID, BaslangicTarihi, BitisTarihi, KampanyaAdi)
VALUES (9, '2025-02-01', '2025-02-28', 'Tekrarlı Alışverişlerde 3 al 2 öde');

INSERT INTO Kampanyalar (SegmentID, BaslangicTarihi, BitisTarihi, KampanyaAdi)
VALUES (10, '2025-03-01', '2025-03-31', 'Sadık Müşterilere Özel Bahar İndirimi');

-----------------------------------------------------------------------------------------

--ADDED CAMPAIGN INTERACTION.

INSERT INTO kampanyaetkilesimleri (kampanyaid, musteriid, etkilesimtarihi, etkilesimturu, etkilesimsonucu) -- Olumlu sonuçlu etkileşimler
VALUES
(10,1, '2024-05-01', 'E-posta', 'olumlu'),
(9,2, '2024-05-02', 'SMS', 'olumlu'),
(7,3, '2024-05-03', 'Telefon', 'olumlu');


INSERT INTO kampanyaetkilesimleri (kampanyaid, musteriid, etkilesimtarihi, etkilesimturu, etkilesimsonucu) -- Olumsuz sonuçlu etkileşimler
VALUES
(3,4, '2024-05-04', 'E-posta', 'olumsuz'),
(5,5, '2024-05-05', 'SMS', 'olumsuz'),
(4,6, '2024-05-06', 'Telefon', 'olumsuz');

INSERT INTO kampanyaetkilesimleri (kampanyaid, musteriid, etkilesimtarihi, etkilesimturu, etkilesimsonucu). -- Beklemede olan etkileşimler
VALUES
(6,7, '2024-05-07', 'E-posta', 'beklemede'),
(8,8,'2024-05-08', 'SMS', 'beklemede'),
(2, 9,'2024-05-09', 'Telefon', 'beklemede');

-----------------------------------------------------------------------------------------

--ADDED EVENT
INSERT INTO Etkinlikler ( EtkinlikBasligi, EtkinlikTarihi, EtkinlikYeri)
VALUES ( 'Yaza Merhaba', '2024-06-01', 'Antalya');


INSERT INTO Etkinlikler ( EtkinlikBasligi, EtkinlikTarihi, EtkinlikYeri)
VALUES ( 'Ürün Lansmanı', '2024-07-01', 'Ankara');

INSERT INTO Etkinlikler ( EtkinlikBasligi, EtkinlikTarihi, EtkinlikYeri)
VALUES ('Müşteri Memnuniyeti Toplantısı', '2024-08-20', 'İzmir');

-----------------------------------------------------------------------------------------

--ADDED DATA TO THE ACTIVITY CUSTOMER TABLE.

INSERT INTO EtkinlikMusteri (EtkinlikID, MusteriID)
VALUES (1, 1),
	   (1, 2),
	   (1, 3),
	   (1, 4),
	   (1, 5),
   	   (2, 1),
       (2, 2),
	   (2, 3),
	   (3, 1);

-----------------------------------------------------------------------------------------

--ADDED DATA TO NOTES

INSERT INTO notlar ( musteriid, nottarihi, noticerigi)
VALUES
(1, '2024-05-01', 'Müşteri memnuniyeti anketi yapıldı.'),
(2, '2024-05-02', 'Yeni ürün önerileri alındı.'),
(3, '2024-05-03', 'Teknik destek sağlandı ve memnuniyet kaydedildi.'),
(4, '2024-05-04', 'Müşteri ile kampanya hakkında telefon görüşmesi yapıldı.'),
(5, '2024-05-05', 'İade süreci ile ilgili müşteri bilgilendirildi.'),
(6, '2024-05-06', 'Müşteri memnuniyeti anketi yapıldı ve geri bildirim alındı.'),
(7, '2024-05-07', 'Yeni hizmetler hakkında bilgilendirme e-postası gönderildi.'),
(8, '2024-05-08', 'Müşteri şikayeti çözüldü ve memnuniyet sağlandı.'),
(9, '2024-05-09', 'Müşteri ile yapılan toplantı notları kaydedildi.'),
(10, '2024-05-10', 'Müşteri memnuniyeti anketi yapıldı ve sonuçlar olumlu.');

-----------------------------------------------------------------------------------------

--SUPPORT REQUESTS ADDED.

INSERT INTO destektalepleri (musteriid, taleptarihi, durum, aciklama)
VALUES
(1, '2024-05-01', 'Alındı', 'Ürün kurulumunda sorun yaşandı.'),
(2, '2024-05-02', 'Değerlendirildi', 'Fatura ile ilgili yardım talebi.'),
(3, '2024-05-03', 'Alındı', 'Garanti süresi hakkında bilgi istendi.'),
(4, '2024-05-04', 'Değerlendirildi', 'Hesap bilgilerinde güncelleme yapılması talebi.'),
(5, '2024-05-05', 'Alındı', 'Yazılım güncellemesi sırasında hata alınıyor.'),
(6, '2024-05-06', 'Değerlendirildi', 'İade ve değişim prosedürleri hakkında soru.'),
(7, '2024-05-07', 'Alındı', 'Teknik destek talebi.'),
(8, '2024-05-08', 'Değerlendirildi', 'Kargo takibi hakkında bilgi talebi.'),
(9, '2024-05-09', 'Alındı', 'Yeni ürün önerileri hakkında geri bildirim.'),
(10, '2024-05-10', 'Değerlendirildi', 'Müşteri memnuniyeti anketi sonrası destek talebi.');

-----------------------------------------------------------------------------------------


--SELECT QUERIES 

SELECT m.musteriid, m.ad, m.soyad, k.kampanyaadi, k.baslangictarihi, k.bitistarihi
FROM musteriler m
JOIN kampanyaetkilesimleri ke ON m.musteriid = ke.musteriid
JOIN kampanyalar k ON ke.kampanyaid = k.kampanyaid;


-- it only selects interactions that are positive.
SELECT *
FROM kampanya_etkilesim_view
WHERE etkilesimsonucu = 'olumlu';



-- sorts customers whose name ends with e by name. 
SELECT *
FROM musteriler
WHERE ad LIKE '%e'
ORDER BY ad;


 -- Lists the products and categories with stock quantity more than 50 in ascending order according to their prices.
SELECT u.urunadi, u.urunfiyati, u.stok_miktari
FROM urunler u
WHERE u.stok_miktari > 50
ORDER BY u.urunfiyati ASC;



-- GROUP BY --
--Lists the total amount of expenditure for each customer. 
SELECT m.ad, m.soyad, SUM(sd.toplamtutar) AS toplam_harcama
FROM musteriler m
JOIN satislar s ON m.musteriid = s.musteriid
JOIN satisdetaylari sd ON s.satisid = sd.satisid
GROUP BY m.ad, m.soyad
ORDER BY toplam_harcama DESC;



--Lists customers who interacted with a specific campaign. 
SELECT m.ad, m.soyad, k.kampanyaadi, ke.etkilesimtarihi
FROM kampanyalar k
JOIN kampanyaetkilesimleri ke ON k.kampanyaid = ke.kampanyaid
JOIN musteriler m ON ke.musteriid = m.musteriid
WHERE k.kampanyaid = 2;


--Lists the most recent sales in descending order by date.
SELECT s.satisid, m.ad, m.soyad, s.satistarihi
FROM satislar s
JOIN musteriler m ON s.musteriid = m.musteriid
ORDER BY s.satistarihi DESC;


--Lists the sales made by a specific customer.
SELECT m.ad, m.soyad, u.urunadi, s.satistarihi, sd.miktar
FROM musteriler m
JOIN satislar s ON m.musteriid = s.musteriid
JOIN satisdetaylari sd ON s.satisid = sd.satisid
JOIN urunler u ON sd.urunid = u.urunid
WHERE m.musteriid = 1;




--Update the start and end dates of a specific campaign.

UPDATE kampanyalar
SET baslangictarihi = '2024-06-01', bitistarihi = '2024-06-30'
WHERE kampanyaid = 3;



INSERT INTO Satislar (MusteriID, SatisTarihi)
VALUES (1, '2024-05-26');

INSERT INTO Satislar (MusteriID, SatisTarihi)
VALUES (2, '2024-05-26');

INSERT INTO Satislar (MusteriID, SatisTarihi)
VALUES (3, '2024-05-26');

INSERT INTO Satislar (MusteriID, SatisTarihi)
VALUES (4, '2024-05-26');





