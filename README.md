# Maven Toys SQL Business Analysis

## Project Overview

SQL analysis of Maven Toys retail data covering data quality, store performance, product and category performance, and inventory analysis.

The project is developed lesson by lesson, with SQL queries and business insights documented separately.

---

## Dataset

| Table | Description | Rows |
|---|---|---:|
| `products` | Product information | 35 |
| `stores` | Store information | 50 |
| `inventory` | Product stock by store | 1,593 |
| `sales` | Sales transactions | 30,000 |

---

## Lessons

| Lesson | Analysis | Key SQL Concepts | Key Findings | Files |
|---|---|---|---|---|
| **1 — Data Quality Checks** | Validated tables, records, identifiers, missing values, and duplicates before analysis. | `SELECT`, `COUNT()`, `DISTINCT`, `WHERE`, `GROUP BY`, `ORDER BY` | Dataset structure and data quality were reviewed before business analysis. | [SQL](sql/01_data_quality_checks.sql) · [Insights](insights/01_data_quality_insights.md) |
| **2 — Store Performance Analysis** | Analyzed transaction activity, units sold, basket size, and store performance. | `COUNT()`, `SUM()`, `AVG()`, `JOIN`, `CASE WHEN`, `ROW_NUMBER()`, `PARTITION BY`, Subqueries | Store 31 recorded **1,029 transactions** and an average of **1.4762 units per transaction**. **12** stores were Strong Performers. | [SQL](sql/02_store_performance_analysis.sql) · [Insights](insights/02_store_performance_insights.md) |
| **3 — Product & Category Performance** | Analyzed units, revenue, cost, profit, profit margin, and category rankings. | `SUM()`, `GROUP BY`, `JOIN`, Subqueries, `ROW_NUMBER()` | **Colorbuds** had the highest units sold (**3,916**). **Lego Bricks** had the highest product revenue (**$85,218.69**). **Electronics** had the highest category profit margin (**44.85%**). | [SQL](sql/03_product_category_performance.sql) · [Insights](insights/03_product_category_performance_insights.md) |
| **4 — Inventory Analysis** | Compared inventory with historical sales and classified inventory positions. | `LEFT JOIN`, `SUM()`, Subqueries, `CASE WHEN`, `ROW_NUMBER()`, Multi-level aggregation | **13** products were potential replenishment candidates, **17** potential overstock candidates, and **5** had a normal inventory position. | [SQL](sql/04_inventory_analysis.sql) · [Insights](insights/04_inventory_analysis_insights.md) |

---

## Skills Demonstrated

`SQL` · `JOINs` · `GROUP BY` · `HAVING` · `CASE WHEN` · `Subqueries` · `Window Functions` · `ROW_NUMBER()` · `PARTITION BY` · `Aggregations` · `Business Metrics` · `Inventory Analysis` · `Business Insights`

---

## Project Structure

```text
maven-toys-sql-analysis/
│
├── sql/
│   ├── 01_data_quality_checks.sql
│   ├── 02_store_performance_analysis.sql
│   ├── 03_product_category_performance.sql
│   └── 04_inventory_analysis.sql
│
├── insights/
│   ├── 01_data_quality_insights.md
│   ├── 02_store_performance_insights.md
│   ├── 03_product_category_performance_insights.md
│   └── 04_inventory_analysis_insights.md
│
└── README.md
