-- 1️ Create database
CREATE DATABASE IF NOT EXISTS zepto;
USE zepto;

-- 2️ Create main tables

-- Category table
CREATE TABLE Category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) UNIQUE
);

-- Product table
CREATE TABLE Product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    category_id INT,
    product_name VARCHAR(200),
    mrp DECIMAL(10,2),
    discount_percent DECIMAL(5,2),
    discounted_price DECIMAL(10,2),
    weight_in_gms INT,
    FOREIGN KEY (category_id) REFERENCES Category(category_id)
);

-- Inventory table
CREATE TABLE Inventory (
    inventory_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    available_quantity INT,
    out_of_stock VARCHAR(10),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

-- 3️ Dummy tables (structure only, no data)

-- Customer
CREATE TABLE Customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20)
);

-- Orders
CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

-- Order_Details
CREATE TABLE Order_Details (
    order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

-- Payment
CREATE TABLE Payment (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    payment_type VARCHAR(50),
    amount DECIMAL(10,2),
    payment_date DATE,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- Delivery
CREATE TABLE Delivery (
    delivery_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    delivery_date DATE,
    status VARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- 4️ Create temp table for CSV import
CREATE TABLE temp_zepto_raw (
    Category VARCHAR(100),
    name VARCHAR(200),
    mrp DECIMAL(10,2),
    discountPercent DECIMAL(5,2),
    availableQuantity INT,
    discountedSellingPrice DECIMAL(10,2),
    weightInGms INT,
    outOfStock VARCHAR(20),
    quantity INT
);


-- 5️ After importing CSV into temp_zepto_raw, fill main tables

-- Insert clean categories

insert into Category (category_name) select distinct upper(trim(category)) from temp_zepto_raw;
select count(*) from category;
select * from category;

-- Insert products linked to category

INSERT INTO Product (category_id, product_name, mrp, discount_percent, discounted_price, weight_in_gms)
SELECT 
    c.category_id,
    t.name,
    t.mrp,
    t.discountPercent,
    t.discountedSellingPrice,
    t.weightInGms
FROM (SELECT DISTINCT Category, name, mrp, discountPercent, discountedSellingPrice, weightInGms
    FROM temp_zepto_raw)t
JOIN Category c ON UPPER(TRIM(t.Category)) = c.category_name;
select count(*) from product;
select * from product;

-- Insert inventory linked to product

INSERT INTO Inventory (product_id, available_quantity, out_of_stock)
SELECT 
    p.product_id,
    SUM(t.availableQuantity) AS total_quantity,
    MAX(t.outOfStock) AS out_of_stock
FROM temp_zepto_raw t
JOIN Product p ON upper(trim(t.name)) = upper(trim(p.product_name))
GROUP BY p.product_id;

--  Insert sample customers
INSERT INTO Customer (customer_name, email, phone) VALUES
('Ravi Kumar', 'ravi@example.com', '9876543210'),
('Sneha Patel', 'sneha@example.com', '9123456789'),
('Amit Sharma', 'amit@example.com', '9988776655'),
('Priya Singh', 'priya@example.com', '9876123456'),
('Vikram Joshi', 'vikram@example.com', '9822334455'),
('Ananya Rao', 'ananya@example.com', '9811122233'),
('Rahul Nair', 'rahul@example.com', '9788996677'),
('Divya Gupta', 'divya@example.com', '9766554433'),
('Karan Mehta', 'karan@example.com', '9744556677'),
('Neha Verma', 'neha@example.com', '9722334455');

--  Insert sample orders
INSERT INTO Orders (customer_id, order_date) VALUES
(1, '2025-10-10'),
(2, '2025-10-11'),
(3, '2025-10-12'),
(4, '2025-10-12'),
(5, '2025-10-13'),
(6, '2025-10-13'),
(7, '2025-10-14'),
(8, '2025-10-14'),
(9, '2025-10-15'),
(10, '2025-10-15');

--  Insert order details (connects orders to products)
-- (Just using first 10 product IDs for demo)
INSERT INTO Order_Details (order_id, product_id, quantity) VALUES
(1, 1, 2),
(2, 2, 1),
(3, 3, 4),
(4, 4, 1),
(5, 5, 2),
(6, 6, 3),
(7, 7, 2),
(8, 8, 1),
(9, 9, 5),
(10, 10, 2);

--  Insert payments for those orders
INSERT INTO Payment (order_id, payment_type, amount, payment_date) VALUES
(1, 'UPI', 250.50, '2025-10-10'),
(2, 'Credit Card', 499.00, '2025-10-11'),
(3, 'Cash', 1299.00, '2025-10-12'),
(4, 'Debit Card', 199.00, '2025-10-12'),
(5, 'UPI', 999.00, '2025-10-13'),
(6, 'Credit Card', 750.00, '2025-10-13'),
(7, 'Cash', 499.00, '2025-10-14'),
(8, 'UPI', 849.00, '2025-10-14'),
(9, 'Debit Card', 1399.00, '2025-10-15'),
(10, 'UPI', 699.00, '2025-10-15');

--  Insert delivery status for each order
INSERT INTO Delivery (order_id, delivery_date, status) VALUES
(1, '2025-10-11', 'Delivered'),
(2, '2025-10-12', 'Delivered'),
(3, '2025-10-13', 'Pending'),
(4, '2025-10-14', 'Delivered'),
(5, '2025-10-14', 'Delivered'),
(6, '2025-10-15', 'In Transit'),
(7, '2025-10-15', 'Delivered'),
(8, '2025-10-16', 'Pending'),
(9, '2025-10-16', 'Delivered'),
(10, '2025-10-17', 'Delivered');


