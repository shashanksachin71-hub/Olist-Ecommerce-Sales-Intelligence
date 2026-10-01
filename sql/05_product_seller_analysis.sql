-- Olist E-Commerce Sales Intelligence
-- Product & Seller Analysis


-- 1. Total number of products
SELECT
    COUNT(*) AS total_products
FROM products;


-- 2. Total number of sellers
SELECT
    COUNT(*) AS total_sellers
FROM sellers;


-- 3. Revenue by product category
SELECT
    p.product_category_name_english AS category,
    SUM(oi.total_item_value) AS revenue
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY p.product_category_name_english
ORDER BY revenue DESC;


-- 4. Top 10 sellers by revenue
SELECT
    seller_id,
    revenue
FROM (
    SELECT
        seller_id,
        SUM(total_item_value) AS revenue
    FROM order_items
    GROUP BY seller_id
    ORDER BY revenue DESC
)
WHERE ROWNUM <= 10;


-- 5. Average item value by product category
SELECT
    p.product_category_name_english AS category,
    AVG(oi.total_item_value) AS average_item_value
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY p.product_category_name_english
ORDER BY average_item_value DESC;


-- 6. Revenue by seller state
SELECT
    s.seller_state,
    SUM(oi.total_item_value) AS revenue
FROM sellers s
JOIN order_items oi
    ON s.seller_id = oi.seller_id
GROUP BY s.seller_state
ORDER BY revenue DESC;


-- 7. Product price statistics
SELECT
    AVG(price) AS average_price,
    MIN(price) AS minimum_price,
    MAX(price) AS maximum_price
FROM order_items;


-- 8. Freight value statistics
SELECT
    AVG(freight_value) AS average_freight,
    MIN(freight_value) AS minimum_freight,
    MAX(freight_value) AS maximum_freight
FROM order_items;


-- 9. Number of items per order
SELECT
    order_id,
    COUNT(*) AS item_count
FROM order_items
GROUP BY order_id
ORDER BY item_count DESC;


-- 10. Revenue contribution by category
SELECT
    p.product_category_name_english AS category,
    SUM(oi.total_item_value) AS revenue,
    ROUND(
        100 * SUM(oi.total_item_value) /
        (SELECT SUM(total_item_value) FROM order_items),
        2
    ) AS revenue_percentage
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY p.product_category_name_english
ORDER BY revenue DESC;
