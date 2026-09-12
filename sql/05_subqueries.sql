-- =========================================
-- Subqueries
-- File: sql/05_subqueries.sql
-- =========================================

-- -----------------------------------------
-- 1) Subquery in WHERE: above-average priced products
--    Find products whose price is higher than the overall average
-- -----------------------------------------

SELECT p.name, p.price
FROM products p
WHERE
    p.price > (
        SELECT AVG(pr.price)
        FROM products pr
    )
ORDER BY p.price DESC;

-- -----------------------------------------
-- 2) Subquery with IN: products that have been ordered
--    Find products that appear in at least one order
-- -----------------------------------------

SELECT p.name, p.price
FROM products p
WHERE
    p.product_id IN (
        SELECT oi.product_id
        FROM order_items oi
    )
ORDER BY p.name ASC;

-- -----------------------------------------
-- 3) Subquery with NOT IN: products never ordered
--     Find products that have never been included in any order
-- -----------------------------------------

SELECT p.product_id, p.name, p.price
FROM products p
WHERE
    p.product_id NOT IN(
        SELECT oi.product_id
        FROM order_items oi
    )
ORDER BY p.price DESC;

-- -----------------------------------------
-- 4) Scalar subquery: most expensive products
--     Find product(s) with the highest price
-- -----------------------------------------

SELECT p.product_id, p.name, p.price
FROM products p
WHERE
    p.price = (
        SELECT MAX(pr.price)
        FROM products pr
    )
ORDER BY p.name ASC;

-- -----------------------------------------
-- 5) Correlated Subquery in SELECT: review count per product
--    Show product name, price, and total reviews for each product
-- -----------------------------------------

SELECT p.name, p.price, (
        SELECT COUNT(*)
        FROM reviews r
        WHERE
            r.product_id = p.product_id
    ) AS review_count
FROM products p
ORDER BY review_count DESC;

-- -----------------------------------------
-- 6) Correlated Subquery with EXISTS: customers with reviews
--    Find customers who have written at least one review
-- -----------------------------------------

SELECT c.customer_id, c.first_name, c.last_name, c.email
FROM customers c
WHERE
    EXISTS (
        SELECT 1
        FROM reviews r
        WHERE
            r.customer_id = c.customer_id
    )
ORDER BY c.customer_id ASC;

-- -----------------------------------------
-- 7) Correlated Subquery with NOT EXISTS: customers with no orders
--    Find customers who have never placed any order
-- -----------------------------------------

SELECT c.customer_id, c.first_name, c.last_name, c.email
FROM customers c
WHERE
    NOT EXISTS (
        SELECT 1
        FROM orders o
        WHERE
            o.customer_id = c.customer_id
    )
ORDER BY c.customer_id ASC;

-- -----------------------------------------
-- 8) Subquery in FROM (Derived Table): average products per category
--    Calculate the overall average number of products across categories
-- -----------------------------------------

SELECT AVG(cat_counts.product_count) AS avg_products_per_category
FROM (
        SELECT p.category_id, COUNT(*) AS product_count
        FROM products p
        GROUP BY
            p.category_id
    ) AS cat_counts;