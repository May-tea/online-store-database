-- =========================================
-- Conditional Queries (CASE & COALESCE)
-- File: sql/06_conditional_queries.sql
-- =========================================

-- -----------------------------------------
-- 1) CASE Expression: product price tiers
--    Categorize products by price range
-- -----------------------------------------

SELECT
    name,
    price,
    CASE
        WHEN price >= 300 THEN 'Premium'
        WHEN price >= 100 THEN 'Mid-Range'
        ELSE 'Budget'
    END AS price_tier
FROM products
ORDER BY price DESC;

-- -----------------------------------------
-- 2) CASE Expression: stock status labels
--    Show human-readable stock status for each product
-- -----------------------------------------

SELECT
    name,
    stock,
    CASE
        WHEN stock = 0 THEN 'Out of Stock'
        WHEN stock < 15 THEN 'Low Stock'
        ELSE 'In Stock'
    END AS stock_status
FROM products
ORDER BY stock ASC;

-- -----------------------------------------
-- 3) COALESCE: fallback for NULL values
--    Display fallback text for pending payment dates
-- -----------------------------------------

SELECT
    payment_id,
    amount,
    status,
    COALESCE(paid_at, 'Pending') AS payment_date
FROM payments
ORDER BY payment_id ASC;

-- -----------------------------------------
-- 4) LEFT JOIN with COALESCE: product review summary
--    Show average rating for all products, defaulting to 0 if no reviews exist
-- -----------------------------------------

SELECT p.product_id, p.name AS product_name, COALESCE(AVG(r.rating), 0) AS avg_rating
FROM products p
    LEFT JOIN reviews r ON p.product_id = r.product_id
GROUP BY
    p.product_id,
    p.name
ORDER BY avg_rating DESC;