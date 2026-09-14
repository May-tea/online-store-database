-- =========================================
-- Indexing & Query Optimization
-- File: sql/09_indexing_and_optimization.sql
-- =========================================

-- -----------------------------------------
-- 1) Create Index on Frequently Searched Column
--    Add an index on products(name) to speed up search queries
-- -----------------------------------------

CREATE INDEX idx_products_name ON products (name);

EXPLAIN SELECT * FROM products WHERE name = 'Smart Watch';

-- -----------------------------------------
-- 2) Composite Index: orders by customer and status
--    Create a composite index on orders(customer_id, status) to optimize user order lookups
-- -----------------------------------------

CREATE INDEX idx_orders_customer_status ON orders (customer_id, status);

EXPLAIN
SELECT *
FROM orders
WHERE
    customer_id = 1
    AND status = 'pending';

-- -----------------------------------------
-- 3) Index for Range & Sorting: product_sellers pricing
--    Create an index on product_sellers(price) to accelerate price filtering and sorting
-- -----------------------------------------

CREATE INDEX idx_product_sellers_price ON product_sellers (price);

EXPLAIN
SELECT *
FROM product_sellers
WHERE
    price BETWEEN 50 AND 200
ORDER BY price ASC;

-- -----------------------------------------
-- 4) Inspect Table Indexes
--    Show all indexes defined on a table
-- -----------------------------------------

SHOW INDEX FROM products;

SHOW INDEX FROM orders;

SHOW INDEX FROM product_sellers;