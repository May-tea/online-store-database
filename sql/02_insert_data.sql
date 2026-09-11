USE online_store;

INSERT INTO
    categories (name, description)
VALUES (
        'Electronics',
        'Electronic devices and gadgets'
    ),
    (
        'Laptops',
        'Laptops and portable computers'
    ),
    (
        'Mobile Phones',
        'Smartphones and mobile devices'
    ),
    (
        'Books',
        'Books and educational materials'
    ),
    (
        'Accessories',
        'Computer and mobile accessories'
    );

INSERT INTO
    customers (
        first_name,
        last_name,
        email,
        phone,
        birth_date
    )
VALUES (
        'Mahdiyar',
        'Babaghassabha',
        'mahdiyar.babaghassabha@example.com',
        '09011234567',
        '1993-08-01'
    ),
    (
        'Ali',
        'Ahmadi',
        'ali.ahmadi@example.com',
        '09121234567',
        '1995-04-12'
    ),
    (
        'Sara',
        'Mohammadi',
        'sara.mohammadi@example.com',
        '09129876543',
        '1998-09-25'
    ),
    (
        'Reza',
        'Karimi',
        'reza.karimi@example.com',
        '09351234567',
        '1992-01-18'
    ),
    (
        'Neda',
        'Hosseini',
        'neda.hosseini@example.com',
        '09192345678',
        '1997-06-30'
    );

INSERT INTO
    addresses (
        customer_id,
        title,
        city,
        street,
        postal_code
    )
VALUES (
        1,
        'Home',
        'Qazvin',
        'Imam Street, No. 12',
        '3415612345'
    ),
    (
        2,
        'Home',
        'Tehran',
        'Valiasr Street, No. 25',
        '1435812345'
    ),
    (
        3,
        'Home',
        'Tehran',
        'Keshavarz Blvd, No. 18',
        '1416712345'
    ),
    (
        4,
        'Work',
        'Karaj',
        'Azadi Street, No. 40',
        '3145612345'
    ),
    (
        5,
        'Home',
        'Mashhad',
        'Ferdowsi Street, No. 7',
        '9187612345'
    );

INSERT INTO
    products (
        category_id,
        name,
        description,
        price,
        stock
    )
VALUES (
        1,
        'Wireless Headphones',
        'Noise cancelling wireless headphones',
        89.99,
        25
    ),
    (
        1,
        'Smart Watch',
        'Fitness and health tracking smartwatch',
        129.99,
        18
    ),
    (
        2,
        'Lenovo ThinkPad E14',
        '14 inch business laptop',
        749.99,
        10
    ),
    (
        2,
        'ASUS VivoBook 15',
        '15 inch everyday laptop',
        649.99,
        12
    ),
    (
        3,
        'Samsung Galaxy A55',
        'Mid-range Android smartphone',
        399.99,
        20
    ),
    (
        3,
        'Xiaomi Redmi Note 13',
        'Affordable Android smartphone',
        249.99,
        30
    ),
    (
        4,
        'Clean Code',
        'A handbook of agile software craftsmanship',
        35.99,
        15
    ),
    (
        4,
        'Python Crash Course',
        'Beginner-friendly Python programming book',
        29.99,
        22
    ),
    (
        5,
        'Wireless Mouse',
        'Ergonomic wireless computer mouse',
        24.99,
        40
    ),
    (
        5,
        'USB-C Hub',
        'Multi-port USB-C adapter',
        39.99,
        35
    );

INSERT INTO
    sellers (name, email, phone)
VALUES (
        'Tech Store',
        'tech.store@example.com',
        '09111111111'
    ),
    (
        'Digital World',
        'digital.world@example.com',
        '09222222222'
    ),
    (
        'Laptop Center',
        'laptop.center@example.com',
        '09333333333'
    ),
    (
        'Mobile Shop',
        'mobile.shop@example.com',
        '09444444444'
    ),
    (
        'Book Market',
        'book.market@example.com',
        '09555555555'
    );

INSERT INTO
    product_sellers (
        product_id,
        seller_id,
        price,
        stock
    )
VALUES (1, 1, 89.99, 10),
    (1, 2, 84.99, 15),
    (2, 1, 129.99, 8),
    (2, 2, 124.99, 10),
    (3, 3, 749.99, 5),
    (3, 1, 759.99, 3),
    (4, 3, 649.99, 7),
    (5, 4, 399.99, 12),
    (5, 2, 389.99, 8),
    (6, 4, 249.99, 15),
    (7, 5, 35.99, 10),
    (8, 5, 29.99, 14),
    (9, 1, 24.99, 20),
    (10, 2, 39.99, 18);

INSERT INTO
    orders (
        customer_id,
        address_id,
        status,
        total_amount
    )
VALUES (1, 1, 'paid', 214.98),
    (2, 2, 'shipped', 749.99),
    (3, 3, 'delivered', 399.99),
    (4, 4, 'pending', 649.99),
    (5, 5, 'cancelled', 89.99);

INSERT INTO
    order_items (
        order_id,
        product_id,
        quantity,
        unit_price
    )
VALUES (1, 1, 1, 84.99),
    (1, 2, 1, 129.99),
    (2, 3, 1, 749.99),
    (3, 5, 1, 399.99),
    (4, 4, 1, 649.99),
    (5, 1, 1, 89.99);

INSERT INTO
    payments (
        order_id,
        amount,
        method,
        status,
        paid_at,
        transaction_id
    )
VALUES (
        1,
        214.98,
        'card',
        'successful',
        '2026-09-01 10:30:00',
        'TXN10001'
    ),
    (
        2,
        749.99,
        'bank_transfer',
        'successful',
        '2026-09-02 14:15:00',
        'TXN10002'
    ),
    (
        3,
        399.99,
        'card',
        'successful',
        '2026-09-03 09:45:00',
        'TXN10003'
    ),
    (
        4,
        649.99,
        'wallet',
        'pending',
        NULL,
        'TXN10004'
    ),
    (
        5,
        89.99,
        'card',
        'failed',
        NULL,
        'TXN10005'
    );

INSERT INTO
    reviews (
        customer_id,
        product_id,
        rating,
        comment
    )
VALUES (
        1,
        1,
        5,
        'Great headphones with good sound quality.'
    ),
    (
        2,
        3,
        4,
        'Good laptop for everyday work.'
    ),
    (
        3,
        5,
        5,
        'Excellent phone and good performance.'
    ),
    (
        4,
        7,
        4,
        'Very useful book for programmers.'
    ),
    (
        5,
        2,
        3,
        'Good watch but battery could be better.'
    );