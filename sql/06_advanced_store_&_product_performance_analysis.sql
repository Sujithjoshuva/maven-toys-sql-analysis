-- ============================================================
-- Maven Toys SQL Business Analysis
-- Lesson 6: Advanced Store & Product Performance Analysis
-- ============================================================


-- ============================================================
-- 1. Store Revenue Ranking
-- ============================================================

SELECT
    s.Store_ID,
    st.Store_Name,
    SUM(s.Units * p.Product_Price) AS total_revenue
FROM sales AS s
INNER JOIN products AS p
    ON s.Product_ID = p.Product_ID
INNER JOIN stores AS st
    ON s.Store_ID = st.Store_ID
GROUP BY
    s.Store_ID,
    st.Store_Name
ORDER BY
    total_revenue DESC;


-- ============================================================
-- 2. Top 10 Stores by Revenue
-- ============================================================

WITH store_revenue AS (
    SELECT
        s.Store_ID,
        st.Store_Name,
        SUM(s.Units * p.Product_Price) AS total_revenue
    FROM sales AS s
    INNER JOIN products AS p
        ON s.Product_ID = p.Product_ID
    INNER JOIN stores AS st
        ON s.Store_ID = st.Store_ID
    GROUP BY
        s.Store_ID,
        st.Store_Name
),
revenue_ranking AS (
    SELECT
        Store_ID,
        Store_Name,
        total_revenue,
        ROW_NUMBER() OVER (
            ORDER BY total_revenue DESC
        ) AS revenue_rank
    FROM store_revenue
)
SELECT
    Store_ID,
    Store_Name,
    total_revenue,
    revenue_rank
FROM revenue_ranking
WHERE revenue_rank <= 10
ORDER BY revenue_rank;


-- ============================================================
-- 3. Top 3 Products by Revenue Within Each Category
-- ============================================================

WITH product_revenue AS (
    SELECT
        p.Product_ID,
        p.Product_Name,
        p.Product_Category,
        SUM(s.Units * p.Product_Price) AS total_revenue
    FROM sales AS s
    INNER JOIN products AS p
        ON s.Product_ID = p.Product_ID
    GROUP BY
        p.Product_ID,
        p.Product_Name,
        p.Product_Category
),
revenue_ranking AS (
    SELECT
        Product_ID,
        Product_Name,
        Product_Category,
        total_revenue,
        ROW_NUMBER() OVER (
            PARTITION BY Product_Category
            ORDER BY total_revenue DESC
        ) AS category_revenue_rank
    FROM product_revenue
)
SELECT
    Product_ID,
    Product_Name,
    Product_Category,
    total_revenue,
    category_revenue_rank
FROM revenue_ranking
WHERE category_revenue_rank <= 3
ORDER BY
    Product_Category,
    category_revenue_rank;


-- ============================================================
-- 4. Top 3 Products by Profit Within Each Category
-- ============================================================

WITH product_profit AS (
    SELECT
        p.Product_ID,
        p.Product_Name,
        p.Product_Category,
        SUM(
            s.Units * (p.Product_Price - p.Product_Cost)
        ) AS total_profit
    FROM sales AS s
    INNER JOIN products AS p
        ON s.Product_ID = p.Product_ID
    GROUP BY
        p.Product_ID,
        p.Product_Name,
        p.Product_Category
),
profit_ranking AS (
    SELECT
        Product_ID,
        Product_Name,
        Product_Category,
        total_profit,
        ROW_NUMBER() OVER (
            PARTITION BY Product_Category
            ORDER BY total_profit DESC
        ) AS category_profit_rank
    FROM product_profit
)
SELECT
    Product_ID,
    Product_Name,
    Product_Category,
    total_profit,
    category_profit_rank
FROM profit_ranking
WHERE category_profit_rank <= 3
ORDER BY
    Product_Category,
    category_profit_rank;


-- ============================================================
-- 5. Top 2 Products by Profit Margin Within Each Category
-- ============================================================

WITH product_margin AS (
    SELECT
        p.Product_ID,
        p.Product_Name,
        p.Product_Category,
        ROUND(
            SUM(
                s.Units * (p.Product_Price - p.Product_Cost)
            )
            / SUM(s.Units * p.Product_Price) * 100,
            2
        ) AS profit_margin
    FROM sales AS s
    INNER JOIN products AS p
        ON s.Product_ID = p.Product_ID
    GROUP BY
        p.Product_ID,
        p.Product_Name,
        p.Product_Category
),
margin_ranking AS (
    SELECT
        Product_ID,
        Product_Name,
        Product_Category,
        profit_margin,
        RANK() OVER (
            PARTITION BY Product_Category
            ORDER BY profit_margin DESC
        ) AS margin_rank
    FROM product_margin
)
SELECT
    Product_ID,
    Product_Name,
    Product_Category,
    profit_margin,
    margin_rank
FROM margin_ranking
WHERE margin_rank <= 2
ORDER BY
    Product_Category,
    margin_rank;


-- ============================================================
-- 6. Store Revenue, Profit & Profit Margin Ranking
-- ============================================================

WITH store_metrics AS (
    SELECT
        st.Store_ID,
        st.Store_Name,

        SUM(s.Units * p.Product_Price) AS total_revenue,

        SUM(
            s.Units * (p.Product_Price - p.Product_Cost)
        ) AS total_profit,

        ROUND(
            SUM(
                s.Units * (p.Product_Price - p.Product_Cost)
            )
            / SUM(s.Units * p.Product_Price) * 100,
            2
        ) AS profit_margin

    FROM sales AS s
    INNER JOIN products AS p
        ON s.Product_ID = p.Product_ID
    INNER JOIN stores AS st
        ON s.Store_ID = st.Store_ID
    GROUP BY
        st.Store_ID,
        st.Store_Name
)
SELECT
    Store_ID,
    Store_Name,
    total_revenue,
    total_profit,
    profit_margin,

    RANK() OVER (
        ORDER BY total_revenue DESC
    ) AS revenue_rank,

    RANK() OVER (
        ORDER BY total_profit DESC
    ) AS profit_rank,

    RANK() OVER (
        ORDER BY profit_margin DESC
    ) AS margin_rank

FROM store_metrics
ORDER BY revenue_rank;


-- ============================================================
-- 7. Store Performance Benchmark Classification
-- ============================================================

WITH store_metrics AS (
    SELECT
        st.Store_ID,
        st.Store_Name,
        SUM(s.Units * p.Product_Price) AS total_revenue,
        SUM(
            s.Units * (p.Product_Price - p.Product_Cost)
        ) AS total_profit
    FROM sales AS s
    INNER JOIN products AS p
        ON s.Product_ID = p.Product_ID
    INNER JOIN stores AS st
        ON s.Store_ID = st.Store_ID
    GROUP BY
        st.Store_ID,
        st.Store_Name
),
benchmarks AS (
    SELECT
        AVG(total_revenue) AS avg_revenue,
        AVG(total_profit) AS avg_profit
    FROM store_metrics
)
SELECT
    sm.Store_ID,
    sm.Store_Name,
    sm.total_revenue,
    sm.total_profit,
    ROUND(b.avg_revenue, 2) AS avg_revenue,
    ROUND(b.avg_profit, 2) AS avg_profit,
    CASE
        WHEN sm.total_revenue >= b.avg_revenue
         AND sm.total_profit >= b.avg_profit
        THEN 'Strong Performer'
        ELSE 'Needs Improvement'
    END AS performance_status
FROM store_metrics AS sm
CROSS JOIN benchmarks AS b
ORDER BY
    sm.total_revenue DESC;


-- ============================================================
-- 8. Store Performance Quadrant Analysis
-- ============================================================

WITH store_metrics AS (
    SELECT
        st.Store_ID,
        st.Store_Name,
        SUM(s.Units * p.Product_Price) AS total_revenue,
        SUM(
            s.Units * (p.Product_Price - p.Product_Cost)
        ) AS total_profit
    FROM sales AS s
    INNER JOIN products AS p
        ON s.Product_ID = p.Product_ID
    INNER JOIN stores AS st
        ON s.Store_ID = st.Store_ID
    GROUP BY
        st.Store_ID,
        st.Store_Name
),
benchmarks AS (
    SELECT
        AVG(total_revenue) AS avg_revenue,
        AVG(total_profit) AS avg_profit
    FROM store_metrics
)
SELECT
    CASE
        WHEN sm.total_revenue >= b.avg_revenue
         AND sm.total_profit >= b.avg_profit
            THEN 'High Revenue + High Profit'

        WHEN sm.total_revenue >= b.avg_revenue
         AND sm.total_profit < b.avg_profit
            THEN 'High Revenue + Low Profit'

        WHEN sm.total_revenue < b.avg_revenue
         AND sm.total_profit >= b.avg_profit
            THEN 'Low Revenue + High Profit'

        ELSE 'Low Revenue + Low Profit'
    END AS performance_group,

    COUNT(*) AS store_count

FROM store_metrics AS sm
CROSS JOIN benchmarks AS b

GROUP BY
    performance_group

ORDER BY
    store_count DESC;
