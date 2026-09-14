-- =========================================
-- Stored Procedures & Triggers
-- File: sql/10_procedures_and_triggers.sql
-- =========================================

-- -----------------------------------------
-- 1) Stored Procedure: Get Available Offers for a Product
--    Retrieve all seller offers (price and stock) for a specific product ID
-- -----------------------------------------

DELIMITER //

CREATE PROCEDURE GetProductOffers(IN p_product_id INT)
BEGIN
    SELECT 
        p.name AS product_name, 
        s.name AS seller_name, 
        ps.price, 
        ps.stock
    FROM products p
    INNER JOIN product_sellers ps ON p.product_id = ps.product_id
    INNER JOIN sellers s ON ps.seller_id = s.seller_id
    WHERE ps.product_id = p_product_id AND ps.stock > 0
    ORDER BY ps.price ASC;
END //

DELIMITER ;

-- Test the procedure:
CALL GetProductOffers (1);

-- -----------------------------------------
-- 2) BEFORE UPDATE Trigger: prevent negative stock
--    Automatically validate and prevent setting a negative stock value
-- -----------------------------------------

DELIMITER //

CREATE TRIGGER trg_prevent_negative_stock
BEFORE UPDATE ON product_sellers
FOR EACH ROW
BEGIN
    IF NEW.stock < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Stock cannot be negative!';
    END IF;
END //

DELIMITER ;