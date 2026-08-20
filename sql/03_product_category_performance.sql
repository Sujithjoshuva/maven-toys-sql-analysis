-- ============================================================
-- LESSON 3: PRODUCT AND CATEGORY PERFORMANCE ANALYSIS
-- Project: Maven Toys SQL Analysis
-- ============================================================


-- ============================================================
-- 1. PRODUCT PERFORMANCE BY UNITS SOLD
-- Business Question:
-- Which products have sold the highest number of units?
-- ============================================================

SELECT
    p.Product_ID,
    p.Product_Name,
    SUM(s.Units) AS total_units_sold
FROM sales AS s
INNER JOIN products AS p
    ON s.Product_ID = p.Product_ID
GROUP BY
    p.Product_ID,
    p.Product_Name
ORDER BY total_units_sold DESC;


-- ============================================================
-- 2. PRODUCT REVENUE ANALYSIS
-- Business Question:
-- Which products generate the highest revenue?
-- ============================================================

SELECT
    p.Product_ID,
    p.Product_Name,
    p.Product_Price,
    SUM(s.Units) AS total_units_sold,
    SUM(s.Units * p.Product_Price) AS total_revenue
FROM sales AS s
INNER JOIN products AS p
    ON s.Product_ID = p.Product_ID
GROUP BY
    p.Product_ID,
    p.Product_Name,
    p.Product_Price
ORDER BY total_revenue DESC;


-- ============================================================
-- 3. PRODUCT PROFIT ANALYSIS
-- Business Question:
-- Which products generate the highest total profit?
-- ============================================================

SELECT
    p.Product_ID,
    p.Product_Name,
    p.Product_Price,
    p.Product_Cost,
    SUM(s.Units) AS total_units_sold,
    SUM(s.Units * p.Product_Price) AS total_revenue,
    SUM(s.Units * p.Product_Cost) AS total_cost,
    SUM(s.Units * (p.Product_Price - p.Product_Cost)) AS total_profit
FROM sales AS s
INNER JOIN products AS p
    ON s.Product_ID = p.Product_ID
GROUP BY
    p.Product_ID,
    p.Product_Name,
    p.Product_Price,
    p.Product_Cost
ORDER BY total_profit DESC;


-- ============================================================
-- 4. PRODUCT PROFIT MARGIN ANALYSIS
-- Business Question:
-- Which products have the highest profit margins?
-- ============================================================

SELECT
    p.Product_ID,
    p.Product_Name,
    SUM(s.Units) AS total_units_sold,
    SUM(s.Units * p.Product_Price) AS total_revenue,
    SUM(s.Units * (p.Product_Price - p.Product_Cost)) AS total_profit,
    (
        SUM(s.Units * (p.Product_Price - p.Product_Cost))
        / SUM(s.Units * p.Product_Price)
    ) * 100 AS profit_margin
FROM sales AS s
INNER JOIN products AS p
    ON s.Product_ID = p.Product_ID
GROUP BY
    p.Product_ID,
    p.Product_Name
ORDER BY profit_margin DESC;


-- ============================================================
-- 5. CATEGORY PERFORMANCE ANALYSIS
-- Business Question:
-- How does each product category perform in units,
-- revenue, profit, and profit margin?
-- ============================================================

SELECT
    p.Product_Category,
    SUM(s.Units) AS total_units_sold,
    SUM(s.Units * p.Product_Price) AS total_revenue,
    SUM(s.Units * (p.Product_Price - p.Product_Cost)) AS total_profit,
    (
        SUM(s.Units * (p.Product_Price - p.Product_Cost))
        / SUM(s.Units * p.Product_Price)
    ) * 100 AS profit_margin
FROM products AS p
INNER JOIN sales AS s
    ON p.Product_ID = s.Product_ID
GROUP BY p.Product_Category
ORDER BY total_profit DESC;


-- ============================================================
-- 6. CATEGORY REVENUE RANKING
-- Business Question:
-- How do categories rank by total revenue?
-- ============================================================

SELECT
    Product_Category,
    total_units,
    total_profit,
    total_revenue,
    profit_margin,
    ROW_NUMBER() OVER (
        ORDER BY total_revenue DESC
    ) AS revenue_rank
FROM (
    SELECT
        p.Product_Category,
        SUM(s.Units) AS total_units,
        SUM(s.Units * (p.Product_Price - p.Product_Cost)) AS total_profit,
        SUM(s.Units * p.Product_Price) AS total_revenue,
        (
            SUM(s.Units * (p.Product_Price - p.Product_Cost))
            / SUM(s.Units * p.Product_Price)
        ) * 100 AS profit_margin
    FROM products AS p
    INNER JOIN sales AS s
        ON p.Product_ID = s.Product_ID
    GROUP BY p.Product_Category
) AS category_metrics
ORDER BY revenue_rank;


-- ============================================================
-- 7. CATEGORY PROFIT RANKING
-- Business Question:
-- How do categories rank by total profit?
-- ============================================================

SELECT
    ROW_NUMBER() OVER (
        ORDER BY total_profit DESC
    ) AS profit_rank,
    Product_Category,
    total_units,
    total_profit,
    total_revenue,
    profit_margin
FROM (
    SELECT
        p.Product_Category,
        SUM(s.Units) AS total_units,
        SUM(s.Units * (p.Product_Price - p.Product_Cost)) AS total_profit,
        SUM(s.Units * p.Product_Price) AS total_revenue,
        (
            SUM(s.Units * (p.Product_Price - p.Product_Cost))
            / SUM(s.Units * p.Product_Price)
        ) * 100 AS profit_margin
    FROM products AS p
    INNER JOIN sales AS s
        ON p.Product_ID = s.Product_ID
    GROUP BY p.Product_Category
) AS category_metrics
ORDER BY profit_rank;


-- ============================================================
-- 8. CATEGORY PROFIT MARGIN RANKING
-- Business Question:
-- How do categories rank by profit margin?
-- ============================================================

SELECT
    ROW_NUMBER() OVER (
        ORDER BY profit_margin DESC
    ) AS profit_margin_rank,
    Product_Category,
    total_units,
    total_profit,
    total_revenue,
    profit_margin
FROM (
    SELECT
        p.Product_Category,
        SUM(s.Units) AS total_units,
        SUM(s.Units * (p.Product_Price - p.Product_Cost)) AS total_profit,
        SUM(s.Units * p.Product_Price) AS total_revenue,
        (
            SUM(s.Units * (p.Product_Price - p.Product_Cost))
            / SUM(s.Units * p.Product_Price)
        ) * 100 AS profit_margin
    FROM products AS p
    INNER JOIN sales AS s
        ON p.Product_ID = s.Product_ID
    GROUP BY p.Product_Category
) AS category_metrics
ORDER BY profit_margin_rank;


-- ============================================================
-- 9. COMBINED CATEGORY PERFORMANCE RANKING
-- Business Question:
-- How does each category rank across units, revenue,
-- profit, and profit margin?
-- ============================================================

SELECT
    Product_Category,
    ROW_NUMBER() OVER (
        ORDER BY total_units DESC
    ) AS units_rank,
    ROW_NUMBER() OVER (
        ORDER BY total_revenue DESC
    ) AS revenue_rank,
    ROW_NUMBER() OVER (
        ORDER BY total_profit DESC
    ) AS profit_rank,
    ROW_NUMBER() OVER (
        ORDER BY profit_margin DESC
    ) AS profit_margin_rank,
    total_units,
    total_revenue,
    total_profit,
    profit_margin
FROM (
    SELECT
        p.Product_Category,
        SUM(s.Units) AS total_units,
        SUM(s.Units * p.Product_Price) AS total_revenue,
        SUM(s.Units * (p.Product_Price - p.Product_Cost)) AS total_profit,
        (
            SUM(s.Units * (p.Product_Price - p.Product_Cost))
            / SUM(s.Units * p.Product_Price)
        ) * 100 AS profit_margin
    FROM products AS p
    INNER JOIN sales AS s
        ON p.Product_ID = s.Product_ID
    GROUP BY p.Product_Category
) AS category_metrics
ORDER BY revenue_rank;
