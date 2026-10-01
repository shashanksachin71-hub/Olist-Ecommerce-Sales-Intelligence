-- Olist E-Commerce Sales Intelligence
-- Sales Analysis


-- 1. Total revenue
SELECT
    SUM(total_item_value) AS total_revenue
FROM order_items;


-- 2. Revenue by month
SELECT
    TO_CHAR(o.order_purchase_timestamp, 'YYYY-MM') AS sales_month,
    SUM(oi.total_item_value) AS monthly_revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY TO_CHAR(o.order_purchase_timestamp, 'YYYY-MM')
ORDER BY sales_month;


-- 3. Revenue by product category
SELECT
    p.product_category_name_english AS category,
    SUM(oi.total_item_value) AS revenue
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY p.product_category_name_english
ORDER BY revenue DESC;


-- 4. Revenue by customer state
SELECT
    c.customer_state,
    SUM(oi.total_item_value) AS revenue
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY c.customer_state
ORDER BY revenue DESC;


-- 5. Average Order Value
SELECT
    SUM(total_item_value) /
    COUNT(DISTINCT order_id) AS average_order_value
FROM order_items;


-- 6. Monthly order count
SELECT
    TO_CHAR(o.order_purchase_timestamp, 'YYYY-MM') AS sales_month,
    COUNT(DISTINCT o.order_id) AS order_count
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY TO_CHAR(o.order_purchase_timestamp, 'YYYY-MM')
ORDER BY sales_month;


-- 7. Top 10 customers by revenue
SELECT
    c.customer_unique_id,
    SUM(oi.total_item_value) AS revenue
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY c.customer_unique_id
ORDER BY revenue DESC
FETCH FIRST 10 ROWS ONLY;