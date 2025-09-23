-- PostgreSQL Interview Questions and Sample Queries
-- Use these as reference or starting points for interview questions

-- BASIC LEVEL QUERIES

-- 1. Find all customers from New York
SELECT * FROM customers WHERE state = 'NY';

-- 2. List products with stock less than 50
SELECT product_name, stock_quantity, price 
FROM products 
WHERE stock_quantity < 50;

-- 3. Show all orders with customer names
SELECT o.order_id, c.first_name || ' ' || c.last_name as customer_name, 
       o.order_date, o.total_amount, o.status
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id;

-- INTERMEDIATE LEVEL QUERIES

-- 4. Calculate total revenue by category
SELECT cat.category_name, SUM(oi.quantity * oi.unit_price) as total_revenue
FROM categories cat
JOIN products p ON cat.category_id = p.category_id
JOIN order_items oi ON p.product_id = oi.product_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.status = 'completed'
GROUP BY cat.category_name
ORDER BY total_revenue DESC;

-- 5. Find customers who have never placed an order
SELECT c.customer_id, c.first_name, c.last_name, c.email
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.customer_id IS NULL;

-- 6. Show top 5 best-selling products by quantity
SELECT p.product_name, SUM(oi.quantity) as total_sold
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_sold DESC
LIMIT 5;

-- ADVANCED LEVEL QUERIES

-- 7. Calculate running total of orders by date
SELECT order_date::date, 
       COUNT(*) as daily_orders,
       SUM(COUNT(*)) OVER (ORDER BY order_date::date) as running_total
FROM orders
GROUP BY order_date::date
ORDER BY order_date::date;

-- 8. Find customers with above-average order values
WITH avg_order AS (
    SELECT AVG(total_amount) as avg_amount FROM orders
)
SELECT c.first_name || ' ' || c.last_name as customer_name,
       AVG(o.total_amount) as avg_order_value,
       ao.avg_amount as overall_average
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
CROSS JOIN avg_order ao
GROUP BY c.customer_id, c.first_name, c.last_name, ao.avg_amount
HAVING AVG(o.total_amount) > ao.avg_amount;

-- 9. Monthly sales trend (requires more data for meaningful results)
SELECT DATE_TRUNC('month', order_date) as month,
       COUNT(*) as total_orders,
       SUM(total_amount) as total_revenue,
       AVG(total_amount) as avg_order_value
FROM orders
WHERE status IN ('completed', 'shipped')
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY month;

-- 10. Product performance analysis
SELECT p.product_name,
       p.price,
       p.stock_quantity,
       COALESCE(SUM(oi.quantity), 0) as total_sold,
       COALESCE(SUM(oi.quantity * oi.unit_price), 0) as total_revenue,
       CASE 
           WHEN SUM(oi.quantity) IS NULL THEN 'No Sales'
           WHEN SUM(oi.quantity) < 5 THEN 'Low Sales'
           WHEN SUM(oi.quantity) < 20 THEN 'Medium Sales'
           ELSE 'High Sales'
       END as sales_category
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
LEFT JOIN orders o ON oi.order_id = o.order_id AND o.status IN ('completed', 'shipped')
GROUP BY p.product_id, p.product_name, p.price, p.stock_quantity
ORDER BY total_revenue DESC;

-- DATABASE DESIGN QUESTIONS TO DISCUSS:

-- 1. Why is there a separate order_items table instead of storing items directly in orders?
-- 2. What indexes would you add to improve query performance?
-- 3. How would you handle product variants (size, color, etc.)?
-- 4. What's missing from this schema for a real e-commerce system?
-- 5. How would you implement inventory tracking with this schema?
-- 6. What constraints should be added to ensure data integrity?