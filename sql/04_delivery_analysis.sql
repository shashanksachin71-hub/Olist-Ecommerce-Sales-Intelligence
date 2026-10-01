-- Olist E-Commerce Sales Intelligence
-- Delivery & Operations Analysis


-- 1. Average delivery time
SELECT
    AVG(delivery_days) AS average_delivery_days
FROM orders
WHERE delivery_days IS NOT NULL;


-- 2. Minimum and maximum delivery time
SELECT
    MIN(delivery_days) AS minimum_delivery_days,
    MAX(delivery_days) AS maximum_delivery_days
FROM orders
WHERE delivery_days IS NOT NULL;


-- 3. Delivery status distribution
SELECT
    delivery_status,
    COUNT(*) AS order_count
FROM orders
GROUP BY delivery_status
ORDER BY order_count DESC;


-- 4. Late delivery percentage
SELECT
    ROUND(
        100 * SUM(
            CASE
                WHEN delivery_status = 'Late' THEN 1
                ELSE 0
            END
        ) /
        SUM(
            CASE
                WHEN delivery_status <> 'Not Delivered' THEN 1
                ELSE 0
            END
        ),
        2
    ) AS late_delivery_percentage
FROM orders;


-- 5. Average delivery days by customer state
SELECT
    c.customer_state,
    ROUND(AVG(o.delivery_days), 2) AS average_delivery_days
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
WHERE o.delivery_days IS NOT NULL
GROUP BY c.customer_state
ORDER BY average_delivery_days DESC;


-- 6. Late deliveries by customer state
SELECT
    c.customer_state,
    COUNT(*) AS late_orders
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
WHERE o.delivery_status = 'Late'
GROUP BY c.customer_state
ORDER BY late_orders DESC;


-- 7. Order status distribution
SELECT
    order_status,
    COUNT(*) AS order_count
FROM orders
GROUP BY order_status
ORDER BY order_count DESC;


-- 8. Delivered orders
SELECT
    COUNT(*) AS delivered_orders
FROM orders
WHERE order_status = 'delivered';


-- 9. Not delivered orders
SELECT
    COUNT(*) AS not_delivered_orders
FROM orders
WHERE delivery_status = 'Not Delivered';


-- 10. Orders delivered within 7 days
SELECT
    COUNT(*) AS orders_within_7_days
FROM orders
WHERE delivery_days <= 7;