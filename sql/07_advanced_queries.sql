-- =========================================
-- Advanced Queries (CTEs & Window Functions)
-- File: sql/07_advanced_queries.sql
-- =========================================

-- -----------------------------------------
-- 1) Basic CTE: category statistics summary
--    Calculate product counts and average prices per category using a CTE
-- -----------------------------------------

WITH
    category_stats AS (
        SELECT p.category_id, COUNT(*) AS product_count, AVG(ps.price) AS avg_price
        FROM
            products p
            INNER JOIN product_sellers ps ON p.product_id = ps.product_id
        GROUP BY
            p.category_id
    )
SELECT c.name AS category_name, cs.product_count, cs.avg_price
FROM
    categories c
    INNER JOIN category_stats cs ON cs.category_id = c.category_id
ORDER BY cs.avg_price DESC;

-- -----------------------------------------
-- 2) Multiple CTEs: high-spending customers
--    Identify customers whose total spending is above the average customer spending
-- -----------------------------------------

WITH
    customer_spending AS (
        SELECT o.customer_id, SUM(p.amount) AS total_spent
        FROM orders o
            INNER JOIN payments p ON p.order_id = o.order_id
        WHERE
            p.paid_at IS NOT NULL
        GROUP BY
            o.customer_id
    ),
    spending_benchmark AS (
        SELECT AVG(total_spent) AS avg_spending
        FROM customer_spending
    )
SELECT c.customer_id, c.first_name, c.last_name, cs.total_spent, sb.avg_spending
FROM
    customers c
    INNER JOIN customer_spending cs ON cs.customer_id = c.customer_id
    CROSS JOIN spending_benchmark sb
WHERE
    cs.total_spent > sb.avg_spending
ORDER BY cs.total_spent DESC;

-- -----------------------------------------
-- 3) Window Function: ROW_NUMBER()
--    Rank products by price within each category
-- -----------------------------------------

SELECT p.product_id, p.category_id, p.name, ps.price, ROW_NUMBER() OVER (
        PARTITION BY
            p.category_id
        ORDER BY ps.price DESC
    ) AS price_rank
FROM
    products p
    INNER JOIN product_sellers ps ON p.product_id = ps.product_id
ORDER BY category_id, price_rank ASC;

-- -----------------------------------------
-- 4) Top-N per Group (CTE + DENSE_RANK)
--    Find the single most expensive product in each category
-- -----------------------------------------

WITH
    ranked_products AS (
        SELECT p.category_id, p.name, ps.price, DENSE_RANK() OVER (
                PARTITION BY
                    p.category_id
                ORDER BY ps.price DESC
            ) AS rnk
        FROM
            products p
            INNER JOIN product_sellers ps ON p.product_id = ps.product_id
    )
SELECT
    c.name AS category_name,
    rp.name AS product_name,
    rp.price
FROM
    categories c
    INNER JOIN ranked_products rp ON rp.category_id = c.category_id
WHERE
    rp.rnk = 1
ORDER BY rp.price DESC;

-- -----------------------------------------
-- 5) Window Function: Running Total
--    Calculate cumulative revenue over time from completed payments
-- -----------------------------------------

SELECT
    payment_id,
    amount,
    paid_at,
    SUM(amount) OVER (
        ORDER BY paid_at ASC
    ) AS cumulative_revenue
FROM payments
WHERE
    paid_at IS NOT NULL
ORDER BY paid_at ASC;

-- -----------------------------------------
-- 6) Window Function: LAG()
--    Compare each completed payment amount with the previous payment
-- -----------------------------------------

SELECT
    payment_id,
    amount AS current_amount,
    paid_at,
    LAG(amount, 1) OVER (
        ORDER BY paid_at ASC
    ) AS previous_amount,
    (
        amount - LAG(amount, 1) OVER (
            ORDER BY paid_at ASC
        )
    ) AS amount_difference
FROM payments
WHERE
    paid_at IS NOT NULL
ORDER BY paid_at ASC;