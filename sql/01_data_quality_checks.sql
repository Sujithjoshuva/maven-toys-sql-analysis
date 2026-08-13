-- ============================================================
-- Maven Toys SQL Business Analysis
-- Lesson 01: Data Understanding & Data Quality Checks
-- ============================================================

-- ============================================================
-- 1. BASELINE ROW COUNTS
-- Purpose: Establish the starting size of each table.
-- ============================================================

SELECT 'products' AS table_name, COUNT(*) AS row_count
FROM products

UNION ALL

SELECT 'stores', COUNT(*)
FROM stores

UNION ALL

SELECT 'inventory', COUNT(*)
FROM inventory

UNION ALL

SELECT 'sales', COUNT(*)
FROM sales;


-- ============================================================
-- 2. PRODUCTS — DUPLICATE PRIMARY KEY CHECK
-- Purpose: Verify that Product_ID is unique.
-- Expected result: Empty set
-- ============================================================

SELECT
    Product_ID,
    COUNT(*) AS duplicate_count
FROM products
GROUP BY Product_ID
HAVING COUNT(*) > 1;


-- ============================================================
-- 3. PRODUCTS — MISSING VALUE CHECK
-- Purpose: Check for NULL values in product fields.
-- ============================================================

SELECT
    SUM(Product_ID IS NULL) AS missing_product_id,
    SUM(Product_Name IS NULL) AS missing_product_name,
    SUM(Product_Category IS NULL) AS missing_category,
    SUM(Product_Cost IS NULL) AS missing_cost,
    SUM(Product_Price IS NULL) AS missing_price
FROM products;


-- ============================================================
-- 4. STORES — DUPLICATE PRIMARY KEY CHECK
-- Purpose: Verify that Store_ID is unique.
-- Expected result: Empty set
-- ============================================================

SELECT
    Store_ID,
    COUNT(*) AS duplicate_count
FROM stores
GROUP BY Store_ID
HAVING COUNT(*) > 1;


-- ============================================================
-- 5. STORES — MISSING VALUE CHECK
-- Purpose: Check for NULL values in store fields.
-- ============================================================

SELECT
    SUM(Store_ID IS NULL) AS missing_store_id,
    SUM(Store_Name IS NULL) AS missing_store_name,
    SUM(Store_City IS NULL) AS missing_store_city,
    SUM(Store_Location IS NULL) AS missing_store_location,
    SUM(Store_Open_Date IS NULL) AS missing_store_open_date
FROM stores;


-- ============================================================
-- 6. INVENTORY — COMPOSITE KEY DUPLICATE CHECK
-- Purpose: Verify that each Store_ID + Product_ID
-- combination appears only once.
-- Expected result: Empty set
-- ============================================================

SELECT
    Store_ID,
    Product_ID,
    COUNT(*) AS duplicate_count
FROM inventory
GROUP BY Store_ID, Product_ID
HAVING COUNT(*) > 1;


-- ============================================================
-- 7. INVENTORY — MISSING VALUE CHECK
-- Purpose: Check for NULL values in inventory fields.
-- ============================================================

SELECT
    SUM(Store_ID IS NULL) AS missing_store_id,
    SUM(Product_ID IS NULL) AS missing_product_id,
    SUM(Stock_On_Hand IS NULL) AS missing_stock
FROM inventory;


-- ============================================================
-- 8. INVENTORY → STORES — ORPHAN RECORD CHECK
-- Purpose: Verify that every inventory Store_ID exists
-- in the stores table.
-- Expected result: Empty set
-- ============================================================

SELECT DISTINCT i.Store_ID
FROM inventory AS i
LEFT JOIN stores AS s
    ON i.Store_ID = s.Store_ID
WHERE s.Store_ID IS NULL;


-- ============================================================
-- 9. INVENTORY → PRODUCTS — ORPHAN RECORD CHECK
-- Purpose: Verify that every inventory Product_ID exists
-- in the products table.
-- Expected result: Empty set
-- ============================================================

SELECT DISTINCT i.Product_ID
FROM inventory AS i
LEFT JOIN products AS p
    ON i.Product_ID = p.Product_ID
WHERE p.Product_ID IS NULL;


-- ============================================================
-- 10. SALES — DUPLICATE PRIMARY KEY CHECK
-- Purpose: Verify that Sale_ID is unique.
-- Expected result: Empty set
-- ============================================================

SELECT
    Sale_ID,
    COUNT(*) AS duplicate_count
FROM sales
GROUP BY Sale_ID
HAVING COUNT(*) > 1;


-- ============================================================
-- 11. SALES — MISSING VALUE CHECK
-- Purpose: Check for NULL values in sales fields.
-- ============================================================

SELECT
    SUM(Sale_ID IS NULL) AS missing_sale_id,
    SUM(Date IS NULL) AS missing_date,
    SUM(Store_ID IS NULL) AS missing_store_id,
    SUM(Product_ID IS NULL) AS missing_product_id,
    SUM(Units IS NULL) AS missing_units
FROM sales;


-- ============================================================
-- 12. SALES → STORES — ORPHAN RECORD CHECK
-- Purpose: Verify that every sales Store_ID exists
-- in the stores table.
-- Expected result: Empty set
-- ============================================================

SELECT DISTINCT s.Store_ID
FROM sales AS s
LEFT JOIN stores AS st
    ON s.Store_ID = st.Store_ID
WHERE st.Store_ID IS NULL;


-- ============================================================
-- 13. SALES → PRODUCTS — ORPHAN RECORD CHECK
-- Purpose: Verify that every sales Product_ID exists
-- in the products table.
-- Expected result: Empty set
-- ============================================================

SELECT DISTINCT s.Product_ID
FROM sales AS s
LEFT JOIN products AS p
    ON s.Product_ID = p.Product_ID
WHERE p.Product_ID IS NULL;


-- ============================================================
-- 14. SALES — UNITS RANGE CHECK
-- Purpose: Understand the range and average of units sold.
-- ============================================================

SELECT
    MIN(Units) AS minimum_units,
    MAX(Units) AS maximum_units,
    AVG(Units) AS average_units
FROM sales;


-- ============================================================
-- 15. SALES — INVALID UNITS CHECK
-- Purpose: Identify zero or negative sales quantities.
-- Expected result: 0
-- ============================================================

SELECT COUNT(*) AS invalid_units
FROM sales
WHERE Units <= 0;


-- ============================================================
-- 16. SALES — DATE RANGE CHECK
-- Purpose: Identify the period covered by the sales data.
-- ============================================================

SELECT
    MIN(Date) AS earliest_date,
    MAX(Date) AS latest_date
FROM sales;


-- ============================================================
-- 17. INVENTORY — STOCK RANGE CHECK
-- Purpose: Understand inventory levels.
-- ============================================================

SELECT
    MIN(Stock_On_Hand) AS minimum_stock,
    MAX(Stock_On_Hand) AS maximum_stock,
    AVG(Stock_On_Hand) AS average_stock
FROM inventory;


-- ============================================================
-- 18. INVENTORY — INVALID STOCK CHECK
-- Purpose: Identify negative inventory values.
-- Expected result: 0
-- ============================================================

SELECT COUNT(*) AS invalid_stock
FROM inventory
WHERE Stock_On_Hand < 0;


-- ============================================================
-- 19. PRODUCTS — CURRENCY FORMAT CHECK
-- Purpose: Verify that Product_Cost and Product_Price
-- consistently contain the expected dollar format.
-- ============================================================

SELECT
    COUNT(*) AS total_products,
    SUM(Product_Cost LIKE '$%') AS cost_with_dollar,
    SUM(Product_Price LIKE '$%') AS price_with_dollar
FROM products;


-- ============================================================
-- DATA QUALITY CONCLUSION
--
-- Products: 35 rows
-- Stores: 50 rows
-- Inventory: 1,593 rows
-- Sales: 30,000 rows
--
-- No duplicate primary keys were found.
-- No missing values were found.
-- No orphan Store_ID or Product_ID references were found.
-- No invalid sales quantities were found.
-- No negative inventory values were found.
--
-- Product_Cost and Product_Price are stored as VARCHAR because
-- of the currency formatting used during data import.
-- The values were verified to have consistent $ formatting.
-- No source-data correction was required.
-- ============================================================
