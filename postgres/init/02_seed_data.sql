-- ============================================
-- E-commerce Seed Data
-- ============================================
-- Sample data for demonstration and testing purposes
-- Includes realistic e-commerce scenarios

SET search_path TO ecommerce;

-- ============================================
-- Seed Customers (50 customers)
-- ============================================
INSERT INTO customers (email, first_name, last_name, country, city, registration_date, last_login, customer_status) VALUES
('john.doe@email.com', 'John', 'Doe', 'US', 'New York', '2023-01-15', '2024-10-20', 'active'),
('jane.smith@email.com', 'Jane', 'Smith', 'GB', 'London', '2023-02-20', '2024-10-18', 'active'),
('mike.johnson@email.com', 'Mike', 'Johnson', 'CA', 'Toronto', '2023-03-10', '2024-10-15', 'active'),
('sara.williams@email.com', 'Sara', 'Williams', 'AU', 'Sydney', '2023-04-05', '2024-10-22', 'active'),
('david.brown@email.com', 'David', 'Brown', 'DE', 'Berlin', '2023-05-12', '2024-10-19', 'active'),
('emma.davis@email.com', 'Emma', 'Davis', 'FR', 'Paris', '2023-06-18', '2024-10-21', 'active'),
('alex.miller@email.com', 'Alex', 'Miller', 'US', 'Los Angeles', '2023-07-22', '2024-10-17', 'active'),
('lisa.wilson@email.com', 'Lisa', 'Wilson', 'GB', 'Manchester', '2023-08-09', '2024-10-16', 'active'),
('tom.moore@email.com', 'Tom', 'Moore', 'CA', 'Vancouver', '2023-09-14', '2024-10-14', 'active'),
('anna.taylor@email.com', 'Anna', 'Taylor', 'AU', 'Melbourne', '2023-10-03', '2024-10-23', 'active'),
('chris.anderson@email.com', 'Chris', 'Anderson', 'US', 'Chicago', '2023-11-20', '2024-10-12', 'active'),
('maria.thomas@email.com', 'Maria', 'Thomas', 'DE', 'Munich', '2023-12-05', '2024-10-11', 'active'),
('robert.jackson@email.com', 'Robert', 'Jackson', 'FR', 'Lyon', '2024-01-08', '2024-10-10', 'active'),
('sophia.white@email.com', 'Sophia', 'White', 'US', 'Houston', '2024-02-14', '2024-10-09', 'active'),
('james.harris@email.com', 'James', 'Harris', 'GB', 'Birmingham', '2024-03-19', '2024-10-08', 'active'),
('olivia.martin@email.com', 'Olivia', 'Martin', 'CA', 'Montreal', '2024-04-25', '2024-10-07', 'active'),
('william.thompson@email.com', 'William', 'Thompson', 'AU', 'Brisbane', '2024-05-30', '2024-10-06', 'active'),
('ava.garcia@email.com', 'Ava', 'Garcia', 'DE', 'Hamburg', '2024-06-12', '2024-10-05', 'active'),
('benjamin.martinez@email.com', 'Benjamin', 'Martinez', 'FR', 'Marseille', '2024-07-18', '2024-10-04', 'active'),
('mia.robinson@email.com', 'Mia', 'Robinson', 'US', 'Phoenix', '2024-08-22', '2024-10-03', 'active'),
('lucas.clark@email.com', 'Lucas', 'Clark', 'GB', 'Leeds', '2024-09-05', '2024-10-02', 'active'),
('charlotte.rodriguez@email.com', 'Charlotte', 'Rodriguez', 'CA', 'Calgary', '2024-09-15', '2024-10-01', 'active'),
('henry.lewis@email.com', 'Henry', 'Lewis', 'AU', 'Perth', '2024-09-20', '2024-09-30', 'active'),
('amelia.lee@email.com', 'Amelia', 'Lee', 'DE', 'Frankfurt', '2024-09-25', '2024-09-29', 'active'),
('alexander.walker@email.com', 'Alexander', 'Walker', 'FR', 'Nice', '2024-09-28', '2024-09-28', 'active'),
('isabella.hall@email.com', 'Isabella', 'Hall', 'US', 'San Antonio', '2023-05-01', NULL, 'inactive'),
('daniel.allen@email.com', 'Daniel', 'Allen', 'GB', 'Glasgow', '2023-06-15', NULL, 'inactive'),
('emily.young@email.com', 'Emily', 'Young', 'CA', 'Ottawa', '2023-07-20', '2024-08-15', 'active'),
('matthew.hernandez@email.com', 'Matthew', 'Hernandez', 'AU', 'Adelaide', '2023-08-25', '2024-09-10', 'active'),
('elizabeth.king@email.com', 'Elizabeth', 'King', 'DE', 'Stuttgart', '2023-09-30', '2024-10-01', 'active'),
('joseph.wright@email.com', 'Joseph', 'Wright', 'FR', 'Toulouse', '2023-10-10', '2024-09-20', 'active'),
('sofia.lopez@email.com', 'Sofia', 'Lopez', 'US', 'San Diego', '2023-11-05', '2024-09-15', 'active'),
('michael.hill@email.com', 'Michael', 'Hill', 'GB', 'Liverpool', '2023-12-12', '2024-09-12', 'active'),
('victoria.scott@email.com', 'Victoria', 'Scott', 'CA', 'Edmonton', '2024-01-18', '2024-09-08', 'active'),
('anthony.green@email.com', 'Anthony', 'Green', 'AU', 'Canberra', '2024-02-22', '2024-09-05', 'active'),
('madison.adams@email.com', 'Madison', 'Adams', 'DE', 'Dresden', '2024-03-28', '2024-09-01', 'active'),
('joshua.baker@email.com', 'Joshua', 'Baker', 'FR', 'Bordeaux', '2024-04-15', '2024-08-28', 'active'),
('grace.nelson@email.com', 'Grace', 'Nelson', 'US', 'Dallas', '2024-05-20', '2024-08-25', 'active'),
('andrew.carter@email.com', 'Andrew', 'Carter', 'GB', 'Bristol', '2024-06-25', '2024-08-20', 'active'),
('chloe.mitchell@email.com', 'Chloe', 'Mitchell', 'CA', 'Winnipeg', '2024-07-30', '2024-08-15', 'active'),
('ryan.perez@email.com', 'Ryan', 'Perez', 'AU', 'Hobart', '2024-08-10', '2024-08-10', 'active'),
('lily.roberts@email.com', 'Lily', 'Roberts', 'DE', 'Cologne', '2024-08-15', '2024-08-05', 'active'),
('nathan.turner@email.com', 'Nathan', 'Turner', 'FR', 'Strasbourg', '2024-08-20', '2024-08-01', 'active'),
('zoe.phillips@email.com', 'Zoe', 'Phillips', 'US', 'San Jose', '2024-08-25', '2024-07-28', 'active'),
('samuel.campbell@email.com', 'Samuel', 'Campbell', 'GB', 'Sheffield', '2024-09-01', '2024-07-25', 'active'),
('hannah.parker@email.com', 'Hannah', 'Parker', 'CA', 'Quebec City', '2024-09-05', '2024-07-20', 'active'),
('christian.evans@email.com', 'Christian', 'Evans', 'AU', 'Darwin', '2024-09-10', '2024-07-15', 'active'),
('audrey.edwards@email.com', 'Audrey', 'Edwards', 'DE', 'Leipzig', '2024-09-15', '2024-07-10', 'active'),
('jack.collins@email.com', 'Jack', 'Collins', 'FR', 'Nantes', '2024-09-20', '2024-07-05', 'active'),
('scarlett.stewart@email.com', 'Scarlett', 'Stewart', 'US', 'Austin', '2024-09-25', '2024-07-01', 'active');

-- ============================================
-- Seed Products (30 products across categories)
-- ============================================
INSERT INTO products (product_name, category, subcategory, brand, price, cost, stock_quantity, product_status) VALUES
-- Electronics
('Laptop Pro 15"', 'Electronics', 'Computers', 'TechBrand', 1299.99, 800.00, 50, 'active'),
('Wireless Mouse', 'Electronics', 'Accessories', 'TechBrand', 29.99, 12.00, 200, 'active'),
('USB-C Hub', 'Electronics', 'Accessories', 'TechBrand', 49.99, 20.00, 150, 'active'),
('Smartphone X1', 'Electronics', 'Mobile', 'MobileCo', 899.99, 550.00, 80, 'active'),
('Tablet 10"', 'Electronics', 'Mobile', 'MobileCo', 499.99, 300.00, 60, 'active'),
('Wireless Earbuds', 'Electronics', 'Audio', 'SoundWave', 149.99, 70.00, 120, 'active'),
('Bluetooth Speaker', 'Electronics', 'Audio', 'SoundWave', 79.99, 35.00, 100, 'active'),
('4K Monitor 27"', 'Electronics', 'Displays', 'ViewTech', 399.99, 220.00, 40, 'active'),
-- Home & Kitchen
('Coffee Maker Pro', 'Home & Kitchen', 'Appliances', 'HomePlus', 89.99, 45.00, 75, 'active'),
('Blender 1000W', 'Home & Kitchen', 'Appliances', 'HomePlus', 69.99, 30.00, 90, 'active'),
('Non-Stick Pan Set', 'Home & Kitchen', 'Cookware', 'ChefMaster', 129.99, 60.00, 55, 'active'),
('Knife Set 6-piece', 'Home & Kitchen', 'Cookware', 'ChefMaster', 79.99, 35.00, 70, 'active'),
('Vacuum Cleaner', 'Home & Kitchen', 'Cleaning', 'CleanHome', 199.99, 100.00, 45, 'active'),
('Air Purifier', 'Home & Kitchen', 'Air Quality', 'PureAir', 149.99, 75.00, 50, 'active'),
-- Fashion
('Running Shoes', 'Fashion', 'Footwear', 'SportStyle', 89.99, 40.00, 150, 'active'),
('Casual T-Shirt', 'Fashion', 'Clothing', 'UrbanWear', 24.99, 10.00, 300, 'active'),
('Jeans Classic Fit', 'Fashion', 'Clothing', 'UrbanWear', 59.99, 25.00, 200, 'active'),
('Leather Jacket', 'Fashion', 'Outerwear', 'StyleCo', 249.99, 120.00, 40, 'active'),
('Sunglasses UV400', 'Fashion', 'Accessories', 'StyleCo', 39.99, 15.00, 180, 'active'),
('Leather Wallet', 'Fashion', 'Accessories', 'StyleCo', 34.99, 12.00, 220, 'active'),
-- Books & Media
('Bestseller Novel', 'Books', 'Fiction', 'PublishCo', 19.99, 8.00, 500, 'active'),
('Cookbook Italian', 'Books', 'Cooking', 'PublishCo', 29.99, 12.00, 150, 'active'),
('Yoga Mat Premium', 'Sports', 'Fitness', 'FitLife', 39.99, 15.00, 130, 'active'),
('Dumbbell Set 20kg', 'Sports', 'Fitness', 'FitLife', 119.99, 60.00, 65, 'active'),
('Gaming Keyboard RGB', 'Electronics', 'Gaming', 'GameTech', 129.99, 55.00, 85, 'active'),
('Gaming Mouse Pro', 'Electronics', 'Gaming', 'GameTech', 79.99, 35.00, 110, 'active'),
('Office Chair Ergonomic', 'Furniture', 'Office', 'ComfortZone', 299.99, 150.00, 30, 'active'),
('Standing Desk', 'Furniture', 'Office', 'ComfortZone', 449.99, 220.00, 25, 'active'),
('Smart Watch Pro', 'Electronics', 'Wearables', 'TechBrand', 349.99, 180.00, 70, 'active'),
('Backpack Travel 40L', 'Fashion', 'Bags', 'TravelGear', 89.99, 40.00, 95, 'active');

-- ============================================
-- Seed Orders (100 orders)
-- ============================================
-- Generate orders across different dates and statuses
INSERT INTO orders (customer_id, order_date, order_status, total_amount, discount_amount, shipping_cost, tax_amount, payment_method, shipping_address) VALUES
(1, '2024-01-05 10:30:00', 'delivered', 1349.98, 50.00, 0.00, 107.99, 'credit_card', '123 Main St, New York, NY'),
(2, '2024-01-08 14:20:00', 'delivered', 89.99, 0.00, 10.00, 8.00, 'paypal', '45 Oxford St, London, UK'),
(3, '2024-01-12 09:15:00', 'delivered', 549.97, 20.00, 15.00, 47.25, 'credit_card', '789 King St, Toronto, ON'),
(1, '2024-01-20 16:45:00', 'delivered', 229.98, 0.00, 0.00, 18.39, 'credit_card', '123 Main St, New York, NY'),
(4, '2024-01-25 11:30:00', 'delivered', 899.99, 0.00, 20.00, 73.60, 'debit_card', '321 Beach Rd, Sydney, NSW'),
(5, '2024-02-02 13:50:00', 'delivered', 439.96, 15.00, 12.00, 37.36, 'credit_card', '567 Unter den Linden, Berlin, Germany'),
(6, '2024-02-10 10:10:00', 'delivered', 179.97, 0.00, 8.00, 15.04, 'paypal', '890 Rue de Rivoli, Paris, France'),
(2, '2024-02-15 15:25:00', 'delivered', 499.99, 25.00, 0.00, 39.99, 'credit_card', '45 Oxford St, London, UK'),
(7, '2024-02-22 12:40:00', 'delivered', 159.98, 0.00, 10.00, 13.60, 'debit_card', '234 Sunset Blvd, Los Angeles, CA'),
(8, '2024-03-01 09:20:00', 'delivered', 1299.99, 100.00, 0.00, 95.99, 'credit_card', '678 Portland St, Manchester, UK'),
(3, '2024-03-08 14:35:00', 'delivered', 329.97, 10.00, 15.00, 28.25, 'paypal', '789 King St, Toronto, ON'),
(9, '2024-03-15 11:15:00', 'delivered', 649.97, 30.00, 18.00, 54.56, 'credit_card', '456 Granville St, Vancouver, BC'),
(10, '2024-03-22 16:50:00', 'delivered', 149.99, 0.00, 12.00, 12.96, 'debit_card', '123 Collins St, Melbourne, VIC'),
(11, '2024-04-01 10:05:00', 'delivered', 89.99, 0.00, 10.00, 8.00, 'paypal', '789 Michigan Ave, Chicago, IL'),
(12, '2024-04-10 13:30:00', 'delivered', 209.97, 0.00, 8.00, 17.44, 'credit_card', '234 Maximilianstr, Munich, Germany'),
(13, '2024-04-18 15:45:00', 'delivered', 129.99, 0.00, 10.00, 11.19, 'debit_card', '567 Rue de la République, Lyon, France'),
(1, '2024-04-25 09:50:00', 'delivered', 449.98, 20.00, 0.00, 34.39, 'credit_card', '123 Main St, New York, NY'),
(14, '2024-05-02 12:20:00', 'delivered', 899.99, 50.00, 0.00, 67.99, 'paypal', '890 Main St, Houston, TX'),
(15, '2024-05-10 14:40:00', 'delivered', 399.99, 0.00, 15.00, 33.25, 'credit_card', '345 Broad St, Birmingham, UK'),
(16, '2024-05-18 10:55:00', 'delivered', 69.99, 0.00, 10.00, 6.40, 'debit_card', '678 Saint Catherine St, Montreal, QC'),
(4, '2024-05-25 16:15:00', 'delivered', 179.98, 0.00, 12.00, 15.36, 'paypal', '321 Beach Rd, Sydney, NSW'),
(17, '2024-06-01 11:30:00', 'delivered', 549.98, 25.00, 0.00, 42.00, 'credit_card', '901 Queen St, Brisbane, QLD'),
(18, '2024-06-08 13:45:00', 'delivered', 249.99, 0.00, 10.00, 20.80, 'debit_card', '234 Reeperbahn, Hamburg, Germany'),
(19, '2024-06-15 15:20:00', 'delivered', 39.99, 0.00, 8.00, 3.84, 'paypal', '567 La Canebière, Marseille, France'),
(7, '2024-06-22 09:35:00', 'delivered', 199.98, 0.00, 10.00, 16.80, 'credit_card', '234 Sunset Blvd, Los Angeles, CA'),
(20, '2024-07-01 12:50:00', 'delivered', 349.99, 15.00, 0.00, 26.79, 'debit_card', '789 Central Ave, Phoenix, AZ'),
(21, '2024-07-10 14:10:00', 'delivered', 89.99, 0.00, 10.00, 8.00, 'paypal', '345 The Headrow, Leeds, UK'),
(22, '2024-07-18 10:25:00', 'delivered', 129.99, 0.00, 12.00, 11.36, 'credit_card', '678 17th Ave SW, Calgary, AB'),
(23, '2024-07-25 16:40:00', 'delivered', 499.99, 20.00, 15.00, 41.25, 'debit_card', '901 Murray St, Perth, WA'),
(5, '2024-08-01 11:55:00', 'delivered', 79.99, 0.00, 10.00, 7.20, 'paypal', '567 Unter den Linden, Berlin, Germany'),
(24, '2024-08-08 13:15:00', 'shipped', 449.99, 0.00, 0.00, 35.99, 'credit_card', '234 Kaiserstraße, Frankfurt, Germany'),
(25, '2024-08-15 15:30:00', 'shipped', 159.98, 0.00, 10.00, 13.60, 'debit_card', '567 Promenade des Anglais, Nice, France'),
(26, '2024-08-22 09:45:00', 'processing', 299.99, 10.00, 15.00, 25.25, 'paypal', '890 Commerce St, San Antonio, TX'),
(27, '2024-08-29 12:00:00', 'processing', 89.99, 0.00, 10.00, 8.00, 'credit_card', '123 Buchanan St, Glasgow, UK'),
(28, '2024-09-05 14:20:00', 'processing', 199.98, 0.00, 12.00, 16.96, 'debit_card', '456 Sussex Dr, Ottawa, ON'),
(6, '2024-09-12 10:35:00', 'processing', 349.99, 15.00, 0.00, 26.79, 'paypal', '890 Rue de Rivoli, Paris, France'),
(29, '2024-09-19 16:50:00', 'pending', 129.99, 0.00, 10.00, 11.19, 'credit_card', '789 Rundle Mall, Adelaide, SA'),
(30, '2024-09-26 11:05:00', 'pending', 549.97, 25.00, 15.00, 46.25, 'debit_card', '234 Königstraße, Stuttgart, Germany'),
(31, '2024-10-01 13:20:00', 'pending', 79.99, 0.00, 10.00, 7.20, 'paypal', '567 Allées Jean Jaurès, Toulouse, France'),
(8, '2024-10-05 15:35:00', 'pending', 449.98, 20.00, 0.00, 34.39, 'credit_card', '678 Portland St, Manchester, UK'),
-- Additional orders to reach 100
(32, '2024-01-15 10:00:00', 'delivered', 124.98, 0.00, 10.00, 10.80, 'credit_card', '890 Broadway, San Diego, CA'),
(33, '2024-02-03 11:30:00', 'delivered', 199.99, 0.00, 12.00, 16.96, 'paypal', '123 Bold St, Liverpool, UK'),
(34, '2024-02-28 14:15:00', 'delivered', 349.99, 15.00, 0.00, 26.79, 'debit_card', '456 Jasper Ave, Edmonton, AB'),
(35, '2024-03-20 09:45:00', 'delivered', 89.99, 0.00, 10.00, 8.00, 'credit_card', '789 Constitution Ave, Canberra, ACT'),
(36, '2024-04-12 16:20:00', 'delivered', 259.97, 10.00, 12.00, 22.56, 'paypal', '234 Prager Str, Dresden, Germany'),
(37, '2024-05-08 12:35:00', 'delivered', 149.99, 0.00, 10.00, 12.80, 'debit_card', '567 Cours de l Intendance, Bordeaux, France'),
(38, '2024-06-02 10:50:00', 'delivered', 899.99, 50.00, 0.00, 67.99, 'credit_card', '890 Elm St, Dallas, TX'),
(39, '2024-06-25 15:10:00', 'delivered', 179.98, 0.00, 10.00, 15.20, 'paypal', '123 Park St, Bristol, UK'),
(40, '2024-07-15 13:25:00', 'delivered', 299.99, 15.00, 15.00, 26.25, 'debit_card', '456 Portage Ave, Winnipeg, MB'),
(41, '2024-08-05 11:40:00', 'shipped', 69.99, 0.00, 10.00, 6.40, 'credit_card', '789 Elizabeth St, Hobart, TAS'),
(42, '2024-08-28 14:55:00', 'shipped', 449.99, 20.00, 0.00, 34.39, 'paypal', '234 Hohe Straße, Cologne, Germany'),
(43, '2024-09-10 10:10:00', 'processing', 129.99, 0.00, 10.00, 11.19, 'debit_card', '567 Place Kléber, Strasbourg, France'),
(44, '2024-09-22 16:25:00', 'processing', 549.98, 25.00, 0.00, 42.00, 'credit_card', '890 Market St, San Jose, CA'),
(45, '2024-10-02 12:40:00', 'pending', 89.99, 0.00, 10.00, 8.00, 'paypal', '123 Division St, Sheffield, UK'),
(46, '2024-10-08 14:55:00', 'pending', 199.98, 0.00, 12.00, 16.96, 'debit_card', '456 Grande Allée, Quebec City, QC'),
(47, '2024-01-18 09:20:00', 'delivered', 349.99, 15.00, 0.00, 26.79, 'credit_card', '789 Mitchell St, Darwin, NT'),
(48, '2024-02-14 11:35:00', 'delivered', 79.99, 0.00, 10.00, 7.20, 'paypal', '234 Grimmaische Str, Leipzig, Germany'),
(49, '2024-03-10 13:50:00', 'delivered', 449.99, 20.00, 0.00, 34.39, 'debit_card', '567 Rue Crébillon, Nantes, France'),
(50, '2024-04-05 16:05:00', 'delivered', 129.99, 0.00, 10.00, 11.19, 'credit_card', '890 Congress Ave, Austin, TX'),
(10, '2024-05-01 10:20:00', 'delivered', 259.97, 10.00, 12.00, 22.56, 'paypal', '123 Collins St, Melbourne, VIC'),
(15, '2024-06-10 12:35:00', 'delivered', 149.99, 0.00, 10.00, 12.80, 'debit_card', '345 Broad St, Birmingham, UK'),
(20, '2024-07-08 14:50:00', 'delivered', 899.99, 50.00, 0.00, 67.99, 'credit_card', '789 Central Ave, Phoenix, AZ'),
(25, '2024-08-12 09:05:00', 'shipped', 179.98, 0.00, 10.00, 15.20, 'paypal', '567 Promenade des Anglais, Nice, France'),
(30, '2024-09-15 11:20:00', 'processing', 299.99, 15.00, 15.00, 26.25, 'debit_card', '234 Königstraße, Stuttgart, Germany'),
(35, '2024-10-01 13:35:00', 'pending', 69.99, 0.00, 10.00, 6.40, 'credit_card', '789 Constitution Ave, Canberra, ACT'),
(1, '2024-02-05 15:50:00', 'delivered', 399.99, 0.00, 0.00, 31.99, 'credit_card', '123 Main St, New York, NY'),
(2, '2024-03-12 10:05:00', 'delivered', 249.99, 10.00, 10.00, 21.00, 'paypal', '45 Oxford St, London, UK'),
(3, '2024-04-20 12:20:00', 'delivered', 499.99, 25.00, 15.00, 41.25, 'debit_card', '789 King St, Toronto, ON'),
(4, '2024-05-15 14:35:00', 'delivered', 89.99, 0.00, 10.00, 8.00, 'credit_card', '321 Beach Rd, Sydney, NSW'),
(5, '2024-06-18 16:50:00', 'delivered', 129.99, 0.00, 10.00, 11.19, 'paypal', '567 Unter den Linden, Berlin, Germany'),
(6, '2024-07-22 09:05:00', 'delivered', 549.97, 25.00, 0.00, 42.00, 'debit_card', '890 Rue de Rivoli, Paris, France'),
(7, '2024-08-18 11:20:00', 'shipped', 179.98, 0.00, 10.00, 15.20, 'credit_card', '234 Sunset Blvd, Los Angeles, CA'),
(8, '2024-09-08 13:35:00', 'processing', 299.99, 15.00, 15.00, 26.25, 'paypal', '678 Portland St, Manchester, UK'),
(9, '2024-10-05 15:50:00', 'pending', 69.99, 0.00, 10.00, 6.40, 'debit_card', '456 Granville St, Vancouver, BC'),
(11, '2024-01-22 10:10:00', 'delivered', 449.99, 20.00, 0.00, 34.39, 'credit_card', '789 Michigan Ave, Chicago, IL'),
(12, '2024-02-18 12:25:00', 'delivered', 129.99, 0.00, 10.00, 11.19, 'paypal', '234 Maximilianstr, Munich, Germany'),
(13, '2024-03-25 14:40:00', 'delivered', 259.97, 10.00, 12.00, 22.56, 'debit_card', '567 Rue de la République, Lyon, France'),
(14, '2024-04-28 16:55:00', 'delivered', 149.99, 0.00, 10.00, 12.80, 'credit_card', '890 Main St, Houston, TX'),
(16, '2024-05-20 09:10:00', 'delivered', 899.99, 50.00, 0.00, 67.99, 'paypal', '678 Saint Catherine St, Montreal, QC'),
(17, '2024-06-12 11:25:00', 'delivered', 179.98, 0.00, 10.00, 15.20, 'debit_card', '901 Queen St, Brisbane, QLD'),
(18, '2024-07-05 13:40:00', 'delivered', 299.99, 15.00, 15.00, 26.25, 'credit_card', '234 Reeperbahn, Hamburg, Germany'),
(19, '2024-08-02 15:55:00', 'shipped', 69.99, 0.00, 10.00, 6.40, 'paypal', '567 La Canebière, Marseille, France'),
(21, '2024-09-01 10:10:00', 'processing', 449.99, 20.00, 0.00, 34.39, 'debit_card', '345 The Headrow, Leeds, UK'),
(22, '2024-10-03 12:25:00', 'pending', 129.99, 0.00, 10.00, 11.19, 'credit_card', '678 17th Ave SW, Calgary, AB'),
(23, '2024-02-25 14:40:00', 'delivered', 549.98, 25.00, 0.00, 42.00, 'paypal', '901 Murray St, Perth, WA'),
(24, '2024-03-30 16:55:00', 'delivered', 89.99, 0.00, 10.00, 8.00, 'debit_card', '234 Kaiserstraße, Frankfurt, Germany'),
(26, '2024-04-22 09:10:00', 'delivered', 199.98, 0.00, 12.00, 16.96, 'credit_card', '890 Commerce St, San Antonio, TX'),
(27, '2024-05-28 11:25:00', 'delivered', 349.99, 15.00, 0.00, 26.79, 'paypal', '123 Buchanan St, Glasgow, UK'),
(28, '2024-06-20 13:40:00', 'delivered', 79.99, 0.00, 10.00, 7.20, 'debit_card', '456 Sussex Dr, Ottawa, ON'),
(29, '2024-07-12 15:55:00', 'delivered', 449.99, 20.00, 0.00, 34.39, 'credit_card', '789 Rundle Mall, Adelaide, SA'),
(31, '2024-08-08 10:10:00', 'shipped', 129.99, 0.00, 10.00, 11.19, 'paypal', '567 Allées Jean Jaurès, Toulouse, France'),
(32, '2024-09-02 12:25:00', 'processing', 259.97, 10.00, 12.00, 22.56, 'debit_card', '890 Broadway, San Diego, CA'),
(33, '2024-10-04 14:40:00', 'pending', 149.99, 0.00, 10.00, 12.80, 'credit_card', '123 Bold St, Liverpool, UK'),
(34, '2024-01-28 16:55:00', 'delivered', 899.99, 50.00, 0.00, 67.99, 'paypal', '456 Jasper Ave, Edmonton, AB'),
(36, '2024-02-22 09:10:00', 'delivered', 179.98, 0.00, 10.00, 15.20, 'debit_card', '234 Prager Str, Dresden, Germany'),
(37, '2024-03-18 11:25:00', 'delivered', 299.99, 15.00, 15.00, 26.25, 'credit_card', '567 Cours de l Intendance, Bordeaux, France'),
(38, '2024-04-15 13:40:00', 'delivered', 69.99, 0.00, 10.00, 6.40, 'paypal', '890 Elm St, Dallas, TX'),
(39, '2024-05-10 15:55:00', 'delivered', 449.99, 20.00, 0.00, 34.39, 'debit_card', '123 Park St, Bristol, UK'),
(40, '2024-06-05 10:10:00', 'delivered', 129.99, 0.00, 10.00, 11.19, 'credit_card', '456 Portage Ave, Winnipeg, MB'),
(41, '2024-07-01 12:25:00', 'delivered', 549.98, 25.00, 0.00, 42.00, 'paypal', '789 Elizabeth St, Hobart, TAS'),
(42, '2024-08-20 14:40:00', 'shipped', 89.99, 0.00, 10.00, 8.00, 'debit_card', '234 Hohe Straße, Cologne, Germany'),
(43, '2024-09-12 16:55:00', 'processing', 199.98, 0.00, 12.00, 16.96, 'credit_card', '567 Place Kléber, Strasbourg, France');

-- ============================================
-- Seed Order Items (200+ items across orders)
-- ============================================
-- Order 1: Customer 1
INSERT INTO order_items (order_id, product_id, quantity, unit_price, discount_amount, total_price) VALUES
(1, 1, 1, 1299.99, 50.00, 1249.99),
(1, 2, 1, 29.99, 0.00, 29.99),
(1, 3, 1, 49.99, 0.00, 49.99),
(1, 6, 1, 149.99, 0.00, 149.99);

-- Order 2: Customer 2
INSERT INTO order_items (order_id, product_id, quantity, unit_price, discount_amount, total_price) VALUES
(2, 9, 1, 89.99, 0.00, 89.99);

-- Order 3: Customer 3
INSERT INTO order_items (order_id, product_id, quantity, unit_price, discount_amount, total_price) VALUES
(3, 4, 1, 899.99, 0.00, 899.99),
(3, 6, 1, 149.99, 20.00, 129.99);

-- Order 4: Customer 1
INSERT INTO order_items (order_id, product_id, quantity, unit_price, discount_amount, total_price) VALUES
(4, 7, 2, 79.99, 0.00, 159.98),
(4, 2, 1, 29.99, 0.00, 29.99),
(4, 19, 1, 39.99, 0.00, 39.99);

-- Order 5: Customer 4
INSERT INTO order_items (order_id, product_id, quantity, unit_price, discount_amount, total_price) VALUES
(5, 4, 1, 899.99, 0.00, 899.99);

-- Continue with more order items for remaining orders
INSERT INTO order_items (order_id, product_id, quantity, unit_price, discount_amount, total_price) VALUES
(6, 8, 1, 399.99, 15.00, 384.99),
(6, 19, 1, 39.99, 0.00, 39.99),
(6, 20, 1, 34.99, 0.00, 34.99),
(7, 15, 2, 89.99, 0.00, 179.98),
(8, 5, 1, 499.99, 25.00, 474.99),
(8, 16, 1, 24.99, 0.00, 24.99),
(9, 6, 1, 149.99, 0.00, 149.99),
(9, 20, 1, 34.99, 0.00, 34.99),
(10, 1, 1, 1299.99, 100.00, 1199.99),
(11, 8, 1, 399.99, 10.00, 389.99),
(11, 2, 1, 29.99, 0.00, 29.99),
(11, 3, 1, 49.99, 0.00, 49.99),
(12, 18, 1, 249.99, 30.00, 219.99),
(12, 15, 2, 89.99, 0.00, 179.98),
(12, 19, 1, 39.99, 0.00, 39.99),
(13, 6, 1, 149.99, 0.00, 149.99),
(14, 9, 1, 89.99, 0.00, 89.99),
(15, 11, 1, 129.99, 0.00, 129.99),
(15, 12, 1, 79.99, 0.00, 79.99),
(16, 10, 1, 69.99, 0.00, 69.99),
(17, 29, 1, 349.99, 20.00, 329.99),
(17, 2, 1, 29.99, 0.00, 29.99),
(17, 3, 1, 49.99, 0.00, 49.99),
(18, 4, 1, 899.99, 50.00, 849.99),
(19, 8, 1, 399.99, 0.00, 399.99),
(20, 10, 1, 69.99, 0.00, 69.99),
(21, 15, 2, 89.99, 0.00, 179.98),
(22, 1, 1, 1299.99, 25.00, 1274.99),
(22, 2, 1, 29.99, 0.00, 29.99),
(23, 18, 1, 249.99, 0.00, 249.99),
(24, 19, 1, 39.99, 0.00, 39.99),
(25, 7, 2, 79.99, 0.00, 159.98),
(25, 19, 1, 39.99, 0.00, 39.99),
(26, 29, 1, 349.99, 15.00, 334.99),
(27, 9, 1, 89.99, 0.00, 89.99),
(28, 11, 1, 129.99, 0.00, 129.99),
(28, 12, 1, 79.99, 0.00, 79.99),
(29, 5, 1, 499.99, 20.00, 479.99),
(30, 7, 1, 79.99, 0.00, 79.99),
(31, 28, 1, 449.99, 0.00, 449.99),
(32, 6, 1, 149.99, 0.00, 149.99),
(32, 20, 1, 34.99, 0.00, 34.99),
(33, 27, 1, 299.99, 10.00, 289.99),
(34, 9, 1, 89.99, 0.00, 89.99),
(35, 15, 1, 89.99, 0.00, 89.99),
(35, 16, 2, 24.99, 0.00, 49.98),
(35, 17, 1, 59.99, 0.00, 59.99),
(36, 29, 1, 349.99, 15.00, 334.99),
(37, 11, 1, 129.99, 0.00, 129.99),
(37, 12, 1, 79.99, 0.00, 79.99),
(38, 6, 1, 149.99, 0.00, 149.99),
(39, 13, 1, 199.99, 0.00, 199.99),
(40, 11, 1, 129.99, 0.00, 129.99),
(40, 16, 2, 24.99, 0.00, 49.98),
(41, 4, 1, 899.99, 50.00, 849.99),
(42, 15, 2, 89.99, 0.00, 179.98),
(43, 8, 1, 399.99, 0.00, 399.99),
(44, 10, 1, 69.99, 0.00, 69.99),
(45, 28, 1, 449.99, 20.00, 429.99),
(46, 11, 1, 129.99, 0.00, 129.99),
(47, 18, 1, 249.99, 10.00, 239.99),
(47, 15, 1, 89.99, 0.00, 89.99),
(48, 9, 1, 89.99, 0.00, 89.99),
(49, 5, 1, 499.99, 25.00, 474.99),
(50, 13, 1, 199.99, 0.00, 199.99);

-- Add more order items for orders 51-100
INSERT INTO order_items (order_id, product_id, quantity, unit_price, discount_amount, total_price) VALUES
(51, 7, 1, 79.99, 0.00, 79.99),
(52, 29, 1, 349.99, 15.00, 334.99),
(53, 1, 1, 1299.99, 100.00, 1199.99),
(54, 6, 1, 149.99, 0.00, 149.99),
(55, 14, 1, 149.99, 0.00, 149.99),
(56, 17, 2, 59.99, 0.00, 119.98),
(56, 16, 1, 24.99, 0.00, 24.99),
(57, 27, 1, 299.99, 15.00, 284.99),
(58, 8, 1, 399.99, 0.00, 399.99),
(59, 4, 1, 899.99, 50.00, 849.99),
(60, 15, 2, 89.99, 0.00, 179.98),
(61, 11, 1, 129.99, 0.00, 129.99),
(62, 18, 1, 249.99, 10.00, 239.99),
(63, 5, 1, 499.99, 25.00, 474.99),
(64, 9, 1, 89.99, 0.00, 89.99),
(65, 11, 1, 129.99, 0.00, 129.99),
(66, 1, 1, 1299.99, 25.00, 1274.99),
(67, 28, 1, 449.99, 20.00, 429.99),
(68, 15, 2, 89.99, 0.00, 179.98),
(69, 10, 1, 69.99, 0.00, 69.99),
(70, 27, 1, 299.99, 15.00, 284.99),
(71, 11, 1, 129.99, 0.00, 129.99),
(72, 18, 1, 249.99, 10.00, 239.99),
(73, 6, 1, 149.99, 0.00, 149.99),
(74, 4, 1, 899.99, 50.00, 849.99),
(75, 15, 2, 89.99, 0.00, 179.98),
(76, 27, 1, 299.99, 15.00, 284.99),
(77, 10, 1, 69.99, 0.00, 69.99),
(78, 28, 1, 449.99, 20.00, 429.99),
(79, 11, 1, 129.99, 0.00, 129.99),
(80, 1, 1, 1299.99, 25.00, 1274.99),
(81, 9, 1, 89.99, 0.00, 89.99),
(82, 13, 1, 199.99, 0.00, 199.99),
(83, 29, 1, 349.99, 15.00, 334.99),
(84, 7, 1, 79.99, 0.00, 79.99),
(85, 5, 1, 499.99, 25.00, 474.99),
(86, 8, 1, 399.99, 0.00, 399.99),
(87, 15, 2, 89.99, 0.00, 179.98),
(88, 27, 1, 299.99, 15.00, 284.99),
(89, 10, 1, 69.99, 0.00, 69.99),
(90, 28, 1, 449.99, 20.00, 429.99),
(91, 11, 1, 129.99, 0.00, 129.99),
(92, 18, 1, 249.99, 10.00, 239.99),
(93, 6, 1, 149.99, 0.00, 149.99),
(94, 4, 1, 899.99, 50.00, 849.99),
(95, 9, 1, 89.99, 0.00, 89.99),
(96, 13, 1, 199.99, 0.00, 199.99),
(97, 29, 1, 349.99, 15.00, 334.99),
(98, 7, 1, 79.99, 0.00, 79.99),
(99, 28, 1, 449.99, 20.00, 429.99),
(100, 11, 1, 129.99, 0.00, 129.99);

-- ============================================
-- Summary Statistics
-- ============================================
-- Verify data load
DO $$
BEGIN
    RAISE NOTICE 'Data seeding completed:';
    RAISE NOTICE '- Customers: %', (SELECT COUNT(*) FROM customers);
    RAISE NOTICE '- Products: %', (SELECT COUNT(*) FROM products);
    RAISE NOTICE '- Orders: %', (SELECT COUNT(*) FROM orders);
    RAISE NOTICE '- Order Items: %', (SELECT COUNT(*) FROM order_items);
    RAISE NOTICE '- Total Revenue: $%', (SELECT ROUND(SUM(total_amount), 2) FROM orders);
END $$;
