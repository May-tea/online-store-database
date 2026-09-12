-- Basic SELECT queries

SELECT name, price, stock FROM products;

SELECT name, price FROM products WHERE price > 100;

SELECT name, stock FROM products WHERE stock > 20;

SELECT name, price FROM products WHERE price > 30 AND price < 100;

SELECT name, price FROM products ORDER BY price DESC;

SELECT name, price
FROM products
WHERE
    price > 30
ORDER BY price DESC;

SELECT name, price FROM products ORDER BY price DESC LIMIT 3;

SELECT DISTINCT category_id FROM products;

SELECT name, category_id
FROM products
WHERE
    category_id IN (1, 3, 5);

SELECT name, price, stock
FROM products
WHERE
    price < 100
    or stock > 40;

SELECT category_id, name, price
FROM products
WHERE
    category_id IN (1, 3, 5)
    AND price > 30
ORDER BY price DESC;

SELECT category_id, name
FROM products
WHERE
    category_id NOT IN(1, 2);

SELECT name, price
FROM products
WHERE
    price BETWEEN 20 AND 100
ORDER BY price ASC;

SELECT name, price, stock
FROM products
WHERE
    stock < 15
    OR price > 500;

SELECT category_id, name, stock
FROM products
WHERE (
        category_id = 1
        OR category_id = 2
    )
    AND stock > 10;

SELECT product_id, name, price FROM products WHERE name LIKE 's%';

SELECT product_id, name, price
FROM products
WHERE
    name LIKE '%smart%';

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
FROM products
WHERE
    price < 50;

SELECT
    MIN(price) AS min_price,
    MAX(price) AS max_price,
    AVG(price) AS avg_price
FROM products;

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
    category_id,
    AVG(price) AS avg_price,
    COUNT(*) AS qualifying_products_count
FROM products
WHERE
    price > 30
GROUP BY
    category_id
HAVING
    qualifying_products_count >= 2
ORDER BY avg_price DESC;