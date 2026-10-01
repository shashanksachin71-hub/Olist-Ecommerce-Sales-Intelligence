-- Olist E-Commerce Sales Intelligence
-- Basic SQL Analysis


-- 1. View sample orders
SELECT *
FROM orders
WHERE ROWNUM <= 10;


-- 2. Count total orders
SELECT COUNT(*) AS total_orders
FROM orders;


-- 3. Count orders by status
SELECT
    order_status,
    COUNT(*) AS order_count
FROM orders
GROUP BY order_status
ORDER BY order_count DESC;


-- 4. Total revenue
SELECT
    SUM(total_item_value) AS total_revenue
FROM order_items;


-- 5. Average order item value
SELECT
    AVG(total_item_value) AS average_item_value
FROM order_items;


-- 6. Minimum and maximum item value
SELECT
    MIN(total_item_value) AS minimum_value,
    MAX(total_item_value) AS maximum_value
FROM order_items;


-- 7. Revenue by payment type
SELECT
    payment_type,
    SUM(payment_value) AS total_payment_value
FROM payments
GROUP BY payment_type
ORDER BY total_payment_value DESC;


-- 8. Review score distribution
SELECT
    review_score,
    COUNT(*) AS review_count
FROM reviews
GROUP BY review_score
ORDER BY review_score;


-- 9. Number of sellers by state
SELECT
    seller_state,
    COUNT(*) AS seller_count
FROM sellers
GROUP BY seller_state
ORDER BY seller_count DESC;


-- 10. Number of customers by state
SELECT
    customer_state,
    COUNT(*) AS customer_count
FROM customers
GROUP BY customer_state
ORDER BY customer_count DESC;