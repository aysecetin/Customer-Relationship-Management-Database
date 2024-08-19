# CRM DATABASE PROJECT 📊👩🏻‍💻

🤓 my database project with postgresql for database management and modelling lecture  

## Overview 👀
This project is a Customer Relationship Management (CRM) system built using PostgreSQL. It includes various tables and relationships to manage customers, their interactions, campaigns, sales, support requests, and product details. The database schema is designed to efficiently track customer engagement, campaign effectiveness, and inventory management.

## Database Schema 📈
The schema includes the following tables:  

- musteriler: Stores customer details such as name, phone, email, and address.  
- musteritercihleri: Captures customer preferences for targeted campaigns.  
- musterinotlar: Notes related to customers for tracking interactions.  
- musterisegmentleri: Stores segments such as young, old, female, male...   
- kampanyalar: Manages promotional campaigns with start and end dates.  
- kampanyaetkilesimleri: Tracks interactions between campaigns and customers.  
- satislar: Records customer purchases.   
- urunler: Details of products available for sale, including stock and pricing.    
- satısdetayları: Tracks individual product quantities within each sale.    
- destektalepleri: Manages customer support requests.    
- etkinlikler: Events organized for customer engagement.   
- etkinlikmusteri: Links events to participating customers.    
- etkilesimler: Stores sales event details.

## Key Features 🗝

## 1. Inventory Management with Triggers
The system includes triggers that monitor stok_miktari (stock quantity) in the urunler table. When a sale is attempted, the trigger checks whether sufficient stock is available. If not, the sale is prevented, and an error message is returned. This ensures that products are only sold if there is enough stock to fulfill the order.

```sql

CREATE OR REPLACE FUNCTION check_stock()
RETURNS TRIGGER AS $$
BEGIN
   IF NEW.miktar > (SELECT stok_miktari FROM urunler WHERE urunid = NEW.urunid) THEN
      RAISE EXCEPTION 'Not enough stock available';
   END IF;
   RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER before_sale_insert
BEFORE INSERT ON satdetekiler
FOR EACH ROW
EXECUTE FUNCTION check_stock();
```

## 2. Campaign Management 👁️‍🗨️
The kampanyalar table manages marketing campaigns with details like start and end dates, allowing the system to define specific promotion periods.
Campaigns are linked to customer segments through the musteritercihleri and kampanyaetkilesimleri tables, enabling targeted marketing strategies.
kampanyaetkilesimleri tracks how customers respond to different campaigns, providing insights into campaign effectiveness.

## 3. Customer Support Tracking 
The destektalepleri table manages customer support requests, providing detailed tracking of:

Request status, categorized into stages such as open, in progress, or resolved.
Request description, storing customer-reported issues.
Request date to track the timeline of issues.
This table allows the support team to efficiently manage customer support tickets and ensure timely responses.

## 4. Customer Interaction and Preferences 👩🏻‍💼
The musteriler table stores all key customer data, including personal information like name, phone number, email, and address, which is essential for managing customer relationships.
musteritercihleri stores customer preferences for targeted campaigns. For example, customers can specify which types of campaigns they prefer (e.g., discount offers, new product alerts).
etkilesimler tracks specific interactions between the customer and the business, providing valuable data on customer engagement.

## 5. Event Management 🎫🧘🏻‍♀️
The etkinlikler table records customer events, such as webinars, product launches, or promotional gatherings.
etkinlikmusteri links events with the customers who participated in them, allowing for detailed tracking of customer involvement and engagement.
The system tracks event dates, locations, and any notable event-related notes, giving a clear picture of how well customers are engaging with company-hosted activities.

## 6. Sales Tracking 🧾
The satislar table logs each sale made to customers, including the date of the sale and the customer’s unique ID.
The satdetekiler table provides detailed information on each product included in a sale. It links to the urunler table to retrieve the product information, and it stores the quantity sold and total price.

## 7. Product Management 💻🖱️
The urunler table stores information on products, including:
Product name and description
Stock quantity (stok_miktari), which is automatically updated as sales occur.
Price and category to support efficient inventory and sales management.
The stok miktarı field is automatically monitored by triggers that prevent sales if the available stock is insufficient.

## How to Use 🛠️
You can query customer information, campaign details, and sales records using standard SQL queries.
Sales records are automatically checked against stock availability via the triggers, ensuring no sales are processed without adequate stock.
Campaign effectiveness can be tracked by querying the kampanyaetkilesimleri table.

## Contribution
Feel free to submit issues or contribute via pull requests to improve the database structure or features. All contributions are welcome!  

----------------------------------------------------------------------------------------------------------------------------------------

## TÜRKÇE 🇹🇷

# MÜŞTERİ İLİŞKİLERİ YÖNETİMİ VERİTABANI PROJESI 📊👩🏻‍💻
🤓 veritabanı yönetimi ve modellemesi dersi için postgresql ile hazırladığım veritabanı projem

## Genel Bakış 👀
Bu proje PostgreSQL kullanılarak oluşturulmuş bir Müşteri İlişkileri Yönetimi (CRM) sistemidir. Müşterileri, etkileşimlerini, kampanyalarını, satışlarını, destek taleplerini ve ürün ayrıntılarını yönetmek için çeşitli tablolar ve ilişkiler içerir. Veritabanı şeması, müşteri katılımını, kampanya etkinliğini ve envanter yönetimini verimli bir şekilde izlemek için tasarlanmıştır.

## Veritabanı Şeması 📈
Şema aşağıdaki tabloları içerir:

musteriler: Ad, telefon, e-posta ve adres gibi müşteri ayrıntılarını depolar.  
musteritercihleri: Hedefli kampanyalar için müşteri tercihlerini yakalar.  
musterinotlar: Etkileşimleri izlemek için müşterilerle ilgili notlar.  
musterisegmentleri: Genç, yaşlı, kadın, erkek... gibi segmentleri saklar.  
kampanyalar: Başlangıç ve bitiş tarihleri ile promosyon kampanyalarını yönetir.  
kampanyaetkilesimleri: Kampanyalar ve müşteriler arasındaki etkileşimleri izler.  
satislar: Müşteri satın alımlarını kaydeder.  
urunler: Stok ve fiyatlandırma dahil olmak üzere satışa sunulan ürünlerin ayrıntıları.  
satısdetayları: Her satıştaki bireysel ürün miktarlarını izler.  
destektalepleri: Müşteri destek taleplerini yönetir.  
etkinlikler: Müşteri katılımı için düzenlenen etkinlikler.  
etkinlikmusteri: Etkinlikleri katılımcı müşterilere bağlar.  
etkilesimler: Satış etkinliği ayrıntılarını depolar.  

## Temel Özellikler 🗝
### 1. Tetikleyicilerle Envanter Yönetimi

Sistem, urunler tablosunda stok_miktari (stok miktarı) izleyen tetikleyiciler içerir. Bir satış girişiminde bulunulduğunda, tetikleyici yeterli stok olup olmadığını kontrol eder. 
Eğer yoksa, satış engellenir ve bir hata mesajı döndürülür. Bu, ürünlerin yalnızca siparişi karşılamaya yetecek kadar stok varsa satılmasını sağlar.

```sql

CREATE OR REPLACE FUNCTION check_stock()
RETURNS TRIGGER AS $$
BEGIN
   IF NEW.miktar > (SELECT stok_miktari FROM urunler WHERE urunid = NEW.urunid) THEN
      RAISE EXCEPTION 'Not enough stock available';
   END IF;
   RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER before_sale_insert
BEFORE INSERT ON satdetekiler
FOR EACH ROW
EXECUTE FUNCTION check_stock();
```

## 2. Kampanya Yönetimi 👁️‍🗨️
Kampanyalar tablosu, başlangıç ve bitiş tarihleri gibi ayrıntılarla pazarlama kampanyalarını yönetir ve sistemin belirli promosyon dönemlerini tanımlamasına olanak tanır. Kampanyalar, musteritercihleri ve kampanyaetkilesimleri tabloları aracılığıyla müşteri segmentleriyle ilişkilendirilerek hedefli pazarlama stratejilerine olanak tanır. kampanyaetkilesimleri, müşterilerin farklı kampanyalara nasıl yanıt verdiğini izleyerek kampanya etkinliğine ilişkin içgörüler sağlar.

## 3. Müşteri Destek Takibi
Destektalepleri tablosu, müşteri destek taleplerini yöneterek ayrıntılı izleme sağlar:

Açık, devam ediyor veya çözüldü gibi aşamalara kategorize edilen talep durumu. Müşteri tarafından bildirilen sorunları depolayan talep açıklaması. Sorunların zaman çizelgesini izlemek için talep tarihi. Bu tablo, destek ekibinin müşteri destek taleplerini verimli bir şekilde yönetmesini ve zamanında yanıt vermesini sağlar.

## 4. Müşteri Etkileşimi ve Tercihleri 👩🏻‍💼
Musteriler tablosu, müşteri ilişkilerini yönetmek için gerekli olan ad, telefon numarası, e-posta ve adres gibi kişisel bilgiler de dahil olmak üzere tüm önemli müşteri verilerini depolar. musteritercihleri, hedeflenen kampanyalar için müşteri tercihlerini depolar. Örneğin, müşteriler hangi tür kampanyaları tercih ettiklerini belirtebilirler (örneğin, indirim teklifleri, yeni ürün uyarıları). etkilesimler, müşteri ile işletme arasındaki belirli etkileşimleri izleyerek müşteri katılımı hakkında değerli veriler sağlar.

## 5. Etkinlik Yönetimi 🎫🧘🏻‍♀️
Etkinlikler tablosu, web seminerleri, ürün lansmanları veya tanıtım toplantıları gibi müşteri etkinliklerini kaydeder. etkinlikmusteri, etkinlikleri bunlara katılan müşterilerle ilişkilendirerek müşteri katılımı ve etkileşiminin ayrıntılı olarak izlenmesine olanak tanır. Sistem, etkinlik tarihlerini, konumlarını ve etkinlikle ilgili kayda değer notları izleyerek müşterilerin şirketin ev sahipliği yaptığı etkinliklere ne kadar iyi katılım gösterdiğine dair net bir resim sunar.

## 6. Satış Takibi 🧾
Satislar tablosu, satış tarihi ve müşterinin benzersiz kimliği de dahil olmak üzere müşterilere yapılan her satışı kaydeder. Satdetekiler tablosu, bir satışta yer alan her ürün hakkında ayrıntılı bilgi sağlar. Ürün bilgilerini almak için urunler tablosuna bağlanır ve satılan miktarı ve toplam fiyatı depolar.

## 7. Ürün Yönetimi 💻🖱️
urunler tablosu, aşağıdakiler de dahil olmak üzere ürünlerle ilgili bilgileri depolar: Ürün adı ve açıklaması Satış gerçekleştikçe otomatik olarak güncellenen stok miktarı (stok_miktari). Etkin envanter ve satış yönetimini desteklemek için fiyat ve kategori. Stok miktarı alanı, mevcut stoğun yetersiz olması durumunda satışları engelleyen tetikleyiciler tarafından otomatik olarak izlenir.

## 🛠️ Nasıl Kullanılır?
Standart SQL sorgularını kullanarak müşteri bilgilerini, kampanya ayrıntılarını ve satış kayıtlarını sorgulayabilirsiniz. Satış kayıtları, tetikleyiciler aracılığıyla stok mevcudiyetine göre otomatik olarak kontrol edilir ve yeterli stok olmadan hiçbir satışın işlenmemesi sağlanır. Kampanyetkilesimleri tablosu sorgulanarak kampanya etkinliği takip edilebilir.

## Katkı
Veritabanı yapısını veya özelliklerini geliştirmek için sorun göndermekten veya çekme istekleri yoluyla katkıda bulunmaktan çekinmeyin. Tüm katkılara açığız!
