-- ORDERS / CUSTOMER / PAYMENT (25–32)

-- (Assuming you’ll add dummy data later)

-- 25.Total orders per customer
-- Count total number of orders placed by each customer
SELECT 
    c.customer_name,
    COUNT(o.order_id) AS total_orders
FROM Orders o
JOIN Customer c 
    ON o.customer_id = c.customer_id
GROUP BY c.customer_name
ORDER BY total_orders DESC;


-- 26.Most Ordered Product
-- Find the most frequently ordered products
SELECT 
    p.product_name,
    COUNT(od.order_id) AS total_orders
FROM order_details od
JOIN Product p 
    ON od.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_orders DESC;

-- 27.Total Amount Spent per Customer
-- Calculate total spending of each customer
SELECT 
    c.customer_name,
    SUM(pmt.amount) AS total_spent
FROM Payment pmt
JOIN Orders o 
    ON pmt.order_id = o.order_id
JOIN Customer c 
    ON o.customer_id = c.customer_id
GROUP BY c.customer_name
ORDER BY total_spent DESC;


-- 28.Payment Mode Distribution
-- Show distribution of payments by payment mode
SELECT 
    payment_type,
    COUNT(payment_id) AS total_transactions,
    CONCAT(ROUND
    ((COUNT(payment_id) * 100.0 / (SELECT COUNT(*) FROM Payment)), 2), '%') 
    AS percentage_share
FROM Payment
GROUP BY payment_type
ORDER BY total_transactions DESC;

-- 29. Pending vs delivered orders
-- Compare total number of pending and delivered orders
SELECT 
    status,
    COUNT(order_id) AS total_orders
FROM delivery
GROUP BY status
ORDER BY total_orders DESC;

-- 30.Total revenue per day
-- Calculate total revenue generated each day
SELECT 
    o.order_date,
    SUM(p.amount) AS total_revenue
FROM Orders o
JOIN Payment p 
    ON o.order_id = p.order_id
GROUP BY o.order_date
ORDER BY o.order_date ASC;

-- 31. Average order value per customer
-- Calculate the average order value for each customer
SELECT 
    c.customer_name,
    ROUND(AVG(p.amount), 2) AS avg_order_value
FROM Orders o
JOIN Customer c 
    ON o.customer_id = c.customer_id
JOIN Payment p 
    ON o.order_id = p.order_id
GROUP BY c.customer_name
ORDER BY avg_order_value DESC;

-- 32.Total orders per product
-- Count total orders for each product
SELECT 
    p.product_name,
    COUNT(od.order_id) AS total_orders
FROM order_details od
JOIN Product p 
    ON od.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_orders DESC;
