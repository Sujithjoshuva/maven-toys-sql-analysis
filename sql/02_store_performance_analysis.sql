-- ============================================================
-- MAVEN TOYS SQL ANALYSIS
-- Lesson 2: Store Performance Analysis
-- ============================================================

-- Purpose:
-- Analyze store performance using transaction volume,
-- total units sold, average units per transaction,
-- product rankings, and performance classification.


-- ============================================================
-- 1. STORE TRANSACTION ACTIVITY
-- ============================================================

-- Identify stores with the highest number of transactions.

SELECT
    s.Store_ID,
    st.Store_Name,
    COUNT(*) AS total_transactions
FROM sales AS s
INNER JOIN stores AS st
    ON s.Store_ID = st.Store_ID
GROUP BY
    s.Store_ID,
    st.Store_Name
ORDER BY total_transactions DESC;


-- ============================================================
-- 2. STORE PERFORMANCE METRICS
-- ============================================================

-- Calculate transaction count, total units sold,
-- and average units sold per transaction for each store.

SELECT
    Store_ID,
    COUNT(*) AS total_transactions,
    SUM(Units) AS total_units,
    AVG(Units) AS avg_units_per_transaction
FROM sales
GROUP BY Store_ID
ORDER BY total_transactions DESC;


-- ============================================================
-- 3. TOP PRODUCTS WITHIN EACH STORE
-- ============================================================

-- Rank products within each store based on total units sold.
-- ROW_NUMBER() restarts the ranking for every Store_ID.

SELECT
    Store_ID,
    Product_Name,
    total_units,
    Product_rank
FROM (
    SELECT
        Store_ID,
        Product_Name,
        total_units,
        ROW_NUMBER() OVER (
            PARTITION BY Store_ID
            ORDER BY total_units DESC
        ) AS Product_rank
    FROM (
        SELECT
            s.Store_ID,
            p.Product_ID,
            p.Product_Name,
            SUM(s.Units) AS total_units
        FROM sales AS s
        INNER JOIN products AS p
            ON s.Product_ID = p.Product_ID
        GROUP BY
            s.Store_ID,
            p.Product_ID,
            p.Product_Name
    ) AS product_total
) AS ranked_products
WHERE Product_rank <= 5;


-- ============================================================
-- 4. BENCHMARKS FOR STORE CLASSIFICATION
-- ============================================================

-- Calculate the average number of transactions per store.

SELECT
    AVG(total_transactions) AS avg_transactions_per_store
FROM (
    SELECT
        Store_ID,
        COUNT(*) AS total_transactions
    FROM sales
    GROUP BY Store_ID
) AS store_transactions;


-- Calculate the overall average units per transaction.

SELECT
    AVG(Units) AS avg_units_per_transaction
FROM sales;


-- ============================================================
-- 5. STORE PERFORMANCE CLASSIFICATION
-- ============================================================

-- Benchmarks:
-- Average transactions per store = 600
-- Average units per transaction = 1.3193
--
-- Stores are classified into four performance groups:
-- 1. Strong Performer
-- 2. Higher Traffic, Lower Basket
-- 3. Lower Traffic, Higher Basket
-- 4. Needs Improvement

SELECT
    store_performance.Store_ID,
    store_performance.Store_Name,
    store_performance.total_transactions,
    store_performance.total_units_sold,
    store_performance.avg_units_per_transaction,
    store_performance.store_performance
FROM (
    SELECT
        store_metrics.Store_ID,
        stores.Store_Name,
        store_metrics.total_transactions,
        store_metrics.total_units_sold,
        store_metrics.avg_units_per_transaction,

        CASE
            WHEN store_metrics.transaction_activity = 'High'
                 AND store_metrics.basket_size = 'High'
                THEN 'Strong Performer'

            WHEN store_metrics.transaction_activity = 'High'
                 AND store_metrics.basket_size = 'Low'
                THEN 'Higher Traffic, Lower Basket'

            WHEN store_metrics.transaction_activity = 'Low'
                 AND store_metrics.basket_size = 'High'
                THEN 'Lower Traffic, Higher Basket'

            ELSE 'Needs Improvement'
        END AS store_performance

    FROM (
        SELECT
            Store_ID,
            COUNT(*) AS total_transactions,
            SUM(Units) AS total_units_sold,
            AVG(Units) AS avg_units_per_transaction,

            CASE
                WHEN COUNT(*) >= 600 THEN 'High'
                ELSE 'Low'
            END AS transaction_activity,

            CASE
                WHEN AVG(Units) >= 1.3193 THEN 'High'
                ELSE 'Low'
            END AS basket_size

        FROM sales
        GROUP BY Store_ID
    ) AS store_metrics

    INNER JOIN stores
        ON stores.Store_ID = store_metrics.Store_ID
) AS store_performance
ORDER BY store_performance.Store_ID;


-- ============================================================
-- END OF LESSON 2
-- ============================================================
