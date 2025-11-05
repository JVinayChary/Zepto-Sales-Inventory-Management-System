-- INVENTORY-LEVEL QUERIES (17–27)

-- 17. Find total available stock value per category.

SELECT c.category_name,
SUM(p.discounted_price * i.available_quantity)
AS total_value
FROM Inventory i
JOIN Product p ON i.product_id = p.product_id
JOIN Category c ON p.category_id = c.category_id
GROUP BY c.category_name;

-- 18.Total stock value per product (MRP × quantity)
-- Calculate total stock value for each product based on MRP × available quantity
SELECT 
    c.category_name,
    p.product_name,
    p.mrp,
    i.available_quantity,
    (p.mrp * i.available_quantity) AS total_stock_value
FROM Product p
JOIN Inventory i 
    ON p.product_id = i.product_id
JOIN Category c 
    ON p.category_id = c.category_id
ORDER BY total_stock_value DESC
LIMIT 10;


-- 19.Low-stock products (quantity < 10)
-- Show all products with available quantity less than 10
SELECT 
    c.category_name,
    p.product_name,
    i.available_quantity
FROM Inventory i
JOIN Product p 
    ON i.product_id = p.product_id
JOIN Category c 
    ON p.category_id = c.category_id
WHERE i.available_quantity < 10
ORDER BY i.available_quantity DESC
LIMIT 10;

-- 20. Total stock per category
-- Calculate total available stock (quantity) for each category
SELECT 
    c.category_name,
    SUM(i.available_quantity) AS total_stock
FROM Inventory i
JOIN Product p 
    ON i.product_id = p.product_id
JOIN Category c 
    ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY total_stock DESC;

-- 21. Stock value per category
-- Calculate total stock value (MRP × quantity) for each category
SELECT 
    c.category_name,
    SUM(p.mrp * i.available_quantity) AS total_stock_value
FROM Inventory i
JOIN Product p 
    ON i.product_id = p.product_id
JOIN Category c 
    ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY total_stock_value DESC;

-- 22.Highest stock quantity
-- Find products with the highest available stock
SELECT 
    c.category_name,
    p.product_name,
    i.available_quantity
FROM Inventory i
JOIN Product p 
    ON i.product_id = p.product_id
JOIN Category c 
    ON p.category_id = c.category_id
ORDER BY i.available_quantity DESC
LIMIT 10;

-- 23.Lowest stock quantity
-- Find products with the lowest available stock
SELECT 
    c.category_name,
    p.product_name,
    i.available_quantity
FROM Inventory i
JOIN Product p 
    ON i.product_id = p.product_id
JOIN Category c 
    ON p.category_id = c.category_id
WHERE i.available_quantity > 0
ORDER BY i.available_quantity ASC
LIMIT 10;

-- 24.Average stock per product
-- Calculate average available stock per product across all categories
SELECT 
    c.category_name,
    ROUND(AVG(i.available_quantity), 2) AS avg_stock_per_product
FROM Inventory i
JOIN Product p 
    ON i.product_id = p.product_id
JOIN Category c 
    ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY avg_stock_per_product DESC;



