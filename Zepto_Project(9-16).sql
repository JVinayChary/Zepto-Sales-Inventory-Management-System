-- PRODUCT-LEVEL QUERIES (Intermediate: 9–18)

-- 9. Find the cheapest product in each category
SELECT 
    c.category_name,
    p.product_name,
    p.discounted_price AS cheapest_price
FROM Product p
JOIN Category c ON p.category_id = c.category_id
WHERE p.discounted_price = (
    SELECT MIN(p2.discounted_price)
    FROM Product p2
    WHERE p2.category_id = p.category_id 
);

-- 10.Most expensive product per category
SELECT 
    c.category_name,
    p.product_name,
    p.discounted_price AS highest_price
FROM Product p
JOIN Category c 
    ON p.category_id = c.category_id
WHERE p.discounted_price = (
    SELECT MAX(p2.discounted_price)
    FROM Product p2
    WHERE p2.category_id = p.category_id
)
ORDER BY c.category_name;

-- 11.Product with maximum discount
SELECT 
    c.category_name,
    p.product_name,
    p.discount_percent AS max_discount
FROM Product p
JOIN Category c ON p.category_id = c.category_id
WHERE p.discount_percent = (
    SELECT MAX(p2.discount_percent)
    FROM Product p2
    WHERE p2.category_id = p.category_id
);

-- 12.Product with minimum discount
SELECT 
    c.category_name,
    p.product_name,
    p.discount_percent AS min_discount
FROM Product p
JOIN Category c ON p.category_id = c.category_id
WHERE p.discount_percent = (
    SELECT MIN(p2.discount_percent)
    FROM Product p2
    WHERE p2.category_id = p.category_id
);

-- 13. Find average discount percent of all products.

SELECT
ROUND(AVG(discount_percent),2) 
AS avg_discount FROM Product;

-- 14.Show products that weigh more than a given weight (e.g., 1000 grams)
SELECT 
    c.category_name,
    p.product_name,
    p.weight_in_gms
FROM Product p
JOIN Category c 
    ON p.category_id = c.category_id
WHERE p.weight_in_gms > 2000
ORDER BY p.weight_in_gms DESC limit 10;

-- 15.Show products that weigh less than a given weight (e.g., 500 grams)
SELECT 
    c.category_name,
    p.product_name,
    p.weight_in_gms
FROM Product p
JOIN Category c 
    ON p.category_id = c.category_id
WHERE p.weight_in_gms < 1000
ORDER BY p.weight_in_gms ASC limit 10;

-- 16 Show all products that are currently out of stock
SELECT 
    c.category_name,
    p.product_name,
    i.available_quantity,
    i.out_of_stock
FROM Inventory i
JOIN Product p ON i.product_id = p.product_id
JOIN Category c ON p.category_id = c.category_id
WHERE i.out_of_stock = 'TRUE'
ORDER BY c.category_name
LIMIT 20;