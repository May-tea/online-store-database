-- =========================================
-- Data Modification (UPDATE, DELETE, Transactions, Views)
-- File: sql/08_data_modification.sql
-- =========================================

-- -----------------------------------------
-- 1) Simple UPDATE: change a seller's price for a product
--    Update the price of product_id = 1 offered by seller_id = 1
-- -----------------------------------------

UPDATE product_sellers
SET
    price = 119.99
WHERE
    product_id = 1
    AND seller_id = 1;

-- -----------------------------------------
-- 2) Calculated & Multi-Column UPDATE with Subquery: apply category discount
--    Decrease price by 10% and increase stock by 5 for all offers in category_id = 1
-- -----------------------------------------

UPDATE product_sellers
SET
    price = price * 0.9,
    stock = stock + 5
WHERE
    product_id IN (
        SELECT product_id
        FROM products
        WHERE
            category_id = 1
    );

-- -----------------------------------------
-- 3) Conditional DELETE: remove low-rated reviews
--    Delete reviews that have a rating of 1 or 2
-- -----------------------------------------

DELETE FROM reviews WHERE rating <= 2;

-- -----------------------------------------
-- 4) Database Transaction: safe multi-step operation
--    Deduct stock and insert a simulated order record atomically
-- -----------------------------------------

START TRANSACTION;

UPDATE product_sellers
SET
    stock = stock - 1
WHERE
    product_id = 2
    AND seller_id = 1;

INSERT INTO
    orders (
        customer_id,
        address_id,
        status,
        total_amount
    )
VALUES (1, 1, 'pending', 129.99);

COMMIT;

-- -----------------------------------------
-- 5) CREATE VIEW: product catalog overview
--    Create a virtual table consolidating category, pricing, stock, and seller counts
-- -----------------------------------------

CREATE VIEW products_overview_view AS
SELECT
    p.product_id,
    c.name AS category_name,
    p.name AS product_name,
    MIN(ps.price) AS min_price,
    SUM(ps.stock) AS total_stock,
    COUNT(ps.seller_id) AS seller_count
FROM
    products p
    INNER JOIN categories c ON p.category_id = c.category_id
    INNER JOIN product_sellers ps ON p.product_id = ps.product_id
GROUP BY
    p.product_id,
    c.name,
    p.name;

-- -----------------------------------------
-- 6) Querying a VIEW: select from the virtual table
--    Query the created view as if it were a regular table
-- -----------------------------------------

SELECT
    product_name,
    category_name,
    min_price,
    total_stock
FROM products_overview_view
WHERE
    total_stock > 10
ORDER BY min_price ASC;