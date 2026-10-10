-- ============================================================
-- Project: Maven Toys SQL Business Analysis
-- Lesson 7: Advanced KPI & Contribution Analysis
--
-- Dataset Note:
-- This analysis uses a 30,000-row sample of sales data,
-- not the complete original sales dataset.
--
-- Topics:
-- 1. Store Revenue Contribution
-- 2. Cumulative Revenue Contribution
-- 3. Store Revenue Quartiles
-- 4. Revenue and Profit by Quartile
-- 5. Profit Margin by Revenue Quartile
-- ============================================================
-- ============================================================
-- Lesson 7: Advanced KPI & Contribution Analysis
-- Query 1: Store Revenue Contribution
-- ============================================================
WITH store_revenue AS (
    SELECT
        st.Store_ID,
        st.Store_Name,
        SUM(s.Units * p.Product_Price) AS total_revenue
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
    ROUND(total_revenue, 2) AS total_revenue,
    ROUND(
        SUM(total_revenue) OVER (),
        2
    ) AS overall_revenue,
    ROUND(
        total_revenue
        / SUM(total_revenue) OVER () * 100,
        2
    ) AS revenue_contribution_pct
FROM store_revenue
ORDER BY
    total_revenue DESC;

-- ============================================================
-- Query 2: Cumulative Revenue Contribution
-- ============================================================
WITH store_revenue AS (
    SELECT
        st.Store_ID,
        st.Store_Name,
        SUM(s.Units * p.Product_Price) AS total_revenue
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
    ROUND(total_revenue, 2) AS total_revenue,
    ROUND(
        SUM(total_revenue) OVER (
            ORDER BY total_revenue DESC
        ),
        2
    ) AS cumulative_revenue,
    ROUND(
        SUM(total_revenue) OVER (
            ORDER BY total_revenue DESC
        )
        / SUM(total_revenue) OVER () * 100,
        2
    ) AS cumulative_revenue_pct
FROM store_revenue
ORDER BY total_revenue DESC;

-- ============================================================
-- Query 3: Store Revenue Quartiles
-- ============================================================
WITH store_revenue AS (
    SELECT
        st.Store_ID,
        st.Store_Name,
        SUM(s.Units * p.Product_Price) AS total_revenue
    FROM sales AS s
    INNER JOIN products AS p
        ON s.Product_ID = p.Product_ID
    INNER JOIN stores AS st
        ON s.Store_ID = st.Store_ID
    GROUP BY
        st.Store_ID,
        st.Store_Name
),
revenue_quartiles AS (
    SELECT
        Store_ID,
        Store_Name,
        total_revenue,
        NTILE(4) OVER (
            ORDER BY total_revenue DESC
        ) AS revenue_quartile
    FROM store_revenue
)
SELECT
    Store_ID,
    Store_Name,
    ROUND(total_revenue, 2) AS total_revenue,
    revenue_quartile
FROM revenue_quartiles
ORDER BY
    revenue_quartile,
    total_revenue DESC;

-- ============================================================
-- Query 4: Revenue and Profit by Quartile
-- ============================================================
WITH store_metrics AS (
    SELECT
        st.Store_ID,
        st.Store_Name,
        SUM(s.Units * p.Product_Price) AS total_revenue,
        SUM(s.Units * (p.Product_Price - p.Product_Cost)) AS total_profit
    FROM sales AS s
    INNER JOIN products AS p
        ON s.Product_ID = p.Product_ID
    INNER JOIN stores AS st
        ON s.Store_ID = st.Store_ID
    GROUP BY
        st.Store_ID,
        st.Store_Name
),
revenue_quartiles AS (
    SELECT
        Store_ID,
        Store_Name,
        total_revenue,
        total_profit,
        NTILE(4) OVER (
            ORDER BY total_revenue DESC
        ) AS revenue_quartile
    FROM store_metrics
)
SELECT
    revenue_quartile,
    COUNT(*) AS number_of_stores,
    ROUND(SUM(total_revenue), 2) AS total_revenue,
    ROUND(SUM(total_profit), 2) AS total_profit,
    ROUND(AVG(total_revenue), 2) AS avg_revenue_per_store,
    ROUND(AVG(total_profit), 2) AS avg_profit_per_store
FROM revenue_quartiles
GROUP BY revenue_quartile
ORDER BY revenue_quartile;

-- ============================================================
-- Query 5: Profit Margin by Revenue Quartile
-- ============================================================
WITH store_metrics AS (
    SELECT
        st.Store_ID,
        st.Store_Name,
        SUM(s.Units * p.Product_Price) AS total_revenue,
        SUM(s.Units * (p.Product_Price - p.Product_Cost)) AS total_profit
    FROM sales AS s
    INNER JOIN products AS p
        ON s.Product_ID = p.Product_ID
    INNER JOIN stores AS st
        ON s.Store_ID = st.Store_ID
    GROUP BY
        st.Store_ID,
        st.Store_Name
),
revenue_quartiles AS (
    SELECT
        Store_ID,
        Store_Name,
        total_revenue,
        total_profit,
        NTILE(4) OVER (
            ORDER BY total_revenue DESC
        ) AS revenue_quartile
    FROM store_metrics
)
SELECT
    revenue_quartile,
    COUNT(*) AS number_of_stores,
    ROUND(SUM(total_revenue), 2) AS total_revenue,
    ROUND(SUM(total_profit), 2) AS total_profit,
    ROUND(
        SUM(total_profit) / SUM(total_revenue) * 100,
        2
    ) AS profit_margin_pct
FROM revenue_quartiles
GROUP BY revenue_quartile
ORDER BY revenue_quartile;
