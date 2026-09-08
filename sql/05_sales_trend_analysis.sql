-- Business Question 1
-- How do monthly sales, revenue and profit change over time?

SELECT 
    YEAR(s.Date) AS sales_year,
    MONTH(s.Date) AS sales_month,
    SUM(s.Units) AS total_sales_units,
    SUM(s.Units * p.Product_Price) AS total_revenue,
    SUM(s.Units * (p.Product_Price - p.Product_Cost)) AS total_profit
FROM sales AS s
INNER JOIN products AS p
    ON p.Product_ID = s.Product_ID
GROUP BY 
    YEAR(s.Date),
    MONTH(s.Date)
ORDER BY 
    sales_year,
    sales_month;


-- Business Question 2
-- Which months generated the highest total profit?

SELECT
    sales_year,
    sales_month,
    total_profit,
    ROW_NUMBER() OVER (
        ORDER BY total_profit DESC
    ) AS profit_rank
FROM (
    SELECT 
        YEAR(s.Date) AS sales_year,
        MONTH(s.Date) AS sales_month,
        SUM(s.Units * (p.Product_Price - p.Product_Cost)) AS total_profit
    FROM sales AS s
    INNER JOIN products AS p
        ON p.Product_ID = s.Product_ID
    GROUP BY
        YEAR(s.Date),
        MONTH(s.Date)
) AS monthly_profit
ORDER BY profit_rank;


-- Business Question 3
-- How did profit change compared with the previous month?

SELECT
    sales_year,
    sales_month,
    total_profit,
    LAG(total_profit) OVER (
        ORDER BY sales_year, sales_month
    ) AS previous_month_profit,
    total_profit - LAG(total_profit) OVER (
        ORDER BY sales_year, sales_month
    ) AS profit_change
FROM (
    SELECT
        YEAR(s.Date) AS sales_year,
        MONTH(s.Date) AS sales_month,
        SUM(s.Units * (p.Product_Price - p.Product_Cost)) AS total_profit
    FROM sales AS s
    INNER JOIN products AS p
        ON p.Product_ID = s.Product_ID
    GROUP BY
        YEAR(s.Date),
        MONTH(s.Date)
) AS monthly_profit
ORDER BY
    sales_year,
    sales_month;


-- Business Question 4
-- What was the month-over-month profit growth percentage?

SELECT
    sales_year,
    sales_month,
    total_profit,
    LAG(total_profit) OVER (
        ORDER BY sales_year, sales_month
    ) AS previous_month_profit,
    ROUND(
        (total_profit - LAG(total_profit) OVER (
            ORDER BY sales_year, sales_month
        ))
        / LAG(total_profit) OVER (
            ORDER BY sales_year, sales_month
        ) * 100,
        2
    ) AS mom_profit_growth_pct
FROM (
    SELECT
        YEAR(s.Date) AS sales_year,
        MONTH(s.Date) AS sales_month,
        SUM(s.Units * (p.Product_Price - p.Product_Cost)) AS total_profit
    FROM sales AS s
    INNER JOIN products AS p
        ON p.Product_ID = s.Product_ID
    GROUP BY
        YEAR(s.Date),
        MONTH(s.Date)
) AS monthly_profit
ORDER BY
    sales_year,
    sales_month;


-- Business Question 5
-- How did monthly profit compare with the same month in the previous year?

SELECT
    sales_year,
    sales_month,
    total_profit,

    LAG(total_profit, 12) OVER (
        ORDER BY sales_year, sales_month
    ) AS previous_year_profit,

    total_profit - LAG(total_profit, 12) OVER (
        ORDER BY sales_year, sales_month
    ) AS yoy_profit_change,

    ROUND(
        (total_profit - LAG(total_profit, 12) OVER (
            ORDER BY sales_year, sales_month
        ))
        / LAG(total_profit, 12) OVER (
            ORDER BY sales_year, sales_month
        ) * 100,
        2
    ) AS yoy_profit_growth_pct

FROM (
    SELECT
        YEAR(s.Date) AS sales_year,
        MONTH(s.Date) AS sales_month,
        SUM(s.Units * (p.Product_Price - p.Product_Cost)) AS total_profit
    FROM sales AS s
    INNER JOIN products AS p
        ON p.Product_ID = s.Product_ID
    GROUP BY
        YEAR(s.Date),
        MONTH(s.Date)
) AS monthly_profit
ORDER BY
    sales_year,
    sales_month;


-- Business Question 6
-- Which months had the highest year-over-year profit growth?

SELECT
    sales_year,
    sales_month,
    total_profit,
    yoy_profit_growth_pct,
    ROW_NUMBER() OVER (
        ORDER BY yoy_profit_growth_pct DESC
    ) AS yoy_growth_rank
FROM (
    SELECT
        sales_year,
        sales_month,
        total_profit,
        ROUND(
            (total_profit - LAG(total_profit, 12) OVER (
                ORDER BY sales_year, sales_month
            ))
            / LAG(total_profit, 12) OVER (
                ORDER BY sales_year, sales_month
            ) * 100,
            2
        ) AS yoy_profit_growth_pct
    FROM (
        SELECT
            YEAR(s.Date) AS sales_year,
            MONTH(s.Date) AS sales_month,
            SUM(
                s.Units * (p.Product_Price - p.Product_Cost)
            ) AS total_profit
        FROM sales AS s
        INNER JOIN products AS p
            ON p.Product_ID = s.Product_ID
        GROUP BY
            YEAR(s.Date),
            MONTH(s.Date)
    ) AS monthly_profit
) AS yoy_analysis
ORDER BY yoy_growth_rank;


-- Business Question 7
-- Which months had the largest absolute change in profit compared with the previous month?

SELECT
    sales_year,
    sales_month,
    total_profit,
    previous_month_profit,
    profit_change,
    ROW_NUMBER() OVER (
        ORDER BY profit_change DESC
    ) AS profit_change_rank
FROM (
    SELECT
        sales_year,
        sales_month,
        total_profit,
        LAG(total_profit) OVER (
            ORDER BY sales_year, sales_month
        ) AS previous_month_profit,
        total_profit - LAG(total_profit) OVER (
            ORDER BY sales_year, sales_month
        ) AS profit_change
    FROM (
        SELECT
            YEAR(s.Date) AS sales_year,
            MONTH(s.Date) AS sales_month,
            SUM(
                s.Units * (p.Product_Price - p.Product_Cost)
            ) AS total_profit
        FROM sales AS s
        INNER JOIN products AS p
            ON p.Product_ID = s.Product_ID
        GROUP BY
            YEAR(s.Date),
            MONTH(s.Date)
    ) AS monthly_profit
) AS monthly_change
ORDER BY profit_change_rank;
