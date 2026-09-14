-- =========================================
-- Basic SELECT & Aggregation Queries
-- File: sql/03_queries.sql
-- =========================================

SELECT
    p.name AS product_name,
    s.name AS seller_name,
    ps.price,
    ps.stock
FROM
    products p
    INNER JOIN product_sellers ps ON p.product_id = ps.product_id
    INNER JOIN sellers s ON ps.seller_id = s.seller_id;

SELECT p.name AS product_name, s.name AS seller_name, ps.price
FROM
    products p
    INNER JOIN product_sellers ps ON p.product_id = ps.product_id
    INNER JOIN sellers s ON ps.seller_id = s.seller_id
WHERE
    ps.price > 100
ORDER BY ps.price DESC;

SELECT p.name AS product_name, s.name AS seller_name, ps.stock
FROM
    products p
    INNER JOIN product_sellers ps ON p.product_id = ps.product_id
    INNER JOIN sellers s ON ps.seller_id = s.seller_id
WHERE
    ps.stock > 15;

SELECT p.name AS product_name, s.name AS seller_name, ps.price
FROM
    products p
    INNER JOIN product_sellers ps ON p.product_id = ps.product_id
    INNER JOIN sellers s ON ps.seller_id = s.seller_id
WHERE
    ps.price BETWEEN 30 AND 100
ORDER BY ps.price ASC;

SELECT p.name AS product_name, s.name AS seller_name, ps.price
FROM
    products p
    INNER JOIN product_sellers ps ON p.product_id = ps.product_id
    INNER JOIN sellers s ON ps.seller_id = s.seller_id
ORDER BY ps.price DESC
LIMIT 3;

SELECT DISTINCT category_id FROM products;

SELECT name, category_id
FROM products
WHERE
    category_id IN (1, 3, 5);

SELECT
    p.name AS product_name,
    s.name AS seller_name,
    ps.price,
    ps.stock
FROM
    products p
    INNER JOIN product_sellers ps ON p.product_id = ps.product_id
    INNER JOIN sellers s ON ps.seller_id = s.seller_id
WHERE
    ps.price < 100
    OR ps.stock > 10

SELECT
    p.category_id,
    p.name AS product_name,
    s.name AS seller_name,
    ps.price
FROM
    products p
    INNER JOIN product_sellers ps ON p.product_id = ps.product_id
    INNER JOIN sellers s ON ps.seller_id = s.seller_id
WHERE
    p.category_id IN (1, 3, 5)
    AND ps.price > 30
ORDER BY ps.price DESC;

SELECT category_id, name
FROM products
WHERE
    category_id NOT IN(1, 2);

SELECT p.category_id, p.name AS product_name, ps.stock
FROM
    products p
    INNER JOIN product_sellers ps ON p.product_id = ps.product_id
WHERE (
        p.category_id = 1
        OR p.category_id = 2
    )
    AND ps.stock > 10;

SELECT
    p.product_id,
    p.name AS product_name,
    s.name AS seller_name,
    ps.price
FROM
    products p
    INNER JOIN product_sellers ps ON p.product_id = ps.product_id
    INNER JOIN sellers s ON ps.seller_id = s.seller_id
WHERE
    p.name LIKE 's%';

SELECT
    p.product_id,
    p.name AS product_name,
    s.name AS seller_name,
    ps.price
FROM
    products p
    INNER JOIN product_sellers ps ON p.product_id = ps.product_id
    INNER JOIN sellers s ON ps.seller_id = s.seller_id
WHERE
    p.name LIKE '%smart%';

SELECT
    payment_id,
    order_id,
    amount,
    status,
    paid_at
FROM payments
WHERE
    paid_at IS NULL;

SELECT
    payment_id,
    order_id,
    amount,
    paid_at
FROM payments
WHERE
    paid_at IS NOT NULL
    AND amount > 50
ORDER BY paid_at DESC;

SELECT COUNT(*) AS cheap_products_count
FROM
    products p
    INNER JOIN product_sellers ps ON p.product_id = ps.product_id
WHERE
    ps.price < 50;

SELECT
    MIN(price) AS min_price,
    MAX(price) AS max_price,
    AVG(price) AS avg_price
FROM product_sellers;

SELECT SUM(amount) AS total_paid_amount
FROM payments
WHERE
    paid_at IS NOT NULL;

SELECT category_id, COUNT(*) AS product_count
FROM products
GROUP BY
    category_id
ORDER BY product_count DESC;

SELECT
    product_id,
    AVG(rating) AS avg_rating,
    COUNT(*) AS review_count
FROM reviews
GROUP BY
    product_id
ORDER BY avg_rating DESC;

SELECT category_id, COUNT(*) AS product_count
FROM products
GROUP BY
    category_id
HAVING
    product_count >= 2
ORDER BY product_count DESC;

SELECT
    p.category_id,
    AVG(ps.price) AS avg_price,
    COUNT(*) AS qualifying_products_count
FROM
    products p
    INNER JOIN product_sellers ps ON p.product_id = ps.product_id
WHERE
    ps.price > 30
GROUP BY
    p.category_id
HAVING
    COUNT(*) >= 2
ORDER BY avg_price DESC;