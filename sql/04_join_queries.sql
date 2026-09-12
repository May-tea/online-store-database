-- =========================================
-- JOIN Queries
-- File: sql/04_join_queries.sql
-- =========================================

-- -----------------------------------------
-- 1) INNER JOIN: products + categories
-- -----------------------------------------

SELECT
    c.name AS category_name,
    p.name AS product_name,
    p.price
FROM products p
    INNER JOIN categories c ON p.category_id = c.category_id
ORDER BY c.name ASC;

-- -----------------------------------------
-- 2) INNER JOIN + WHERE: reviews + products
-- -----------------------------------------

SELECT r.customer_id, p.name AS product_name, r.rating, r.comment
FROM reviews r
    INNER JOIN products p ON r.product_id = p.product_id
WHERE
    r.rating >= 4
ORDER BY r.rating DESC;

-- -----------------------------------------
-- 3) 3-Table JOIN: customers + reviews + products
-- -----------------------------------------

SELECT c.email, p.name AS product_name, r.rating, r.comment
FROM
    reviews r
    INNER JOIN customers c ON c.customer_id = r.customer_id
    INNER JOIN products p ON r.product_id = p.product_id
ORDER BY r.rating DESC;

-- -----------------------------------------
-- 4) LEFT JOIN: customers + orders
-- -----------------------------------------

SELECT c.email, o.order_id, o.status
FROM customers c
    LEFT JOIN orders o ON o.customer_id = c.customer_id
ORDER BY o.order_id ASC;

-- -----------------------------------------
-- 5) LEFT JOIN + IS NULL: customers without orders
--    Find customers who have never placed an order
-- -----------------------------------------

SELECT c.email, o.order_id
FROM customers c
    LEFT JOIN orders o ON o.customer_id = c.customer_id
WHERE
    o.order_id IS NULL;

-- -----------------------------------------
-- 6) LEFT JOIN + GROUP BY: order count per customer
--    Count orders for each customer (including zero)
-- -----------------------------------------

SELECT c.email, COUNT(o.order_id) AS order_count
FROM customers c
    LEFT JOIN orders o ON o.customer_id = c.customer_id
GROUP BY
    c.email
ORDER BY order_count DESC;

-- -----------------------------------------
-- 7) INNER JOIN + GROUP BY + HAVING: frequently ordered products
--    Find products that have been ordered more than once
-- -----------------------------------------

SELECT p.name AS product_name, COUNT(*) AS times_ordered
FROM products p
    INNER JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY
    p.name
HAVING
    COUNT(*) > 1
ORDER BY times_ordered DESC;