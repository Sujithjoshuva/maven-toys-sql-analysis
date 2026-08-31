/*
=========================================================
Lesson 4 — Inventory Analysis
Maven Toys SQL Business Analysis
=========================================================

Objective:
Analyze product inventory relative to historical sales
to identify potential replenishment and overstock candidates.

Key metrics:
- Total stock
- Total units sold
- Inventory-to-sales ratio
- Inventory status

Benchmarks:
- Average units sold per product = 1,130.8286
- Inventory-to-sales ratio threshold = 1.0

Note:
Inventory status is a relative analytical indicator based
on the selected benchmarks. It does not confirm actual
stockout or overstock conditions.
=========================================================
*/


/*
---------------------------------------------------------
1. Product Inventory
---------------------------------------------------------
Calculate total stock available for each product
across all stores.
*/

SELECT
    p.Product_ID,
    p.Product_Name,
    p.Product_Category,
    i.total_stocks
FROM products AS p
LEFT JOIN (
    SELECT
        Product_ID,
        SUM(Stock_On_Hand) AS total_stocks
    FROM inventory
    GROUP BY Product_ID
) AS i
    ON p.Product_ID = i.Product_ID
ORDER BY total_stocks DESC;


/*
---------------------------------------------------------
2. Product Inventory vs Sales
---------------------------------------------------------
Compare total stock with total historical units sold.

Inventory and sales are aggregated separately by
Product_ID before joining to avoid row multiplication.
*/

SELECT
    p.Product_ID,
    p.Product_Name,
    p.Product_Category,
    s.total_units_sold,
    i.total_stocks,
    ROUND(
        i.total_stocks / s.total_units_sold,
        2
    ) AS inventory_to_sales_ratio
FROM products AS p

LEFT JOIN (
    SELECT
        Product_ID,
        SUM(Units) AS total_units_sold
    FROM sales
    GROUP BY Product_ID
) AS s
    ON p.Product_ID = s.Product_ID

LEFT JOIN (
    SELECT
        Product_ID,
        SUM(Stock_On_Hand) AS total_stocks
    FROM inventory
    GROUP BY Product_ID
) AS i
    ON p.Product_ID = i.Product_ID

ORDER BY inventory_to_sales_ratio;


/*
---------------------------------------------------------
3. Category-Level Inventory vs Sales
---------------------------------------------------------
Aggregate product-level inventory and sales metrics
to the product category level.
*/

SELECT
    p.Product_Category,
    SUM(i.total_stocks) AS total_stocks,
    SUM(s.total_units_sold) AS total_units_sold,
    ROUND(
        SUM(i.total_stocks) /
        SUM(s.total_units_sold),
        2
    ) AS inventory_to_sales_ratio
FROM products AS p

LEFT JOIN (
    SELECT
        Product_ID,
        SUM(Stock_On_Hand) AS total_stocks
    FROM inventory
    GROUP BY Product_ID
) AS i
    ON p.Product_ID = i.Product_ID

LEFT JOIN (
    SELECT
        Product_ID,
        SUM(Units) AS total_units_sold
    FROM sales
    GROUP BY Product_ID
) AS s
    ON p.Product_ID = s.Product_ID

GROUP BY p.Product_Category
ORDER BY inventory_to_sales_ratio;


/*
---------------------------------------------------------
4. Category Inventory Ranking
---------------------------------------------------------
Rank product categories by inventory-to-sales ratio.

Rank 1 represents the lowest ratio.
*/

SELECT
    Product_Category,
    total_stocks,
    total_units_sold,
    inventory_to_sales_ratio,
    ROW_NUMBER() OVER (
        ORDER BY inventory_to_sales_ratio
    ) AS inventory_rank
FROM (
    SELECT
        p.Product_Category,
        SUM(i.total_stocks) AS total_stocks,
        SUM(s.total_units_sold) AS total_units_sold,
        ROUND(
            SUM(i.total_stocks) /
            SUM(s.total_units_sold),
            2
        ) AS inventory_to_sales_ratio
    FROM products AS p

    LEFT JOIN (
        SELECT
            Product_ID,
            SUM(Stock_On_Hand) AS total_stocks
        FROM inventory
        GROUP BY Product_ID
    ) AS i
        ON p.Product_ID = i.Product_ID

    LEFT JOIN (
        SELECT
            Product_ID,
            SUM(Units) AS total_units_sold
        FROM sales
        GROUP BY Product_ID
    ) AS s
        ON p.Product_ID = s.Product_ID

    GROUP BY p.Product_Category
) AS category_inventory;


/*
---------------------------------------------------------
5. High Sales + Low Inventory
---------------------------------------------------------
Identify products with:
- Units sold >= 1,130.8286
- Inventory-to-sales ratio < 1.0

These are potential replenishment candidates.
*/

SELECT
    Product_ID,
    Product_Name,
    Product_Category,
    total_stocks,
    total_units_sold,
    inventory_to_sales_ratio
FROM (
    SELECT
        p.Product_ID,
        p.Product_Name,
        p.Product_Category,
        i.total_stocks,
        s.total_units_sold,
        ROUND(
            i.total_stocks / s.total_units_sold,
            2
        ) AS inventory_to_sales_ratio
    FROM products AS p

    LEFT JOIN (
        SELECT
            Product_ID,
            SUM(Stock_On_Hand) AS total_stocks
        FROM inventory
        GROUP BY Product_ID
    ) AS i
        ON p.Product_ID = i.Product_ID

    LEFT JOIN (
        SELECT
            Product_ID,
            SUM(Units) AS total_units_sold
        FROM sales
        GROUP BY Product_ID
    ) AS s
        ON p.Product_ID = s.Product_ID
) AS product_metrics

WHERE total_units_sold >= 1130.8286
  AND inventory_to_sales_ratio < 1.0

ORDER BY total_units_sold DESC;


/*
---------------------------------------------------------
6. Low Sales + High Inventory
---------------------------------------------------------
Identify products with:
- Units sold < 1,130.8286
- Inventory-to-sales ratio > 1.0

These are potential overstock candidates.
*/

SELECT
    Product_ID,
    Product_Name,
    Product_Category,
    total_stocks,
    total_units_sold,
    inventory_to_sales_ratio
FROM (
    SELECT
        p.Product_ID,
        p.Product_Name,
        p.Product_Category,
        i.total_stocks,
        s.total_units_sold,
        ROUND(
            i.total_stocks / s.total_units_sold,
            2
        ) AS inventory_to_sales_ratio
    FROM products AS p

    LEFT JOIN (
        SELECT
            Product_ID,
            SUM(Stock_On_Hand) AS total_stocks
        FROM inventory
        GROUP BY Product_ID
    ) AS i
        ON p.Product_ID = i.Product_ID

    LEFT JOIN (
        SELECT
            Product_ID,
            SUM(Units) AS total_units_sold
        FROM sales
        GROUP BY Product_ID
    ) AS s
        ON p.Product_ID = s.Product_ID
) AS product_metrics

WHERE total_units_sold < 1130.8286
  AND inventory_to_sales_ratio > 1.0

ORDER BY total_units_sold DESC;


/*
---------------------------------------------------------
7. Overall Inventory Status
---------------------------------------------------------
Classify every product into:
- Potential Replenishment
- Potential Overstock
- Normal Inventory Position
*/

SELECT
    Product_ID,
    Product_Name,
    Product_Category,
    total_stocks,
    total_units_sold,
    inventory_to_sales_ratio,

    CASE
        WHEN total_units_sold >= 1130.8286
             AND inventory_to_sales_ratio < 1.0
            THEN 'Potential Replenishment'

        WHEN total_units_sold < 1130.8286
             AND inventory_to_sales_ratio > 1.0
            THEN 'Potential Overstock'

        ELSE 'Normal Inventory Position'
    END AS inventory_analysis

FROM (
    SELECT
        p.Product_ID,
        p.Product_Name,
        p.Product_Category,
        i.total_stocks,
        s.total_units_sold,
        ROUND(
            i.total_stocks / s.total_units_sold,
            2
        ) AS inventory_to_sales_ratio

    FROM products AS p

    LEFT JOIN (
        SELECT
            Product_ID,
            SUM(Stock_On_Hand) AS total_stocks
        FROM inventory
        GROUP BY Product_ID
    ) AS i
        ON p.Product_ID = i.Product_ID

    LEFT JOIN (
        SELECT
            Product_ID,
            SUM(Units) AS total_units_sold
        FROM sales
        GROUP BY Product_ID
    ) AS s
        ON p.Product_ID = s.Product_ID
) AS inventory_summary;


/*
---------------------------------------------------------
8. Inventory Status Summary
---------------------------------------------------------
Count products in each inventory status.
*/

SELECT
    inventory_analysis,
    COUNT(*) AS product_count
FROM (
    SELECT
        Product_ID,
        Product_Name,
        Product_Category,
        total_stocks,
        total_units_sold,
        inventory_to_sales_ratio,

        CASE
            WHEN total_units_sold >= 1130.8286
                 AND inventory_to_sales_ratio < 1.0
                THEN 'Potential Replenishment'

            WHEN total_units_sold < 1130.8286
                 AND inventory_to_sales_ratio > 1.0
                THEN 'Potential Overstock'

            ELSE 'Normal Inventory Position'
        END AS inventory_analysis

    FROM (
        SELECT
            p.Product_ID,
            p.Product_Name,
            p.Product_Category,
            i.total_stocks,
            s.total_units_sold,
            ROUND(
                i.total_stocks / s.total_units_sold,
                2
            ) AS inventory_to_sales_ratio

        FROM products AS p

        LEFT JOIN (
            SELECT
                Product_ID,
                SUM(Stock_On_Hand) AS total_stocks
            FROM inventory
            GROUP BY Product_ID
        ) AS i
            ON p.Product_ID = i.Product_ID

        LEFT JOIN (
            SELECT
                Product_ID,
                SUM(Units) AS total_units_sold
            FROM sales
            GROUP BY Product_ID
        ) AS s
            ON p.Product_ID = s.Product_ID
    ) AS inventory_summary
) AS product_analysis

GROUP BY inventory_analysis
ORDER BY product_count DESC;
