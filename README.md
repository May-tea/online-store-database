# 🛒 Online Store Database (Marketplace Model)

A comprehensive, production-grade database project designed and optimized for a multi-seller E-commerce Marketplace using **MySQL 8.0**. This project demonstrates industry-standard database schema design, normalization, ACID transaction management, advanced analytics (Window Functions & CTEs), database programmability (Stored Procedures & Triggers), and query performance tuning.

---

## 🎯 Project Goals

- **High-Fidelity Schema Design:** Implement a fully normalized (3NF) relational schema that eliminates data redundancy.
- **Strict Referential Integrity:** Enforce marketplace-specific constraints using composite foreign keys.
- **Advanced Querying:** Demonstrate proficiency in complex analytical SQL (Window Functions, CTEs, Correlated Subqueries).
- **Database Programmability:** Encapsulate business logic directly within the database engine using Stored Procedures and Triggers.
- **Query Performance Optimization:** Analyze execution plans (`EXPLAIN`) and design single-column and composite indexes to minimize query costs.

---

## 🏗️ Project Directory Structure

```text
online-store-database/
├── README.md
├── schema/
│   └── 01_create_tables.sql          # Schema definition, table constraints & indexes
└── sql/
    ├── 02_insert_data.sql            # Rich seed data (consistent marketplace state)
    ├── 03_queries.sql                # Basic SELECT, filtering, and aggregate queries
    ├── 04_join_queries.sql           # Advanced multi-table JOINs (INNER, LEFT)
    ├── 05_subqueries.sql             # Scalar, multi-row, and correlated subqueries
    ├── 06_conditional_queries.sql    # Conditional logic (CASE & COALESCE)
    ├── 07_advanced_queries.sql       # Complex analytics (CTEs & Window Functions)
    ├── 08_data_modification.sql      # DML, ACID-compliant transactions & Views
    ├── 09_indexing_and_optimization.sql # Query performance tuning with EXPLAIN
    └── 10_procedures_and_triggers.sql # Stored Procedures and BEFORE UPDATE Triggers
```

---

## 📊 Database Architecture & Relations

The database consists of **10 core relational tables** designed around a modern Marketplace business model:

### Core Entities:

1. **`categories`**: Defines product taxonomy.
2. **`customers`**: Holds user profiles.
3. **`addresses`**: Handles user shipping addresses (1:N relation with customers).
4. **`products`**: Acts as a global product catalog (decoupled from price/stock).
5. **`sellers`**: Holds seller/merchant profiles.
6. **`product_sellers`**: Bridge table (N:M relation between products and sellers). **Acts as the Single Source of Truth (SSOT) for inventory stock and pricing per merchant.**
7. **`orders`**: Stores root order information.
8. **`order_items`**: Line items for orders. Enforces a composite foreign key referencing `(product_id, seller_id)` from `product_sellers` to guarantee order-to-merchant consistency.
9. **`payments`**: Handles financial transactions (1:1 relation with orders).
10. **`reviews`**: Stores product reviews (enforces a `UNIQUE(customer_id, product_id)` constraint to restrict users to one review per product).

---

## ⚡ Technical Highlights

### 1. Database Programmability

- **Stored Procedure (`GetProductOffers`):** A parameterized routine that accepts a `product_id` and returns all available merchant offers (sorted by price) where stock is greater than zero.
- **Database Trigger (`trg_prevent_negative_stock`):** A robust `BEFORE UPDATE` trigger on `product_sellers` that intercepts DML updates and raises a custom database exception via `SIGNAL SQLSTATE '45000'` if the stock falls below zero.

### 2. ACID-Compliant Transactions

- Implements atomic, multi-step transactions using `START TRANSACTION` and `COMMIT` to safely decrement merchant stock and insert pending orders concurrently, avoiding race conditions and ensuring data consistency.

### 3. Advanced Analytics & Window Functions

- **Analytical Windowing:** Employs `ROW_NUMBER()` and `DENSE_RANK()` for partitioning and ranking products within categories, `SUM() OVER` for calculating rolling/cumulative revenue streams, and `LAG()` to analyze transaction-to-transaction financial differences.
- **Chained CTEs:** Uses nested Common Table Expressions (`WITH ... AS`) to perform complex multi-level aggregations, such as benchmarking individual customer spending against the platform average.

### 4. Indexing & Performance Tuning

- Implements B-Tree indexes on heavily queried columns:
  - Single-column index on `products(name)` for fast string matching.
  - Composite index on `orders(customer_id, status)` for optimizing customer dashboard queries.
  - Range index on `product_sellers(price)` to accelerate sorting and range filtering.
- Utilizes the `EXPLAIN` keyword to verify execution plan optimizations, transforming costly Full Table Scans (`type: ALL`) into extremely fast indexed scans (`type: ref` or `type: range`).

### 5. Database Views

- **`products_overview_view`:** Consolidates product catalog statistics (categories, lowest available price, total stock across all merchants, and merchant counts) into a simplified virtual table, providing a clean API for frontend consumption.

---

## 🚀 Getting Started & Installation

### Prerequisites

- **MySQL 8.0** installed locally or running in a container.
- Access to a MySQL command-line client or terminal.

### Step-by-Step Setup

1. Clone the repository:

```bash
git clone https://github.com/May-tea/online-store-database.git
cd online-store-database
```

2. Initialize the database schema and constraints:

```bash
mysql -u devuser -p < schema/01_create_tables.sql
```

3. Seed the database with high-integrity sample data:

```bash
mysql -u devuser -p < sql/02_insert_data.sql
```

4. You can now execute and explore the query files located in the `sql/` directory sequentially (from `03` to `10`) using your preferred database client or direct terminal queries.

---

## 👨‍💻 Author

- **Mahdiyar Babaghassabha**
- GitHub: [@May-tea](https://github.com/May-tea)

---
