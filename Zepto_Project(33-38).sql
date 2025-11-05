-- ANALYTICAL / MIXED QUERIES (33–38)

-- 33.Category with maximum revenue
-- Calculate total revenue per category and find the category with maximum revenue
SELECT 
    c.category_name,
    SUM(od.quantity * p.discounted_price) AS total_revenue
FROM order_details od
JOIN Product p 
    ON od.product_id = p.product_id
JOIN Category c 
    ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY total_revenue;

-- 34.Average discount per category
-- Calculate average discount for products in each category
SELECT 
    c.category_name,
    ROUND(AVG(p.discount_percent), 2) AS avg_discount
FROM Product p
JOIN Category c 
    ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY avg_discount DESC;

-- 35.Customer with maximum orders
-- Find the customer who placed the maximum number of orders
SELECT 
    c.customer_name,
    COUNT(o.order_id) AS total_orders
FROM Orders o
JOIN Customer c 
    ON o.customer_id = c.customer_id
GROUP BY c.customer_name
ORDER BY total_orders DESC
LIMIT 1;

-- 36.Product with lowest sales
-- Find the product with the lowest total quantity sold
SELECT 
    p.product_name,
    SUM(od.quantity) AS total_sold
FROM order_details od
JOIN Product p 
    ON od.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sold ASC
LIMIT 1;

-- 37.Total revenue in a month
-- Find the product with the lowest total quantity sold
SELECT 
    p.product_name,
    SUM(od.quantity) AS total_sold
FROM order_details od
JOIN Product p 
    ON od.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sold ASC
LIMIT 1;

-- 38.Delivery performance summary
-- Summarize delivery performance: delivered vs pending orders
SELECT 
    CASE 
        WHEN status = 'Delivered' THEN 'Delivered'
        ELSE 'Pending'
    END AS delivery_status,
    COUNT(order_id) AS total_orders,
    ROUND((COUNT(order_id) * 100.0 / (SELECT COUNT(*) FROM Orders)), 2) AS percentage
FROM delivery
GROUP BY status;
