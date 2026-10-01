-- Olist E-Commerce Sales Intelligence
-- Customer & RFM Analysis


-- 1. Customer frequency
SELECT
    customer_unique_id,
    frequency
FROM customer_rfm
ORDER BY frequency DESC;


-- 2. Top 10 customers by monetary value
SELECT
    customer_unique_id,
    monetary,
    frequency,
    recency,
    customer_segment
FROM (
    SELECT
        customer_unique_id,
        monetary,
        frequency,
        recency,
        customer_segment
    FROM customer_rfm
    ORDER BY monetary DESC
)
WHERE ROWNUM <= 10;


-- 3. Customer segment distribution
SELECT
    customer_segment,
    COUNT(*) AS customer_count
FROM customer_rfm
GROUP BY customer_segment
ORDER BY customer_count DESC;


-- 4. Revenue by customer segment
SELECT
    customer_segment,
    SUM(monetary) AS total_revenue
FROM customer_rfm
GROUP BY customer_segment
ORDER BY total_revenue DESC;


-- 5. Average customer value by segment
SELECT
    customer_segment,
    AVG(monetary) AS average_customer_value
FROM customer_rfm
GROUP BY customer_segment
ORDER BY average_customer_value DESC;


-- 6. Average recency by segment
SELECT
    customer_segment,
    AVG(recency) AS average_recency
FROM customer_rfm
GROUP BY customer_segment
ORDER BY average_recency;


-- 7. Customers with high frequency
SELECT
    customer_unique_id,
    frequency,
    monetary,
    customer_segment
FROM (
    SELECT
        customer_unique_id,
        frequency,
        monetary,
        customer_segment
    FROM customer_rfm
    ORDER BY frequency DESC
)
WHERE ROWNUM <= 10;


-- 8. Champions
SELECT
    COUNT(*) AS champions_customers
FROM customer_rfm
WHERE customer_segment = 'Champions';


-- 9. At Risk customers
SELECT
    COUNT(*) AS at_risk_customers
FROM customer_rfm
WHERE customer_segment = 'At Risk';


-- 10. Lost customers
SELECT
    COUNT(*) AS lost_customers
FROM customer_rfm
WHERE customer_segment = 'Lost Customers';