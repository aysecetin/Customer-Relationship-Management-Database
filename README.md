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

