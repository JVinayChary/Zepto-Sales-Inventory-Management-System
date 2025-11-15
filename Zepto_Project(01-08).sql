-- CATEGORY-LEVEL QUERIES (Basic: 1–8)

-- 1. Count how many categories are there.

SELECT COUNT(*) AS total_categories
FROM Category;


-- 2. Display Count products per category

SELECT c.category_name, COUNT(p.product_id)
AS total_products
FROM Product p
JOIN Category c ON p.category_id = c.category_id
GROUP BY c.category_name;


-- 3. Find which category has the most products.

SELECT c.category_name, COUNT(p.product_id)
AS total_products
FROM Product p
JOIN Category c ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY total_products DESC
LIMIT 1;


-- 4.Category with least products

SELECT c.category_name, COUNT(p.product_id)
AS total_products
FROM Product p
JOIN Category c ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY total_products ASC
LIMIT 1;


-- 5.Total stock per category

SELECT 
    c.category_name,
    SUM(i.available_quantity) AS total_stock
FROM 
    Inventory i
JOIN 
    Product p ON i.product_id = p.product_id
JOIN 
    Category c ON p.category_id = c.category_id
GROUP BY 
    c.category_name
ORDER BY 
    total_stock DESC;
    
    
-- 6. Average discount per category

SELECT 
    c.category_name, 
    ROUND(AVG(p.discount_percent), 2)
AS average_discount
FROM Product p
JOIN Category c ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY average_discount DESC;


-- 7.Highest priced product per category
SELECT 
    c.category_name, 
    p.product_name, 
    p.mrp AS highest_price
FROM Product p
JOIN Category c ON p.category_id = c.category_id
WHERE p.mrp = (
    SELECT MAX(p2.mrp)
    FROM Product p2
    WHERE p2.category_id = p.category_id
)
ORDER BY c.category_name;


-- 8.Lowest priced product per category
SELECT 
    c.category_name, 
    p.product_name, 
    p.mrp AS lowest_price
FROM Product p
JOIN Category c ON p.category_id = c.category_id
WHERE p.mrp = (
    SELECT MIN(p2.mrp)
    FROM Product p2
    WHERE p2.category_id = p.category_id
)
ORDER BY c.category_name;